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
#define TEXT_COUNT_3 2
#define TEXT_COUNT_4 2
#define TEXT_COUNT_5 1
#define TEXT_POSITION_X 33
#define TEXT_POSITION_Y 80

@interface Regular : CCLayer {
    UIButton * btn_regular;
    
    ////////////////////////////
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
    int _navX;
    int _navY;
    
}
+(CCScene * )scene;
-(void)drawTextView;

@end
