//
//  RankingList.m
//  CDDGame
//
//  Created by  on 12-8-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RankingList.h"
#import "CD2Database.h"
#import "PlayGameView.h"
#import "SimpleAudioEngine.h"
#import "PlistLoad.h"
@implementation RankingList

@synthesize scrollViewRanking;

- (id) init
{
    if (self = [super init]) {
        //绘制排行版背景
        NSString * str=[[PlistLoad loadPlist:nil] objectAtIndex:7];
        rankinglist_on = [[CCSprite alloc]initWithFile:str];
        rankinglist_off= [[CCSprite alloc]initWithFile:str];
        CCMenuItemImage * rankinglistMenuItem = [CCMenuItemImage itemFromNormalSprite:rankinglist_on selectedSprite:rankinglist_off target:self selector:@selector(clickMenuList)];
        CCMenu * rankinglist = [CCMenu menuWithItems:rankinglistMenuItem, nil];
//        rankinglist.anchorPoint = CGPointZero;
        
        float _x=240;
        
        if ([[PlistLoad returnTypeName]isEqualToString:@"Type5"]) {
            _x=_x+44;
        }
        rankinglist.position=CGPointMake(_x, 160);
        rankinglist.visible = YES;
        [self addChild:rankinglist z:0];
        //返回按钮
        CCSprite * sureButton_off = [CCSprite spriteWithFile:@"btback2.png"];
        CCSprite * sureButton_on  = [CCSprite spriteWithFile:@"btback2.png"];
        CCMenuItemImage * sureButton = [CCMenuItemImage itemFromNormalSprite:sureButton_off selectedSprite:sureButton_on target:self selector:@selector(clickSureButton)];
        sureButton1 = [CCMenu menuWithItems:sureButton, nil];
        sureButton1.scale = .6f;
        sureButton1.position = CGPointMake(332,-42);
        sureButton1.visible = YES;
        [self addChild:sureButton1 z:0];
        
        //添加排行版名字分数
        database = [[CD2Database alloc] init];
        [database openDatabase];
        [database createTable];
        [database selectLastName];
        int score = database.score;
        [database updateUserEndScore:database.userName1 withScore:score+100];
        NSMutableArray * _userName = [[NSMutableArray alloc]init];
//        NSMutableArray * _userName;
        NSLog(@"%d",[[database getRankingName] count]);
        _userName = [database getRankingName];
        NSMutableArray * _userScore = [[NSMutableArray alloc]init];
        _userScore = [database getRankingScore];
        
        //滚动试图
        scrollViewRanking = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 340.0f, 170)];//设置可视化界面大小
        scrollViewRanking.pagingEnabled=YES;
//        scrollViewRanking.backgroundColor = [UIColor whiteColor];
        scrollViewRanking.center = CGPointMake(_x,166.0);
        int line = _userName.count;//列数
//        int line =10;//列数
        scrollViewRanking.contentSize = CGSizeMake(340, line*35);//真实大小
        scrollViewRanking.alwaysBounceVertical = YES;//支持上下滑动
        scrollViewRanking.hidden = NO;
        [[[CCDirector sharedDirector]openGLView]addSubview:scrollViewRanking];
        //显示得分版
        for (int i = 0; i < line; i++) {
            //显示名次
            UILabel * showTurns = [[UILabel alloc]init];
            NSString * tempScore1 = [NSString stringWithFormat:@"%d",i+1];
            showTurns.text = tempScore1;
            showTurns.textAlignment = UITextAlignmentCenter;
            [showTurns setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            showTurns.backgroundColor = [UIColor lightTextColor];
            showTurns.textColor = [UIColor yellowColor];
            //            showScore.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
            [showTurns setFrame:CGRectMake(10,i*34, 40, 33)];
            [scrollViewRanking addSubview:showTurns];
            
            //显示姓名
            UILabel * showName1 = [[UILabel alloc]init];
//            NSString * showName2 = [NSString stringWithFormat:@"%ld",5555555555];
            showName1.text = [_userName objectAtIndex:i];
            showName1.textAlignment = UITextAlignmentCenter;
            [showName1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            showName1.backgroundColor = [UIColor lightTextColor];
            showName1.textColor = [UIColor yellowColor];
            //            showScore.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
            [showName1 setFrame:CGRectMake(51,i*34, 125, 33)];
            [scrollViewRanking addSubview:showName1];
            
            //显示金币数
            UILabel * showScore1 = [[UILabel alloc]init];
//            NSString * showScore2 = [NSString stringWithFormat:@"%ld",-5555555555];
            showScore1.text = [_userScore objectAtIndex:i];
            showScore1.textAlignment = UITextAlignmentCenter;
            [showScore1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            showScore1.backgroundColor = [UIColor lightTextColor];
            showScore1.textColor = [UIColor yellowColor];
            //            showScore.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
            [showScore1 setFrame:CGRectMake(177,i*34, 125, 33)];
            [scrollViewRanking addSubview:showScore1];
        }

        [database closeDatabase];
        [database release];       
        [_userScore release];
        [_userName release];
    }
    
    return self;
}

-(void)clickMenuList
{
    [scrollViewRanking setHidden:NO];
}

- (void) clickSureButton
{
 
    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"];
 
//    [self.parent PlayEffect];
    [scrollViewRanking setHidden:YES];
 
    self.visible = NO;

    database = [[CD2Database alloc]init];
    [database openDatabase];
    [database createTable];
    [database selectLastName];
    int score = database.score;
    NSLog(@"the score is  %d",score);
    [database updateUserEndScore:database.userName1 withScore:score-100];
    [database closeDatabase];
    [database release];

}

- (void)dealloc
{
    [super dealloc];
}

@end
