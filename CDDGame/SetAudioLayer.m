//
//  SetAudio.m
//  Audio_music_test
//
//  Created by apple_3 on 12-8-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SetAudioLayer.h"
#import "SimpleAudioEngine.h"
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
        CCSprite * bg_set_audio_on = [[CCSprite alloc] initWithFile:@"bg_set_audio222.png"];
        CCSprite * bg_set_audio_off = [[CCSprite alloc] initWithFile:@"bg_set_audio222.png"];
        CCMenuItemImage * bg_set_audioItem = [CCMenuItemImage itemFromNormalSprite:bg_set_audio_on selectedSprite:bg_set_audio_off target:self selector:@selector(clickSetAudio)];
        CCMenu * bg_set_audio = [CCMenu menuWithItems:bg_set_audioItem, nil];
        bg_set_audio.anchorPoint=CGPointZero;
        
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
//    [self drawMusicList];
    //初始化控制音量声音的滚动条
    musicVolumn = [[UISlider alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 238.0f, 15.0f)];
//    CGAffineTransform rotation = CGAffineTransformMakeRotation(1.57079633);
//    [musicVolumn setTransform:rotation];
    
    [musicVolumn setFrame:CGRectMake(170.0f, 123.0f, 220.0f, 15.0f)];
    [musicVolumn addTarget:self action:@selector(changeMusicVol:) forControlEvents:UIControlEventValueChanged];
    musicVolumn.maximumValue = 1.0f;
    musicVolumn.minimumValue = 0.0f;
    musicVolumn.value=0.5;
    musicVolumn = [musicVolumn autorelease];
    [view addSubview:musicVolumn];
 
    
    //初始化控制音效声音得滚动条
    effectVolumn = [[UISlider alloc]initWithFrame:CGRectMake(.0f, .0f, 238.0f, 15.0f)];
    [effectVolumn setFrame:CGRectMake(170.0f, 185.0f, 220.0f, 15.0f)];
    [effectVolumn addTarget:self action:@selector(changeEffectVol:) forControlEvents:UIControlEventValueChanged];
    effectVolumn.maximumValue = 1.0f;
    effectVolumn.minimumValue = 0.0f;
    effectVolumn.value=0.5;
    effectVolumn = [effectVolumn autorelease];
    [view addSubview:effectVolumn];
 
    //返回按钮
    UIButton * sureBtn_music=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn_music.frame=CGRectMake(115.0, 225.0, 65.0, 38.0);
    [sureBtn_music setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [sureBtn_music setImage:[UIImage imageNamed:@"btnreturn.png"] forState:UIControlStateSelected];
//    [sureBtn_music setTitle:@"返回" forState:UIControlStateNormal];
//    [sureBtn_music addTarget:self action:@selector(clickSure_music:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn_music addTarget:self action:@selector(clickSure_music:) forControlEvents:UIControlEventTouchUpInside];
     [view addSubview:sureBtn_music];
 
    //返回按钮or重置按钮
    UIButton * resetBtn_music=[UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn_music.frame=CGRectMake(320.0, 225.0, 65.0, 38.0);
    [resetBtn_music setImage:[UIImage imageNamed:@"resetCard.png"] forState:UIControlStateNormal];
    [resetBtn_music setImage:[UIImage imageNamed:@"resetCard.png"] forState:UIControlStateSelected];
    [resetBtn_music addTarget:self action:@selector(clickReset_music:) forControlEvents:UIControlEventTouchUpInside];
//    resetBtn_music.hidden = YES;
    [view addSubview:resetBtn_music];
 
    
    //停止播放按钮
    UIButton * pauseBtn_music=[UIButton buttonWithType:UIButtonTypeCustom];
    pauseBtn_music.frame=CGRectMake(220.0, 250.0, 50.0, 30.0);
//    [pauseBtn_music setTitle:@"播放/" forState:UIControlStateNormal];
//    [pauseBtn_music setTitle:@"/停止" forState:UIControlStateSelected];
    [pauseBtn_music setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [pauseBtn_music setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateSelected];
    [pauseBtn_music addTarget:self action:@selector(clickPause_music:) forControlEvents:UIControlEventTouchUpInside];
    pauseBtn_music.hidden = YES;
    [view addSubview:pauseBtn_music];
     
}
-(void)drawMusicList
{
     //所选歌曲显示label
    labelMusic =[[UILabel alloc] init];
    if (musicName_selected==NULL) {
        labelMusic.text=@"选择音乐";
    }
    else
    {
        labelMusic.text= musicName_selected;
    }
    labelMusic.textColor=[UIColor redColor];
//    label.font=[UIFont italicSystemFontOfSize:20];
    labelMusic.font=[UIFont fontWithName:@"Marker Felt" size:15];
    labelMusic.frame=CGRectMake(150.0, 65.0f, 140.0, 25.0);
    labelMusic.enabled=NO;
    [view addSubview:labelMusic]; 
    
   //下拉按钮
    dropBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    dropBtn.frame=CGRectMake(290.0, 65.0, 20.0, 25.0);
    [dropBtn setImage:[UIImage imageNamed:@"btnsetdown.png"] forState:UIControlStateNormal];
    [dropBtn setImage:[UIImage imageNamed:@"btnsetdown.png"] forState:UIControlStateSelected];
    [dropBtn addTarget:self action:@selector(clickDrop:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:dropBtn]; 

    //歌曲列表
    CCMenuItemLabel * musicName0;
     CCMenuItemLabel * musicName1;
     CCMenuItemLabel * musicName2;
     CCMenuItemLabel * musicName3;
     arrayMusicList=[[NSArray alloc] initWithObjects:@"爱久见人心",@"爱久见人心",@"爱久见人心",@"爱久见人心", nil];
    for (int i=0; i<4; ++i)
    {
        NSString * str=[arrayMusicList objectAtIndex:i];
         CCLabelTTF * label=[CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:25];
        label.color=ccBLACK;
        switch (i) {
            case 0:
                musicName0=[CCMenuItemLabel itemWithLabel:label target:self selector:@selector(selectMusic:)];
                musicName0.tag=i;
//                [musicName0 setColor:ccYELLOW];
                break;
            case 1:
                musicName1=[CCMenuItemLabel itemWithLabel:label target:self selector:@selector(selectMusic:)];
                musicName1.tag=i;
//                [musicName1 setColor:ccYELLOW];
                break;
            case 2:
                musicName2=[CCMenuItemLabel itemWithLabel:label target:self selector:@selector(selectMusic:)];
                musicName2.tag=i;
//                [musicName2 setColor:ccYELLOW];
                break;
            case 3:
                musicName3=[CCMenuItemLabel itemWithLabel:label target:self selector:@selector(selectMusic:)];
                musicName3.tag=i;
//                [musicName3 setColor:ccYELLOW];
                break;
            default:
                break;
        }
        
     
    }
 
    musicList=[CCMenu menuWithItems:musicName0,musicName1,musicName2,musicName3, nil];
    musicList.anchorPoint=CGPointZero;
    musicList.visible=NO;
    musicList.position=CGPointMake(240, 180);
    [musicList alignItemsVertically];
    [musicList setScale:0.7];
         
    NSLog(@"个数为%d",musicList.children.count);
     
    [self addChild:musicList z:1];
    
 
    
}
-(void)selectMusic:(id)sender
{
    int  tagTemp=[sender tag];
 
        if (tagTemp!=tag) 
        {
            if (tag<0) {
                tag=tagTemp;//保存最新
                musicName_selected=[arrayMusicList objectAtIndex:tagTemp];
                [sender setColor:[UIColor blueColor]];//更新当前
            }
            else
            {
                // 恢复上一个列表项的颜色
//                musicList 
            [[musicList.children objectAtIndex:tag] setColor:[UIColor yellowColor]];
                tag=tagTemp;//保存最新
                musicName_selected=[arrayMusicList objectAtIndex:tagTemp];//更新当前
                [sender setColor:[UIColor blueColor]];
            }
        }
 
    labelMusic.text=musicName_selected;
       NSLog(@"所选歌曲为%@",musicName_selected);
    id action0=[CCScaleTo actionWithDuration:0.3 scale:1.3];
    id action1=[CCScaleTo actionWithDuration:0.3 scale:1.0];
    [sender runAction:[CCSequence actions:action0,action1, nil]];
    //播放所选的歌曲
     [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[musicName_selected stringByAppendingString:@".mp3"] loop:1];
}
-(void)clickDrop:(id)sender
{ 
    if (musicList.visible==NO)
    {
         musicList.visible=YES;
        musicVolumn.hidden=YES;
        effectVolumn.hidden=YES;
    }
    else
    {
        musicList.visible=NO;
        musicVolumn.hidden=NO;
        effectVolumn.hidden=NO;
    }
    
   
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
//    [self.parent changeMainMetouch];
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
    musicVolumn.value=0.5f;
    effectVolumn.value=0.5f;
//    NSArray  *paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentPath= [paths objectAtIndex:0] ;//手机文件路径
//   
//  //    NSString *fullPath = [documentPath stringByAppendingString:@"/image.png"];
////    UIImage *image = [ [UIImage alloc] initWithContentsOfFile: fullPath ];
////    CCTexture2D* texture = [ [CCTexture2D alloc] initWithImage: image ];
////    CCSprite* sprite = [CCSprite spriteWithTexture: texture];
////    [[UIApplication sharedApplication] openURL:<#(NSURL *)#>];
//      
//    
////    关键是生成“文件URL”
//    
////    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUSErDomainMask, YES);  
////    NSString *documentsDirectory = [paths objectAtIndex:0];      
////    NSString *path = [documentsDirectory stringByAppendingPathComponent:docName];      
////    NSURL *url = [NSURL fileURLWithPath:path];  
////    NSURLRequest *request = [NSURLRequest requestWithURL:url];  
////    
////    self.myWebView.scalesPageToFit = YES;  
////    
////    [self.myWebView loadRequest:request];  
////    
////    如果是资源文件，则用获取路径
//    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];  
////    NSString *path = [mainBundleDirectory   stringByAppendingPathComponent:docName]; 
//    NSLog(@"path==%@",mainBundleDirectory);
//    NSString * macstr=@"/users/apple_3/desktop";
//    NSString  * home;
//    home=[@"~" stringByExpandingTildeInPath];
//    NSString *str =[home stringByAppendingString:@"/desktop"];
//    NSURL * url=[NSURL fileURLWithPath:macstr isDirectory:YES];
//    [[UIApplication sharedApplication] openURL:url];
////    [fileManager enumeratorAtPath:PATH]; 
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"音乐界面被点击了");
    return YES;
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










