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
#import "PlistLoad.h"
@implementation GameMainViewContorller
@synthesize  positionGetter1;
+(CCScene *)scene
{
    CCScene * scene = [CCScene node];
    GameMainViewContorller * layer = [GameMainViewContorller node];
    [scene addChild:layer];
//     [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"不能说的秘密.mp3" loop:0];
    return scene;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        imageArray=[PlistLoad loadPlist:nil];
        positionGetter1 = [[PositionGetter alloc] initWithPlistName:@"MainViewInfo"];
        
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
        CCSprite *backGroud = [CCSprite spriteWithFile:[imageArray objectAtIndex:0]];
        backGroud.anchorPoint = CGPointMake(0, 0);
        [positionGetter1 setElementPosition:backGroud sign:@"backGroud"];
        [self addChild:backGroud];        

        //开始游戏按钮
        CCSprite * start_off = [CCSprite spriteWithFile:@"bt_start.png"];
        CCSprite * start_on  =[CCSprite spriteWithFile:@"bt_start.png"];
        gameStart = [CCMenuItemImage itemFromNormalSprite:start_off selectedSprite:start_on target:self selector:@selector(clickStart)];
        //游戏设置
        CCSprite * setting_off = [CCSprite spriteWithFile:@"bt_setting.png"];
        CCSprite * setting_on  = [CCSprite spriteWithFile:@"bt_setting.png"];
        gameSetting = [CCMenuItemImage itemFromNormalSprite:setting_off selectedSprite:setting_on target:self selector:@selector(clickSetting)];
        //添加到列表
        CCMenu * startsettingMenu = [CCMenu menuWithItems:gameStart,gameSetting, nil];
        [startsettingMenu alignItemsVerticallyWithPadding:35];
        //startsettingMenu.scale = .6;
        //startsettingMenu.position = CGPointMake(290.0f,100.0f);
        [positionGetter1 setElementPosition:startsettingMenu sign:@"Menu"];
        [self addChild:startsettingMenu];
        
        //帮助按钮
        CCSprite * help_off = [CCSprite spriteWithFile:@"help.png"];
        CCSprite * help_on  = [CCSprite spriteWithFile:@"help.png"];
        gameHelp = [CCMenuItemImage itemFromNormalSprite:help_off selectedSprite:help_on target:self selector:@selector(clickHelp)];
        //关于按钮
        CCSprite * about_off = [CCSprite spriteWithFile:@"about.png"];
        CCSprite * about_on  = [CCSprite spriteWithFile:@"about.png"];
        gameAbout = [CCMenuItemImage itemFromNormalSprite:about_off selectedSprite:about_on target:self selector:@selector(clickAbout)];
        //添加到列表
        CCMenu * helpaboutMain = [CCMenu menuWithItems:gameHelp,gameAbout, nil];
        [helpaboutMain alignItemsHorizontallyWithPadding:110];
        //helpaboutMain.scale = .4;
        //helpaboutMain.position = CGPointMake(240.0f,-30.0f);
        [positionGetter1 setElementPosition:helpaboutMain sign:@"Help"];
        [self addChild:helpaboutMain];
        
        NSUserDefaults * gameEnd1 = [NSUserDefaults standardUserDefaults];
        [gameEnd1 removeObjectForKey:@"allScore"];
        
        
         NSString * str=[[PlistLoad loadPlist:nil] objectAtIndex:8];
        CCSprite * about_1 = [CCSprite spriteWithFile:str];
        CCSprite * about_2 = [CCSprite spriteWithFile:str];
        CCMenuItemImage * about_3 = [CCMenuItemImage itemFromNormalSprite:about_1 selectedSprite:about_2 target:self selector:@selector(clickNil)];
        about = [CCMenu menuWithItems:about_3, nil];
        //about.position = CGPointMake(240.0f, 160.0f);
        [positionGetter1 setElementPosition:about sign:@"About"];
        about.visible  = NO;
        [self addChild:about  z:3];
        
        CCSprite * goBack_1 = [CCSprite spriteWithFile:@"return.png"];
        CCSprite * goBack_2 = [CCSprite spriteWithFile:@"btnreturn.png"];
        CCMenuItemImage * goBack_3 = [CCMenuItemImage itemFromNormalSprite:goBack_1 selectedSprite:goBack_2 target:self selector:@selector(clickBack)];
        goBack = [CCMenu menuWithItems:goBack_3, nil];
        //goBack.scale = 0.5f;
        //goBack.position = CGPointMake(100,150);
        [positionGetter1 setElementPosition:goBack sign:@"Goback"];
        goBack.visible = NO;
        [self addChild:goBack  z:3];
    
   
    }
    return self;

}

-(void)clickStart
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[PlayGameView scene]]];
    NSLog(@"start");
    [self playEffect];
}
 
-(void) clickSetting
{
    [self setEnableNo];
    [[CCDirector sharedDirector] replaceScene:[SetViewController scene]];
    [self playEffect];
}

-(void) clickHelp
{
    [self setEnableNo];
    Regular * regular=[Regular node];
    regular.delegate=self;
    [self addChild:regular];
    [self playEffect];
}

-(void) clickAbout//关于我们
{
    [self setEnableNo];
    about.visible  = YES;
    goBack.visible = YES;
     [self playEffect];
}

-(void)clickBack//关于我们返回
{
    [self setEnableYes];
    about.visible  = NO;
    goBack.visible = NO;
     [self playEffect];
    
}
-(void)clickNil
{
    
}
-(void)playEffect
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"];
    
}
-(void)setEnableYes//显示主界面按钮
{
    printf("启用按钮");
    [gameStart setIsEnabled:YES];
    [gameSetting setIsEnabled:YES];
    [gameAbout setIsEnabled:YES];
    [gameHelp setIsEnabled:YES];
}
-(void)setEnableNo//显示主界面按钮
{
    [gameStart setIsEnabled:NO];
    [gameSetting setIsEnabled:NO];
    [gameAbout setIsEnabled:NO];
    [gameHelp setIsEnabled:NO];
    
}
-(void)dealloc
{
 
    [imageArray release];
     [positionGetter1.dic release];
     [positionGetter1 release];
    [super dealloc];
     NSLog(@"delloc3");
    
}

@end
