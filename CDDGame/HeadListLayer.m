//
//  HeadListLayer.m
//  head_test
//
//  Created by apple_3 on 12-8-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "HeadListLayer.h"
#import "SimpleAudioEngine.h"
#import "PlistLoad.h"
#import "PositionGetter.h"
@implementation HeadListLayer
@synthesize  delegate;

#define _width 480

-(id)init
{
    if (self=[super init])
    {
      //设置可触摸
       self.isTouchEnabled=YES;	
        //背景图片
 
        NSString * str=[[PlistLoad loadPlist:nil] objectAtIndex:3];
        
        CCSprite * bg=[[CCSprite alloc] initWithFile:str];//
//        CCSprite * bg=[[CCSprite alloc] init];//创建无图的精灵
        bg.anchorPoint=CGPointZero;
//         bg.contentSize=CGSizeMake(480.0f, 320.0f);
//        bg.textureRect=CGRectMake(0.0f, 0.0f, 480.0f, 160.0f);
         [self addChild:bg z:3];
        [bg release];

        //绘制容器
        viewHead=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _width, 320.0f)] ;
        viewHead.hidden=NO;      
        [[[CCDirector sharedDirector] openGLView] addSubview:viewHead];//添加视图的常用方法

         //绘制头像
        [self drawHead];
    // 初始化
        select_index=-1;
    
    }
    return self;
}
-(void)drawHead
{
    
    //滚动试图
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _width, 225.0f)];//设置可视化界面大小
    scrollView.pagingEnabled=YES;
    scrollView.center=CGPointMake(scrollView.frame.size.width/2,168.0);
    
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width, 225);//真实大小
    scrollView.alwaysBounceVertical=YES;//支持上下滑动
    scrollView.hidden=NO;
    [viewHead addSubview:scrollView];
    
    //确定按钮
    surebtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [surebtn setFrame:CGRectMake(420, 280, 60, 40)];
    
    [surebtn setImage:[UIImage imageNamed:@"sureButton.png"] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [viewHead addSubview:surebtn];
    
     //显示头像
    headImgArry=[NSArray  arrayWithObjects:@"./head/1.png",@"./head/2.png",@"./head/3.png",@"./head/4.png",@"./head/5.png",@"./head/6.png",@"./head/7.png",@"./head/8.png",@"./head/9.png", nil  ];
 
    
    float _x=150;
    NSString * strtype=[PlistLoad returnTypeName];
    NSLog(@"ss=%@",strtype);
    if ([strtype isEqualToString:@"Type5"]) {
        _x=190;
    }
    for (int i=0; i<headImgArry.count; ++i) 
    {  
        //循环生成头像按钮
        NSString  * str=[headImgArry objectAtIndex:i];
        UIImage *img=[UIImage imageNamed:str ] ;
    
        //写一个UIbutton用于头像点击
        headBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
        //判断分行
        if (i<=2) 
        {
            [headBtn setFrame: CGRectMake (_x+i*60.0, 15.0f, 60.0f, 70.0f)];//横向增量是60.0 纵向增量是70.0
        }
        else if (i<=5) {
            [headBtn setFrame: CGRectMake (_x+(i-3)*60.0, 85.0f, 60.0f, 70.0f)];
        }
        else if (i<=8) {
            [headBtn setFrame: CGRectMake (_x+(i-6)*60.0, 155.0f, 60.0f, 70.0f)];
        }
 
        
        [headBtn setTitle:str forState:UIControlStateNormal];
        [headBtn setTag:i];
        [headBtn setImage:img forState:UIControlStateNormal];
        [headBtn setSelected:NO];
        [headBtn setBackgroundColor:[UIColor clearColor]];
        
        [headBtn addTarget:self action:@selector(selectHead:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:headBtn];  
    }
    
 
}

-(void)selectHead:(id)sender//保存两个变量select_index和select_img
{
    
    int temp_select_index=[sender tag];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 }); 
    if (select_index==-1)
    {       
        select_index=[sender tag];
        select_img=[sender titleForState:UIControlStateNormal];

    }
    if (temp_select_index!=select_index&&select_index!=-1)
    {
        UIButton * btn=[scrollView.subviews objectAtIndex:select_index];
        [btn.layer setBorderWidth:0];
     
        select_index=[sender tag];
        select_img=[sender titleForState:UIControlStateNormal];
        [sender setSelected:YES];
     }
    UIButton * btn1=[scrollView.subviews objectAtIndex:select_index];
//    [btn1.layer setMasksToBounds:YES];
    [btn1.layer setBorderWidth:2.0];
    [btn1.layer setBorderColor:colorref];

    NSLog(@"select_index=%d",select_index);
    NSLog(@"select_title=%@",select_img);
    [self playEffect];

}
-(void)clickSureBtn:(id)sender
{
    NSLog(@"提交的图片：%@",select_img);
    NSLog(@"提交的图片index：%d",select_index);
    if (select_img!=NULL)
    {
        switch (select_index)
        {
            case 0:
            {
                select_img=@"./head/body/1.png";
                break;
            }
            case 1:
            {
                select_img=@"./head/body/2.png";
                break;
            }
            case 2:
            {
                select_img=@"./head/body/3.png";
                break;
            }
            case 3:
            {
                select_img=@"./head/body/4.png";
                break;
            }
            case 4:
            {
                select_img=@"./head/body/5.png";
                break;
            }
            case 5:
            {
                select_img=@"./head/body/6.png";
                break;
            }
            case 6:
            {
                select_img=@"./head/body/7.png";
                break;
            }
            case 7:
            {
                select_img=@"./head/body/8.png";
                break;
            }
            case 8:
            {
                select_img=@"./head/body/9.png";
                break;
            }
            default:
//                NSLog(@"index为：%@",select_index);
                break;
        }
        NSLog(@"更新的图片：%@",select_img);
        
//        [self.parent updateHead:select_img ];//强制调用父类

    }
    [self playEffect];
//    [self.parent updateHead:select_img ];//强制调用父类
    [self.delegate updateHead:select_img];
     [viewHead setHidden:YES];
 
 
    [self removeFromParentAndCleanup:YES];
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"headlayer 被单击了");
    return  YES;
}
-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super registerWithTouchDispatcher];
}
-(void)playEffect
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/sound_tap.wav"];
    
}

@end
