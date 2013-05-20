//
//  GameMainViewContorller.m
//  CDDGame
//
//  Created by  on 12-7-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameMainViewContorller.h"
#import "SetViewController.h"
#import "CD2Database.h"
#import "PlayGameView.h"
#import "SimpleAudioEngine.h"
@implementation GameMainViewContorller

+(CCScene *)scene
{
    CCScene * scene = [CCScene node];
    GameMainViewContorller * layer = [GameMainViewContorller node];
    [scene addChild:layer];
//     [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"不能说的秘密.mp3" loop:0];
    return scene;
}

-(void) plistTest
{
    NSLog(@"MainViewControl running...");
    NSLog(@"Now trying to print the plist");
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PListDemo" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
    
    NSMutableDictionary * dicOne = [data objectForKey:@"DicOne"];
    NSNumber * IntOne = [dicOne objectForKey:@"IntOne"];
    NSLog(@"get string:%@", IntOne);
    NSLog(@"testing over.");
    return;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        [self plistTest];
        
        ///////////////////////////////////////
        database = [[CD2Database alloc]init];
        [database openDatabase];
        [database createTable];
        [database selectLastName];
        userName = database.userName1;
        NSLog(@"userName= %@",userName);
        
        if ([database isNameTableEmpty] || userName == nil)
        {
            NSLog(@"name");
            [database insertUserWithName:@"WXD"];
            [database useThisName:@"WXD"];
            [database isNameTableEmpty];//测试用
            [database selectLastName];
 
        [database closeDatabase];
        [database release];
        }
        
        //设置背景图片
        CCSprite *backGroud = [CCSprite spriteWithFile:@"png.png"];
        backGroud.anchorPoint = CGPointMake(0, 0);
        [self addChild:backGroud];        


//        CCSprite *test = [CCSprite spriteWithFile:@"player1.png"];
//        test.anchorPoint = CGPointMake(0, 0);
//        test.scale = .6;
//        [self addChild:test];
        
            //播放背景音乐
//        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"不能说的秘密.mp3" loop:0];
//            //设置背景音乐的音量大小
//        [SimpleAudioEngine sharedEngine].backgroundMusicVolume=0.3 ;

        //开始游戏按钮
        CCSprite * start_off = [CCSprite spriteWithFile:@"bt_start.png"];
        CCSprite * start_on  =[CCSprite spriteWithFile:@"bt_start.png"];
         CCMenuItemImage * gameStart = [CCMenuItemImage itemFromNormalSprite:start_off selectedSprite:start_on target:self selector:@selector(clickStart)];
        //游戏设置
        CCSprite * setting_off = [CCSprite spriteWithFile:@"bt_setting.png"];
        CCSprite * setting_on  = [CCSprite spriteWithFile:@"bt_setting.png"];
        CCMenuItemImage * gameSetting = [CCMenuItemImage itemFromNormalSprite:setting_off selectedSprite:setting_on target:self selector:@selector(clickSetting)];
        //添加到列表
        CCMenu * startsettingMenu = [CCMenu menuWithItems:gameStart,gameSetting, nil];
        [startsettingMenu alignItemsVerticallyWithPadding:35];
        startsettingMenu.scale = .6;
        startsettingMenu.position = CGPointMake(290.0f,100.0f);
        [self addChild:startsettingMenu];
        
        //帮助按钮
        CCSprite * help_off = [CCSprite spriteWithFile:@"help.png"];
        CCSprite * help_on  = [CCSprite spriteWithFile:@"help.png"];
        CCMenuItemImage * gameHelp = [CCMenuItemImage itemFromNormalSprite:help_off selectedSprite:help_on target:self selector:@selector(clickHelp)];
        //关于按钮
        CCSprite * about_off = [CCSprite spriteWithFile:@"about.png"];
        CCSprite * about_on  = [CCSprite spriteWithFile:@"about.png"];
        CCMenuItemImage * gameAbout = [CCMenuItemImage itemFromNormalSprite:about_off selectedSprite:about_on target:self selector:@selector(clickAbout)];
        //添加到列表
        CCMenu * helpaboutMain = [CCMenu menuWithItems:gameHelp,gameAbout, nil];
        [helpaboutMain alignItemsHorizontallyWithPadding:110];
        helpaboutMain.scale = .4;
        helpaboutMain.position = CGPointMake(240.0f,-30.0f);
        [self addChild:helpaboutMain];
        
        NSUserDefaults * gameEnd1 = [NSUserDefaults standardUserDefaults];
        [gameEnd1 removeObjectForKey:@"allScore"];
        
        CCSprite * about_1 = [CCSprite spriteWithFile:@"关于我们1.png"];
        CCSprite * about_2 = [CCSprite spriteWithFile:@"关于我们1.png"];
        CCMenuItemImage * about_3 = [CCMenuItemImage itemFromNormalSprite:about_1 selectedSprite:about_2 target:self selector:@selector(clickNil)];
        about = [CCMenu menuWithItems:about_3, nil];
        about.position = CGPointMake(240.0f, 160.0f);
        about.visible  = NO;
        [self addChild:about  z:3];
        
        CCSprite * goBack_1 = [CCSprite spriteWithFile:@"return.png"];
        CCSprite * goBack_2 = [CCSprite spriteWithFile:@"btnreturn.png"];
        CCMenuItemImage * goBack_3 = [CCMenuItemImage itemFromNormalSprite:goBack_1 selectedSprite:goBack_2 target:self selector:@selector(clickBack)];
        goBack = [CCMenu menuWithItems:goBack_3, nil];
        goBack.scale = .5f;
        goBack.position = CGPointMake(-85,220);
        goBack.visible = NO;        
        [self addChild:goBack  z:3];

        
//        //滚动试图
//        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 100.0f)];//设置可视化界面大小
//        scrollView.pagingEnabled=YES;
////        scrollView.backgroundColor = [UIColor whiteColor];
//        scrollView.center = CGPointMake(240.0,100.0);
//        int test = 100;
//        scrollView.contentSize = CGSizeMake(480, test);//真实大小
//        scrollView.alwaysBounceVertical = YES;//支持上下滑动
//        scrollView.hidden = NO;
//        [[[CCDirector sharedDirector]openGLView]addSubview:scrollView];
//         
//        int index = 5;
//        NSString * tempScore = [NSString stringWithFormat:@"%d",index];
//        UILabel * showScore = [[UILabel alloc]init];
//        showScore.text = tempScore;
////        showScore.pagingEnabled = YES;
//        showScore.textAlignment = UITextAlignmentCenter;
//        showScore.backgroundColor = [UIColor lightTextColor];
//        showScore.textColor = [UIColor blueColor];
////        showScore.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
//        [showScore setFrame:CGRectMake(200.0f,0.0f, 50.0f, 24.0f)];
//        [scrollView addSubview:showScore];
//        
//        UILabel * showScore2 = [[UILabel alloc]init];
//        showScore2.text = tempScore;
//        showScore2.textAlignment = UITextAlignmentCenter;
//        showScore2.backgroundColor = [UIColor lightTextColor];
//        showScore2.textColor = [UIColor whiteColor];
//        //        showScore.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
//        [showScore2 setFrame:CGRectMake(200.0f,100.0f, 50.0f, 24.0f)];
//        [scrollView addSubview:showScore2];
//        
    }
    return self;

}

//- (void)viewDidLoad {
//	[super viewDidLoad];
//    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"不能说的秘密.mp3" loop:0];
//}

-(void)clickStart
{
        CCScene *scene=[CCScene node];
        [scene addChild: [PlayGameView  scene]];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:scene ]];
}
 
-(void) clickSetting
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.3f scene:[SetViewController scene]]];
}

-(void) clickHelp
{
    Regular * regular=[Regular node];
    [self addChild:regular];
}

-(void) clickAbout
{
    about.visible  = YES;
    goBack.visible = YES;        
}

-(void)clickBack
{
    about.visible  = NO;
    goBack.visible = NO;        
}

-(void)clickNil
{
    
}
@end
