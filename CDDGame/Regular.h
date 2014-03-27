//
//  Regular.h
//  regular
//
//  Created by  on 12-9-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
 

#define TEXT_COUNT_1 1
#define TEXT_COUNT_2 1
#define TEXT_COUNT_3 4//3
#define TEXT_COUNT_4 3
#define TEXT_COUNT_5 3
#define TEXT_POSITION_X 33
#define TEXT_POSITION_Y 80


@protocol EXParentDelegate <NSObject>
@required
-(void)setMainMenu;
-(void) setEnableYes;

@end

@interface Regular : CCLayer<EXParentDelegate> {
    UIButton * btn_regular;
    
    ////////////////////////////
    
    int start_x;
    int _currentPage;
    int _currentText;
    int _nextPage;
    UIButton *_firstButton;
    UIButton *_secondButton;
    UIButton *_thirdButton;
    UIButton *_forthButton;
    UIButton *_fifthButton;
    UIButton *_backHome;
    
    UIImageView *_textViewCurrentPage;
    UIImageView *_textViewNextPage;
    UIView *_text;
    
    UIImageView *_buttonBackground;
    UIImageView *_homeView;
    UIPageControl *pageC;
    int controller;
    
    int _navX;
    int _navY;
    
}
@property int controller;
@property(nonatomic,retain) id<EXParentDelegate>delegate;
+(CCScene * )scene;    
-(void)drawTextView;
-(void)playEffect:(int)num;


@end
