//
//  GameMainViewContorller.h
//  CDDGame
//
//  Created by  on 12-7-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CD2Database.h"
#import "PositionGetter.h"
#import "Regular.h"
@interface GameMainViewContorller : CCLayer<EXParentDelegate> {
    
    //定义数据库
    CD2Database * database;
    NSString * userName;
    CCMenu * about;
    CCMenu * goBack;
    PositionGetter * positionGetter1;
    
    CCMenuItemImage * gameStart ;
    CCMenuItemImage * gameSetting ;
    CCMenuItemImage * gameHelp;
    CCMenuItemImage * gameAbout;
    NSArray *  imageArray;
}
+(CCScene*)scene;
@property(assign) PositionGetter *positionGetter1;
-(void)clickStart;
-(void)playEffect;
-(void)setEnableYes;//显示主界面按钮
-(void)setEnableNo;//显示主界面按钮
@end
