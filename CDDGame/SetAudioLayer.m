//
//  SetAudio.m
//  Audio_music_test
//
//  Created by apple_3 on 12-8-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SetAudioLayer.h"
#import "SimpleAudioEngine.h"
#import "PlistLoad.h"
@implementation  SetAudioLayer

@synthesize view;
@synthesize arrayMusicList;
@synthesize  musicName_selected;
@synthesize musicVolumn;
@synthesize effectVolumn;
-(id)init
{
    if (self=[super init]) {
     //支持触摸
        self.isTouchEnabled=YES;
        //背景图片
        //初始化tag列表现序号
         tag=-1;
        //设置背景音乐的音量大小
        [CDAudioManager sharedManager].backgroundMusic.volume =0.5; 
         
//        CCLayerColor* layercolor=[CCLayerColor layerWithColor:ccc4(0, 0, 0, 200)   width:200.0 height:200];
//        [self addChild:layercolor z:1];
        
//        背景
         NSString * str=[[PlistLoad loadPlist:nil] objectAtIndex:5];
        CCSprite * bg_set_audio_on = [[CCSprite alloc] initWithFile:str];
        CCSprite * bg_set_audio_off = [[CCSprite alloc] initWithFile:str];
        CCMenuItemImage * bg_set_audioItem = [CCMenuItemImage itemFromNormalSprite:bg_set_audio_on selectedSprite:bg_set_audio_off target:self selector:@selector(clickSetAudio)];
        CCMenu * bg_set_audio = [CCMenu menuWithItems:bg_set_audioItem, nil];
       
        if ([[PlistLoad returnTypeName]isEqualToString:@"Type5"]) {
            bg_set_audio.anchorPoint=CGPointZero;
        }
        else
        {
              bg_set_audio.position=CGPointMake(240, -80);
        
        }
        
        [self addChild: bg_set_audio];
        //绘制容器
        view=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
        view.hidden=NO;
        view.tag=23;
        [[[CCDirector sharedDirector] openGLView] addSubview:view];
//    [[[[CCDirector sharedDirector]openGLView]window]addSubview:view];//区别
        //绘制界面控制元素
        [self drawAudioItem];
     
        
    }
    return self;
}

-(void)clickSetAudio
{
    
}

-(void)drawAudioItem
{
    //初始化音乐下拉列表
//    [self    drawMusicList];
    //初始化控制音量声音的滚动条
  
    printf("%f,%f",self.position.x,self.position.y);
   
    float _x=170;
    float _x1=115;
    float _x2=320;
    if ([[PlistLoad returnTypeName]isEqualToString:@"Type5"]) {
        _x=_x+40;
        _x1=_x1+40;
        _x2=_x2+40;;
    }
    
    musicVolumn = [[UISlider alloc]initWithFrame:CGRectMake(_x, 123.0f, 220.0f, 15.0f)];
    [musicVolumn addTarget:self action:@selector(changeMusicVol:) forControlEvents:UIControlEventValueChanged];
    musicVolumn.maximumValue = 1.0f;
    musicVolumn.minimumValue = 0.0f;
    musicVolumn.value=0.5;
    musicVolumn = [musicVolumn autorelease];
    [view addSubview:musicVolumn];
 
    
    //初始化控制音效声音得滚动条
    effectVolumn = [[UISlider alloc]initWithFrame:CGRectMake(.0f, .0f, 238.0f, 15.0f)];
    [effectVolumn setFrame:CGRectMake(_x, 185.0f, 220.0f, 15.0f)];
    [effectVolumn addTarget:self action:@selector(changeEffectVol:) forControlEvents:UIControlEventValueChanged];
    effectVolumn.maximumValue = 1.0f;
    effectVolumn.minimumValue = 0.0f;
    effectVolumn.value=0.5;
    effectVolumn = [effectVolumn autorelease];
    [view addSubview:effectVolumn];
 
    //返回按钮
    UIButton * sureBtn_music=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn_music.frame=CGRectMake(_x1, 225.0, 65.0, 38.0);
    [sureBtn_music setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [sureBtn_music setImage:[UIImage imageNamed:@"btnreturn.png"] forState:UIControlStateSelected];
 
    [sureBtn_music addTarget:self action:@selector(clickSure_music:) forControlEvents:UIControlEventTouchUpInside];
     [view addSubview:sureBtn_music];
 
    //返回按钮or重置按钮
    UIButton * resetBtn_music=[UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn_music.frame=CGRectMake(_x2, 225.0, 65.0, 38.0);
    [resetBtn_music setImage:[UIImage imageNamed:@"resetBtn.png"] forState:UIControlStateNormal];
    [resetBtn_music setImage:[UIImage imageNamed:@"resetBtn.png"] forState:UIControlStateSelected];
    [resetBtn_music addTarget:self action:@selector(clickReset_music:) forControlEvents:UIControlEventTouchUpInside];
//    resetBtn_music.hidden = YES;
    [view addSubview:resetBtn_music];
 
   
}
-(void) changeMusicVol:(id)sender
{
//    NSLog(@"音乐声音大小为：%f",musicVolumn.value);
    [CDAudioManager sharedManager].backgroundMusic.volume = musicVolumn.value;
}

-(void) changeEffectVol:(id)sender
{
 
    [SimpleAudioEngine sharedEngine].effectsVolume = effectVolumn.value;

//      NSLog(@"音效大小为%f",effectVolumn.value);
}
-(void)clickSure_music:(id)sender//返回上一界面按钮
{
 
     [self playEffect];
    view.hidden=YES;
    self.visible=NO;
    [self  onExit]; 
}

-(void)clickPause_music:(id)sender//暂停或继续播放
{ 
    if ( [[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying]) 
    {
        [sender setSelected:YES];
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    
    }
    else
    {
        [sender setSelected:NO];
        [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];

    }
     
}

-(void)clickReset_music:(id)sender 
{
    [self playEffect];
    musicVolumn.value=0.5f;
    effectVolumn.value=0.5f;
 
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"音乐界面被点击了");
    return YES;
}

-(void)playEffect
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"];
    
}
-(void) onEnter
{
    NSLog(@"音效注册了");
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
    NSLog(@"释放注册了");
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

@end










