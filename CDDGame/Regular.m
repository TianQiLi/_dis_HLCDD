//
//  Regular.m
//  regular
//
//  Created by  on 12-9-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Regular.h"

@implementation Regular
+(CCScene *) scene
{
	 	CCScene *scene = [CCScene node];
	 	Regular *layer = [Regular node];
	 	[scene addChild: layer];
	
 	    return scene;
}

-(id)init
{
    if (self==[super init])
    {
        _navX = 55;
        _navY = 36;
        _currentPage=1;
        _currentText=1;
        _nextPage=0;
        [self drawTextView];
    }
    return self;
}


//////////////////////////
//init code

-(void) initHomeView
{
    UIImage *tempImage=[UIImage imageNamed:@"u0_normal.png"];
    _homeView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tempImage.size.width, tempImage.size.height)];
    _homeView.image=tempImage;
    [[[CCDirector sharedDirector] openGLView] addSubview:_homeView];
}
-(void) initButtomBackground
{
    /*UIImage *tempImage=[UIImage imageNamed:@"u4_normal.png"];
    _buttonBackground=[[UIImageView alloc] initWithFrame:CGRectMake(33, 30, tempImage.size.width, tempImage.size.height)];
    _buttonBackground.image=tempImage;
    [_homeView addSubview:_buttonBackground];
    [_homeView bringSubviewToFront:_buttonBackground];*/
}
- (void)nextNav
{
    _navX += 72;
}
-(void) initFirstButton
{
    UIImage *tempImage=[UIImage imageNamed:@"u10_normal_1.png"];
    _firstButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_firstButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"u8_normal_1.png"];
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
    UIImage *tempImage=[UIImage imageNamed:@"u10_normal_2.png"];
    _secondButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_secondButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"u8_normal_2.png"];
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
    UIImage *tempImage=[UIImage imageNamed:@"u10_normal_3.png"];
    _thirdButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_thirdButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"u8_normal_3.png"];
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
    UIImage *tempImage=[UIImage imageNamed:@"u10_normal_4.png"];
    _forthButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_forthButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"u8_normal_4.png"];
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
    UIImage *tempImage=[UIImage imageNamed:@"u10_normal_5.png"];
    _fifthButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_fifthButton setImage:tempImage forState:UIControlStateNormal];
    tempImage=[UIImage imageNamed:@"u8_normal_5.png"];
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
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d",_currentPage,_currentText]];
    _textViewCurrentPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
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
    [_text addGestureRecognizer:oneFingerSwipRight];
    _text.userInteractionEnabled=YES;
    [_text addSubview:_textViewCurrentPage];
    [[[CCDirector sharedDirector] openGLView] addSubview:_text];
}

///////////////////////////////////
//logical code


- (void)changeFirstPage:(id) sender
{
    _nextPage=1;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=YES;
    _secondButton.selected=NO;
    _thirdButton.selected=NO;
    _forthButton.selected=NO;
    _fifthButton.selected=NO;
    _nextPage=0;
    return;
}
- (void)changeSecondPage:(id) sender
{
    _nextPage=2;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=YES;
    _thirdButton.selected=NO;
    _forthButton.selected=NO;
    _fifthButton.selected=NO;
    _nextPage=0;
    return;
}
- (void)changeThirdPage:(id) sender
{
    _nextPage=3;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=NO;
    _thirdButton.selected=YES;
    _forthButton.selected=NO;
    _fifthButton.selected=NO;
    _nextPage=0;
    return;
}
- (void)changeForthPage:(id) sender
{
    _nextPage=4;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=NO;
    _thirdButton.selected=NO;
    _forthButton.selected=YES;
    _fifthButton.selected=NO;
    _nextPage=0;
    return;
}
- (void)changeFifthPage:(id) sender
{
    _nextPage=5;
    _currentText=1;
    if(_nextPage==_currentPage)
    {
        _nextPage=0;
        return;
    }
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_nextPage,_currentText]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentPage=_nextPage;
    _firstButton.selected=NO;
    _secondButton.selected=NO;
    _thirdButton.selected=NO;
    _forthButton.selected=NO;
    _fifthButton.selected=YES;
    _nextPage=0;
    return;
}
- (void)oneFingerSwipLeft:(UISwipeGestureRecognizer *)recognizer
{
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
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_currentPage,_currentText+1]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentText++;
    return;
}
- (void)oneFingerSwipRight:(UISwipeGestureRecognizer *)recognizer
{
    if(_currentText==1) return;
    UIImage *tempImage=[UIImage imageNamed:[NSString stringWithFormat:@"text_%d_%d.png",_currentPage,_currentText-1]];
    _textViewNextPage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tempImage.size.width/2, tempImage.size.height/2)];
    _textViewNextPage.image=tempImage;
    _textViewNextPage.bounds=CGRectMake(-10, -10, tempImage.size.width/2, tempImage.size.height/2) ;
    [_textViewCurrentPage removeFromSuperview];
    [_text addSubview:_textViewNextPage];
    _textViewCurrentPage=_textViewNextPage;
    _currentText--;
    return;
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
}

-(void)drawTextView
{
    NSString * about = [NSString stringWithFormat:@"return.png"];
    UIImage * about_1 = [UIImage imageNamed:about];
    btn_regular=[UIButton buttonWithType:UIButtonTypeCustom];

    [btn_regular setImage:about_1 forState:UIControlStateNormal];
    [btn_regular setFrame:CGRectMake(0, 0, 60, 35)];

    [btn_regular addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    //////////////////////////////
	[self initHomeView];
    [self initButtomBackground];
    [self initFirstButton];
    [self initSecondButton];
    [self initThirdButton];
    [self initForthButton];
    [self initFifthButton];
    [self initText];
    
    [[[CCDirector sharedDirector] openGLView] addSubview:btn_regular];
}

@end
