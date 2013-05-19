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

@implementation RankingList

@synthesize scrollViewRanking;

- (id) init
{
    if (self = [super init]) {
        //绘制排行版背景
        rankinglist_on = [[CCSprite alloc]initWithFile:@"排行榜.png"];
        rankinglist_off= [[CCSprite alloc]initWithFile:@"排行榜.png"];
        CCMenuItemImage * rankinglistMenuItem = [CCMenuItemImage itemFromNormalSprite:rankinglist_on selectedSprite:rankinglist_off target:self selector:@selector(clickMenuList)];
        CCMenu * rankinglist = [CCMenu menuWithItems:rankinglistMenuItem, nil];
        rankinglist.anchorPoint = CGPointZero;
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
        scrollViewRanking.center = CGPointMake(240.0,166.0);
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

                    
//        switch ([_userName count]) 
//        {
//            case 0:
//                
//                break;
//                
//            case 1:
//                //第一名
//                _name1 = [CCLabelTTF labelWithString:[_userName objectAtIndex:0] fontName:@"Marker Felt" fontSize:20];
//                _name1.color = ccYELLOW;
//                name1 = [CCMenuItemLabel itemWithLabel:_name1];
//                rankingName1 = [CCMenu menuWithItems:name1,nil];
//                rankingName1.position = CGPointMake(120, 240);
//                rankingName1.visible = YES;
//                [self addChild:rankingName1];
//                //分数
//                _score1 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _score1.color = ccYELLOW;
//                userScore1 = [CCMenuItemLabel itemWithLabel:_score1];
//                rankingScore1 = [CCMenu menuWithItems:userScore1,nil];
//                rankingScore1.position = CGPointMake(350, 240);
//                rankingScore1.visible = YES;
//                [self addChild:rankingScore1];
//                break;
//                
//            case 2:
//                //第一名
//                _name1 = [CCLabelTTF labelWithString:[_userName objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _name1.color = ccYELLOW;
//                name1 = [CCMenuItemLabel itemWithLabel:_name1];
//                rankingName1 = [CCMenu menuWithItems:name1,nil];
//                rankingName1.position = CGPointMake(120, 230);
//                rankingName1.visible = YES;
//                [self addChild:rankingName1];
//                //分数
//                _score1 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _score1.color = ccYELLOW;
//                userScore1 = [CCMenuItemLabel itemWithLabel:_score1];
//                rankingScore1 = [CCMenu menuWithItems:userScore1,nil];
//                rankingScore1.position = CGPointMake(350, 230);
//                rankingScore1.visible = YES;
//                [self addChild:rankingScore1];
//                
//                //第二名
//                _name2 = [CCLabelTTF labelWithString:[_userName objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _name2.color = ccYELLOW;
//                name2 = [CCMenuItemLabel itemWithLabel:_name2];
//                rankingName2 = [CCMenu menuWithItems:name2,nil];
//                rankingName2.position = CGPointMake(120, 200);
//                rankingName2.visible = YES;
//                [self addChild:rankingName2];
//                //分数
//                _score2 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _score2.color = ccYELLOW;
//                userScore2 = [CCMenuItemLabel itemWithLabel:_score2];
//                rankingScore2 = [CCMenu menuWithItems:userScore2,nil];
//                rankingScore2.position = CGPointMake(350, 200);
//                rankingScore2.visible = YES;
//                [self addChild:rankingScore2];
//                break;
//                
//            case 3:
//                //第一名
//                _name1 = [CCLabelTTF labelWithString:[_userName objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _name1.color = ccYELLOW;
//                name1 = [CCMenuItemLabel itemWithLabel:_name1];
//                rankingName1 = [CCMenu menuWithItems:name1,nil];
//                rankingName1.position = CGPointMake(120, 230);
//                rankingName1.visible = YES;
//                [self addChild:rankingName1];
//                //分数
//                _score1 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _score1.color = ccYELLOW;
//                userScore1 = [CCMenuItemLabel itemWithLabel:_score1];
//                rankingScore1 = [CCMenu menuWithItems:userScore1,nil];
//                rankingScore1.position = CGPointMake(350, 230);
//                rankingScore1.visible = YES;
//                [self addChild:rankingScore1];
//                
//                //第二名
//                _name2 = [CCLabelTTF labelWithString:[_userName objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _name2.color = ccYELLOW;
//                name2 = [CCMenuItemLabel itemWithLabel:_name2];
//                rankingName2 = [CCMenu menuWithItems:name2,nil];
//                rankingName2.position = CGPointMake(120, 200);
//                rankingName2.visible = YES;
//                [self addChild:rankingName2];
//                //分数
//                _score2 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _score2.color = ccYELLOW;
//                userScore2 = [CCMenuItemLabel itemWithLabel:_score2];
//                rankingScore2 = [CCMenu menuWithItems:userScore2,nil];
//                rankingScore2.position = CGPointMake(350, 200);
//                rankingScore2.visible = YES;
//                [self addChild:rankingScore2];
//                
//                //第三名
//                _name3 = [CCLabelTTF labelWithString:[_userName objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _name3.color = ccYELLOW;
//                name3 = [CCMenuItemLabel itemWithLabel:_name3];
//                rankingName3 = [CCMenu menuWithItems:name3,nil];
//                rankingName3.position = CGPointMake(120, 170);
//                rankingName3.visible = YES;
//                [self addChild:rankingName3];
//                //分数
//                _score3 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _score3.color = ccYELLOW;
//                userScore3 = [CCMenuItemLabel itemWithLabel:_score3];
//                rankingScore3 = [CCMenu menuWithItems:userScore3,nil];
//                rankingScore3.position = CGPointMake(350, 170);
//                rankingScore3.visible = YES;
//                [self addChild:rankingScore3];
//                break;
//                
//            case 4:
//                //第一名
//                _name1 = [CCLabelTTF labelWithString:[_userName objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _name1.color = ccYELLOW;
//                name1 = [CCMenuItemLabel itemWithLabel:_name1];
//                rankingName1 = [CCMenu menuWithItems:name1,nil];
//                rankingName1.position = CGPointMake(120, 230);
//                rankingName1.visible = YES;
//                [self addChild:rankingName1];
//                //分数
//                _score1 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _score1.color = ccYELLOW;
//                userScore1 = [CCMenuItemLabel itemWithLabel:_score1];
//                rankingScore1 = [CCMenu menuWithItems:userScore1,nil];
//                rankingScore1.position = CGPointMake(350, 230);
//                rankingScore1.visible = YES;
//                [self addChild:rankingScore1];
//                
//                //第二名
//                _name2 = [CCLabelTTF labelWithString:[_userName objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _name2.color = ccYELLOW;
//                name2 = [CCMenuItemLabel itemWithLabel:_name2];
//                rankingName2 = [CCMenu menuWithItems:name2,nil];
//                rankingName2.position = CGPointMake(120, 200);
//                rankingName2.visible = YES;
//                [self addChild:rankingName2];
//                //分数
//                _score2 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _score2.color = ccYELLOW;
//                userScore2 = [CCMenuItemLabel itemWithLabel:_score2];
//                rankingScore2 = [CCMenu menuWithItems:userScore2,nil];
//                rankingScore2.position = CGPointMake(350, 200);
//                rankingScore2.visible = YES;
//                [self addChild:rankingScore2];
//                
//                //第三名
//                _name3 = [CCLabelTTF labelWithString:[_userName objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _name3.color = ccYELLOW;
//                name3 = [CCMenuItemLabel itemWithLabel:_name3];
//                rankingName3 = [CCMenu menuWithItems:name3,nil];
//                rankingName3.position = CGPointMake(120, 170);
//                rankingName3.visible = YES;
//                [self addChild:rankingName3];
//                //分数
//                _score3 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _score3.color = ccYELLOW;
//                userScore3 = [CCMenuItemLabel itemWithLabel:_score3];
//                rankingScore3 = [CCMenu menuWithItems:userScore3,nil];
//                rankingScore3.position = CGPointMake(350, 170);
//                rankingScore3.visible = YES;
//                [self addChild:rankingScore3];
//                
//                //第四名
//                _name4 = [CCLabelTTF labelWithString:[_userName objectAtIndex:3] fontName:@"Marker Felt" fontSize:25];
//                _name4.color = ccYELLOW;
//                name4 = [CCMenuItemLabel itemWithLabel:_name4];
//                rankingName4 = [CCMenu menuWithItems:name4,nil];
//                rankingName4.position = CGPointMake(120, 140);
//                rankingName4.visible = YES;
//                [self addChild:rankingName4];
//                //分数
//                _score4 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:3] fontName:@"Marker Felt" fontSize:25];
//                _score4.color = ccYELLOW;
//                userScore4 = [CCMenuItemLabel itemWithLabel:_score4];
//                rankingScore4 = [CCMenu menuWithItems:userScore4,nil];
//                rankingScore4.position = CGPointMake(350, 140);
//                rankingScore4.visible = YES;
//                [self addChild:rankingScore4];
//                break;
//                
//            case 5:
//                //第一名
//                _name1 = [CCLabelTTF labelWithString:[_userName objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _name1.color = ccYELLOW;
//                name1 = [CCMenuItemLabel itemWithLabel:_name1];
//                rankingName1 = [CCMenu menuWithItems:name1,nil];
//                rankingName1.position = CGPointMake(120, 230);
//                rankingName1.visible = YES;
//                [self addChild:rankingName1];
//                //分数
//                _score1 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _score1.color = ccYELLOW;
//                userScore1 = [CCMenuItemLabel itemWithLabel:_score1];
//                rankingScore1 = [CCMenu menuWithItems:userScore1,nil];
//                rankingScore1.position = CGPointMake(350, 230);
//                rankingScore1.visible = YES;
//                [self addChild:rankingScore1];
//                
//                //第二名
//                _name2 = [CCLabelTTF labelWithString:[_userName objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _name2.color = ccYELLOW;
//                name2 = [CCMenuItemLabel itemWithLabel:_name2];
//                rankingName2 = [CCMenu menuWithItems:name2,nil];
//                rankingName2.position = CGPointMake(120, 200);
//                rankingName2.visible = YES;
//                [self addChild:rankingName2];
//                //分数
//                _score2 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _score2.color = ccYELLOW;
//                userScore2 = [CCMenuItemLabel itemWithLabel:_score2];
//                rankingScore2 = [CCMenu menuWithItems:userScore2,nil];
//                rankingScore2.position = CGPointMake(350, 200);
//                rankingScore2.visible = YES;
//                [self addChild:rankingScore2];
//                
//                //第三名
//                _name3 = [CCLabelTTF labelWithString:[_userName objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _name3.color = ccYELLOW;
//                name3 = [CCMenuItemLabel itemWithLabel:_name3];
//                rankingName3 = [CCMenu menuWithItems:name3,nil];
//                rankingName3.position = CGPointMake(120, 170);
//                rankingName3.visible = YES;
//                [self addChild:rankingName3];
//                //分数
//                _score3 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _score3.color = ccYELLOW;
//                userScore3 = [CCMenuItemLabel itemWithLabel:_score3];
//                rankingScore3 = [CCMenu menuWithItems:userScore3,nil];
//                rankingScore3.position = CGPointMake(350, 170);
//                rankingScore3.visible = YES;
//                [self addChild:rankingScore3];
//                
//                //第四名
//                _name4 = [CCLabelTTF labelWithString:[_userName objectAtIndex:3] fontName:@"Marker Felt" fontSize:25];
//                _name4.color = ccYELLOW;
//                name4 = [CCMenuItemLabel itemWithLabel:_name4];
//                rankingName4 = [CCMenu menuWithItems:name4,nil];
//                rankingName4.position = CGPointMake(120, 140);
//                rankingName4.visible = YES;
//                [self addChild:rankingName4];
//                //分数
//                _score4 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:3] fontName:@"Marker Felt" fontSize:25];
//                _score4.color = ccYELLOW;
//                userScore4 = [CCMenuItemLabel itemWithLabel:_score4];
//                rankingScore4 = [CCMenu menuWithItems:userScore4,nil];
//                rankingScore4.position = CGPointMake(350, 140);
//                rankingScore4.visible = YES;
//                [self addChild:rankingScore4];
//                
//                //第五名
//                _name5 = [CCLabelTTF labelWithString:[_userName objectAtIndex:4] fontName:@"Marker Felt" fontSize:25];
//                _name5.color = ccYELLOW;
//                name5 = [CCMenuItemLabel itemWithLabel:_name5];
//                rankingName5 = [CCMenu menuWithItems:name5,nil];
//                rankingName5.position = CGPointMake(120, 110);
//                rankingName5.visible = YES;
//                [self addChild:rankingName5];
//                //分数
//                _score5 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:4] fontName:@"Marker Felt" fontSize:25];
//                _score5.color = ccYELLOW;
//                userScore5 = [CCMenuItemLabel itemWithLabel:_score5];
//                rankingScore5 = [CCMenu menuWithItems:userScore5,nil];
//                rankingScore5.position = CGPointMake(350, 110);
//                rankingScore5.visible = YES;
//                [self addChild:rankingScore5];
//                break;
//                
//            default:
//                //第一名
//                _name1 = [CCLabelTTF labelWithString:[_userName objectAtIndex:0] fontName:@"Marker Felt" fontSize:20];
//                _name1.color = ccYELLOW;
////                name1 = [CCMenuItemLabel itemWithLabel:_name1];
////                rankingName1 = [CCMenu menuWithItems:name1,nil];
//                _name1.anchorPoint = CGPointZero;
//                _name1.position = CGPointMake(150, 235);
//                _name1.visible = YES;
//                [self addChild:_name1];
//                //分数
//                _score1 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:0] fontName:@"Marker Felt" fontSize:25];
//                _score1.color = ccYELLOW;
////                userScore1 = [CCMenuItemLabel itemWithLabel:_score1];
////                _score1 = [CCMenu menuWithItems:userScore1,nil];
//                _score1.anchorPoint = CGPointZero;
//                _score1.position = CGPointMake(320, 235);
//                _score1.visible = YES;
//                [self addChild:_score1];
//                
//                //第二名
//                _name2 = [CCLabelTTF labelWithString:[_userName objectAtIndex:1] fontName:@"Marker Felt" fontSize:20];
//                _name2.color = ccYELLOW;
////                name2 = [CCMenuItemLabel itemWithLabel:_name2];
////                rankingName2 = [CCMenu menuWithItems:name2,nil];
//                _name2.anchorPoint = CGPointZero;
//                _name2.position = CGPointMake(150, 200);
//                _name2.visible = YES;
//                [self addChild:_name2];
//                //分数
//                _score2 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:1] fontName:@"Marker Felt" fontSize:25];
//                _score2.color = ccYELLOW;
////                userScore2 = [CCMenuItemLabel itemWithLabel:_score2];
////                rankingScore2 = [CCMenu menuWithItems:userScore2,nil];
//                _score2.anchorPoint = CGPointZero;
//                _score2.position = CGPointMake(350, 200);
//                _score2.visible = YES;
//                [self addChild:_score2];
//                
//                //第三名
//                _name3 = [CCLabelTTF labelWithString:[_userName objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _name3.color = ccYELLOW;
////                name3 = [CCMenuItemLabel itemWithLabel:_name3];
////                rankingName3 = [CCMenu menuWithItems:name3,nil];
//                _name3.anchorPoint = CGPointZero;
//                _name3.position = CGPointMake(120, 170);
//                _name3.visible = YES;
//                [self addChild:_name3];
//                //分数
//                _score3 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:2] fontName:@"Marker Felt" fontSize:25];
//                _score3.color = ccYELLOW;
////                userScore3 = [CCMenuItemLabel itemWithLabel:_score3];
////                rankingScore3 = [CCMenu menuWithItems:userScore3,nil];
//                _score3.anchorPoint = CGPointZero;
//                _score3.position = CGPointMake(350, 170);
//                _score3.visible = YES;
//                [self addChild:_score3];
//                
//                //第四名
//                _name4 = [CCLabelTTF labelWithString:[_userName objectAtIndex:3] fontName:@"Marker Felt" fontSize:25];
//                _name4.color = ccYELLOW;
////                name4 = [CCMenuItemLabel itemWithLabel:_name4];
////                rankingName4 = [CCMenu menuWithItems:name4,nil];
//                _name4.anchorPoint = CGPointZero;
//                _name4.position = CGPointMake(120, 140);
//                _name4.visible = YES;
//                [self addChild:_name4];
//                //分数
//                _score4 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:3] fontName:@"Marker Felt" fontSize:25];
//                _score4.color = ccYELLOW;
////                userScore4 = [CCMenuItemLabel itemWithLabel:_score4];
////                rankingScore4 = [CCMenu menuWithItems:userScore4,nil];
//                _score4.anchorPoint = CGPointZero;
//                _score4.position = CGPointMake(350, 140);
//                _score4.visible = YES;
//                [self addChild:_score4];
//                
//                //第五名
//                _name5 = [CCLabelTTF labelWithString:[_userName objectAtIndex:4] fontName:@"Marker Felt" fontSize:25];
//                _name5.color = ccYELLOW;
////                name5 = [CCMenuItemLabel itemWithLabel:_name5];
////                rankingName5 = [CCMenu menuWithItems:name5,nil];
//                _name5.anchorPoint = CGPointZero;
//                _name5.position = CGPointMake(120, 110);
//                _name5.visible = YES;
//                [self addChild:_name5];
//                //分数
//                _score5 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:4] fontName:@"Marker Felt" fontSize:25];
//                _score5.color = ccYELLOW;
////                userScore5 = [CCMenuItemLabel itemWithLabel:_score5];
////                rankingScore5 = [CCMenu menuWithItems:userScore5,nil];
//                _score5.anchorPoint = CGPointZero;
//                _score5.position = CGPointMake(350, 110);
//                _score5.visible = YES;
//                [self addChild:_score5];
//                
//                //第六名
//                _name6 = [CCLabelTTF labelWithString:[_userName objectAtIndex:5] fontName:@"Marker Felt" fontSize:25];
//                _name6.color = ccYELLOW;
////                name6 = [CCMenuItemLabel itemWithLabel:_name6];
////                rankingName6 = [CCMenu menuWithItems:name6,nil];
//                _name6.anchorPoint = CGPointZero;
//                _name6.position = CGPointMake(120, 80);
//                _name6.visible = YES;
//                [self addChild:_name6];
//                //分数
//                _score6 = [CCLabelTTF labelWithString:[_userScore objectAtIndex:5] fontName:@"Marker Felt" fontSize:25];
//                _score6.color = ccYELLOW;
////                userScore6 = [CCMenuItemLabel itemWithLabel:_score6];
////                rankingScore6 = [CCMenu menuWithItems:userScore6,nil];
//                _score6.anchorPoint = CGPointZero;
//                _score6.position = CGPointMake(350, 80);
//                _score6.visible = YES;
//                [self addChild:_score6];
//                break;
//        }
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
    [scrollViewRanking setHidden:YES];
//    [scrollViewRanking release];
    self.visible = NO;
    
//    rankinglist.visible = NO;
//    sureButton1.visible = NO;
//    
//    rankingName1.visible = NO;
//    rankingScore1.visible = NO;
//    rankingName2.visible = NO;
//    rankingScore2.visible = NO;
//    rankingName3.visible = NO;
//    rankingScore3.visible = NO;
//    rankingName4.visible = NO;
//    rankingScore4.visible = NO;
//    rankingName5.visible = NO;
//    rankingScore5.visible = NO;
//    rankingName6.visible = NO;
//    rankingScore6.visible = NO;
        
//    rankingName7.visible = NO;
//    rankingScore7.visible = NO;
//    rankingName8.visible = NO;
//    rankingScore8.visible = NO;
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
