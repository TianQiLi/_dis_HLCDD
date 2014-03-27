//
//  Regular.m
//  regular
//
//  Created by  on 12-9-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Regular.h"
#import "GameMainViewContorller.h"
#import "SimpleAudioEngine.h"
#import "PlistLoad.h"
@implementation Regular
@synthesize delegate;
@synthesize controller;
+(CCScene *) scene
{
	 	CCScene *scene = [CCScene node];
	 	Regular *layer = [Regular node];
	 	[scene addChild: layer];
 	    return scene;
}
-(void)playEffect:(int)num
{
    if (num==1) {//单击
        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav" ];
    }
    else if(num==2)//左右滑动
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/sound_swipe.wav" ];
    
    }
  

}
-(id)init
{
    if (self==[super init])
    {
        _navX = 55;
        if ([[PlistLoad returnTypeName]isEqualToString:@"Type5"]) {
            _navX =_navX +36;//40//按钮列表层
        }
        
        _navY = 36;
        _currentPage=1;
        _currentText=1;
        _nextPage=0;
        [self drawTextView];
    }
    return self;
}
-(void) initHomeView
{
    NSString * str=[[PlistLoad loadPlist:nil] objectAtIndex:6];
    UIImage *tempImage=[UIImage imageNamed:str];
    _homeView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _homeView.image=tempImage;
    [[[CCDirector sharedDirector] openGLView] addSubview:_homeView];
    [_homeView release];
    
}

-(void)nextNav
{
    _navX += 72;
}
-(void) initFirstButton
{
    UIImage *tempImage=[UIImage imageNamed:@"abstractBtn.png"];
    _firstButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_firstButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"abstractBtned.png"];
    [_firstButton setImage:tempImage forState:UIControlStateHighlighted];
    [_firstButton setImage:tempImage forState:UIControlStateSelected];
    
    _firstButton.frame=CGRectMake(_navX, _navY, tempImage.size.width/2, tempImage.size.height/2);
    [self nextNav];
    [_firstButton addTarget:self action:@selector(changeFirstPage:) forControlEvents:UIControlEventTouchUpInside];
    //    _navX += tempImage.size.width;
    [[[CCDirector sharedDirector] openGLView] addSubview:_firstButton];
    
   

}
-(void) initSecondButton
{
    [pageC setNumberOfPages:1];
    UIImage *tempImage=[UIImage imageNamed:@"gestureBtn.png"];
    _secondButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_secondButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"gestureBtned.png"];
    [_secondButton setImage:tempImage forState:UIControlStateHighlighted];
    [_secondButton setImage:tempImage forState:UIControlStateSelected];
    _secondButton.frame=CGRectMake(_navX, _navY, tempImage.size.width/2, tempImage.size.height/2);
    [self nextNav];
    [_secondButton addTarget:self action:@selector(changeSecondPage:) forControlEvents:UIControlEventTouchUpInside];
    //    _navX += tempImage.size.width;
    [[[CCDirector sharedDirector] openGLView] addSubview:_secondButton];
}

-(void) initThirdButton
{
    [pageC setNumberOfPages:3];
    UIImage *tempImage=[UIImage imageNamed:@"regularBtn.png"];
    _thirdButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_thirdButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"regularBtned.png"];
    [_thirdButton setImage:tempImage forState:UIControlStateHighlighted];
    [_thirdButton setImage:tempImage forState:UIControlStateSelected];
    _thirdButton.frame=CGRectMake(_navX, _navY, tempImage.size.width/2, tempImage.size.height/2);
    [self nextNav];
    [_thirdButton addTarget:self action:@selector(changeThirdPage:) forControlEvents:UIControlEventTouchUpInside];
    //    _navX += tempImage.size.width;
    [[[CCDirector sharedDirector] openGLView] addSubview:_thirdButton];
}

-(void) initForthButton
{
    [pageC setNumberOfPages:3];
    UIImage *tempImage=[UIImage imageNamed:@"typeBtn.png"];
    _forthButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_forthButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"typeBtned.png"];
    [_forthButton setImage:tempImage forState:UIControlStateHighlighted];
    [_forthButton setImage:tempImage forState:UIControlStateSelected];
    _forthButton.frame=CGRectMake(_navX, _navY, tempImage.size.width/2, tempImage.size.height/2);
    [self nextNav];
    [_forthButton addTarget:self action:@selector(changeForthPage:) forControlEvents:UIControlEventTouchUpInside];
    //    _navX += tempImage.size.width;
    [[[CCDirector sharedDirector] openGLView] addSubview:_forthButton];
}
-(void) initFifthButton
{
    [pageC setNumberOfPages:3];
    UIImage *tempImage=[UIImage imageNamed:@"scoreBtn.png"];
    _fifthButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_fifthButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"scoreBtned.png"];
    [_fifthButton setImage:tempImage forState:UIControlStateHighlighted];
    [_fifthButton setImage:tempImage forState:UIControlStateSelected];
    _fifthButton.frame=CGRectMake(_navX, _navY, tempImage.size.width/2, tempImage.size.height/2);
    [self nextNav];
    [_fifthButton addTarget:self action:@selector(changeFifthPage:) forControlEvents:UIControlEventTouchUpInside];
    //    _navX += tempImsage.size.width;
    [[[CCDirector sharedDirector] openGLView] addSubview:_fifthButton];
}
- (void) initText
{
    
    UIImage *tempImage=[UIImage imageNamed: @"abstract.png"];
//    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d",_currentPage,_currentText]];
    
    float _x=0;
    if ([[PlistLoad returnTypeName]isEqualToString:@"Type5"]) {
        _x=_x+40;
    }
    _textViewCurrentPage=[[UIImageView alloc]initWithFrame:CGRectMake(_x, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewCurrentPage.image=tempImage;
    _firstButton.selected=YES;
    _secondButton.selected=NO;
    _thirdButton.selected=NO;
    _forthButton.selected=NO;
    _fifthButton.selected=NO;
    UISwipeGestureRecognizer *oneFingerSwipLeft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipLeft:)];
    [oneFingerSwipLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    UISwipeGestureRecognizer *oneFingerSwipRight=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipRight:)];
    [oneFingerSwipRight setDirection:UISwipeGestureRecognizerDirectionRight];
    _text=[[UIView alloc]initWithFrame:CGRectMake(TEXT_POSITION_X, TEXT_POSITION_Y, tempImage.size.width/2, tempImage.size.height/2)];
    [_text addGestureRecognizer:oneFingerSwipLeft];
    [oneFingerSwipLeft release];
    [_text addGestureRecognizer:oneFingerSwipRight];
    [oneFingerSwipRight release];
    _text.userInteractionEnabled=YES;
    [_text addSubview:_textViewCurrentPage];
    [_textViewCurrentPage release];
    [[[CCDirector sharedDirector] openGLView] addSubview:_text];
    
    pageC=[[UIPageControl alloc] initWithFrame:CGRectMake(190,288, 100, 50)];//添加pageC
    [pageC setNumberOfPages:1];
    [[[CCDirector sharedDirector] openGLView] addSubview:pageC];
    [pageC release];
}

///////////////////////////////////
//logical code


- (void)changeFirstPage:(id) sender
{
    
    [pageC setNumberOfPages:1];
    _nextPage=1;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
//    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    
    
    UIImage *tempImage=[UIImage imageNamed:@"abstract.png"];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(_textViewCurrentPage.frame.origin.x, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    [_textViewNextPage release];
    
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=YES;
    _secondButton.selected=NO;
    _thirdButton.selected=NO;
    _forthButton.selected=NO;
    _fifthButton.selected=NO;
    _nextPage=0;
    [self playEffect:1];//音效
    return;
}
- (void)changeSecondPage:(id) sender
{
    [pageC setNumberOfPages:1];
    _nextPage=2;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage * tempImage=[UIImage imageNamed:@"gesture.png"];
//    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(_textViewCurrentPage.frame.origin.x, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    [_textViewNextPage release];
    
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=YES;
    _thirdButton.selected=NO;
    _forthButton.selected=NO;
    _fifthButton.selected=NO;
    _nextPage=0;
    
      [self playEffect:1];//音效
    return;
}
- (void)changeThirdPage:(id) sender//规则
{
    [pageC setNumberOfPages:4];//3
    [pageC setCurrentPage:0];
    _nextPage=3;//3
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(_textViewCurrentPage.frame.origin.x, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    [_textViewNextPage release];
    
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=NO;
    _thirdButton.selected=YES;
    _forthButton.selected=NO;
    _fifthButton.selected=NO;
    _nextPage=0;
     [self playEffect:1];//音效
    return;
}
- (void)changeForthPage:(id) sender
{
    [pageC setNumberOfPages:3];
    [pageC setCurrentPage:0];
    _nextPage=4;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(_textViewCurrentPage.frame.origin.x, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    [_textViewNextPage release];
    
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=NO;
    _thirdButton.selected=NO;
    _forthButton.selected=YES;
    _fifthButton.selected=NO;
    _nextPage=0;
    [self playEffect:1];//音效
    return;
}
- (void)changeFifthPage:(id) sender
{
    
    [pageC setNumberOfPages:3];
    [pageC setCurrentPage:0];
    _nextPage=5;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
 
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(_textViewCurrentPage.frame.origin.x, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    [_textViewNextPage release];
    
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=NO;
    _thirdButton.selected=NO;
    _forthButton.selected=NO;
    _fifthButton.selected=YES;
    _nextPage=0;
     [self playEffect:1];//音效
    return;
}
- (void)oneFingerSwipLeft:(UISwipeGestureRecognizer *)recognizer
{
    
    printf("left.cu=%d",_currentPage);
    switch (_currentPage) {
        case 1:
            if(_currentText>=TEXT_COUNT_1)
                return;
            break;
        case 2:
            if(_currentText>=TEXT_COUNT_2)
                return;
            break;
        case 3:
            if(_currentText>=TEXT_COUNT_3)
                return;
            break;
        case 4:
            if(_currentText>=TEXT_COUNT_4)
                return;
            break;
        case 5:
            if(_currentText>=TEXT_COUNT_5)
                return;
            break;
        default:
            break;
    }
//     printf("p==%d",_currentText);
    [pageC setCurrentPage:_currentText];

    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_currentPage,_currentText+1]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(_textViewCurrentPage.frame.origin.x, 0, tempImage.size.width/2, tempImage.size.height/2)];//x=0
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentText++;
   [self playEffect:2];//音效
 
    return;
}
- (void)oneFingerSwipRight:(UISwipeGestureRecognizer *)recognizer
{
    
    if(_currentText==1) return ;
   
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_currentPage,_currentText-1]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(_textViewCurrentPage.frame.origin.x, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    _textViewNextPage.bounds=CGRectMake(-10, -10, tempImage.size.width/2, tempImage.size.height/2) ;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentText--;
     [pageC setCurrentPage:_currentText-1];
//    printf("page==%d",_currentText);
 

   [self playEffect:2];//音效
    
    return ;
}

/////////////////////////////////////
//initial code
-(void)click
{
    self.visible=NO;
    btn_regular.hidden=YES;
    _firstButton.hidden = YES;
    _secondButton.hidden = YES;
    _thirdButton.hidden = YES;
    _forthButton.hidden = YES;
    _fifthButton.hidden = YES;
    _backHome.hidden = YES;
    
    _textViewCurrentPage.hidden = YES;
    _textViewNextPage.hidden = YES;
    _text.hidden = YES;
    
    _buttonBackground.hidden = YES;
    _homeView.hidden = YES;
    pageC.hidden=YES;
    if (![self.parent isKindOfClass:[GameMainViewContorller class]]) {//不是启动页面
 
        printf("不是启动页面");
        [self.delegate setMainMenu];
        
    
    }
    else//是启动页面
    {

        printf("启动页面");
        [self.delegate setEnableYes];
    }
    [self playEffect:1];//音效

    
}
-(void)drawTextView
{
    NSString * about = [NSString stringWithFormat:@"return.png"];
    UIImage * about_1 = [UIImage imageNamed:about];
    btn_regular=[UIButton buttonWithType:UIButtonTypeCustom];

    [btn_regular setImage:about_1 forState:UIControlStateNormal];
    [btn_regular setFrame:CGRectMake(0, 0, 60, 40)];

    [btn_regular addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    //////////////////////////////
	[self initHomeView];
 
    [self initFirstButton];
    [self initSecondButton];
    [self initThirdButton];
    [self initForthButton];
    [self initFifthButton];
 
    [self initText];
    
    [[[CCDirector sharedDirector] openGLView] addSubview:btn_regular];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"规则界面被点击了");
    return NO;//yes
}
-(void)dealloc
{
    printf("guize dealloc");
    [super dealloc];

}

@end
