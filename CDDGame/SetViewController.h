//
//  SetViewController.h
//  CDDGame
//
//  Created by  on 12-8-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CD2Database.h"

@interface SetViewController : CCLayer {

    //设置用户输入框
    UITextField * userNameText;
    
    //定义数据库
    CD2Database * database;
    
    //用户名字
    NSString * userName;
    
    //设置方块3
    CCSprite * square3ButtonYes_off;
    CCSprite * square3ButtonYes_on;
    CCSprite * square3ButtonNo_off;
    CCSprite * square3ButtonNo_on;
    CCMenu * square3ButtonMenuNo;
    CCMenu * square3ButtonMenuYes;
    
    //设置是否顶大
    CCSprite * maxSwitchYes;
    CCSprite * maxSwitchNo;
    CCMenu * maxSwitchMenuNo;
    CCMenu * maxSwitchMenuYes;
    
    //显示当前背景音乐
    CCLabelTTF *musiclabel;
    CCLabelTTF *gameTurns;
    
    //定义数据分数选择栏
    NSArray *segmentedArray;
    NSArray *segmentedArray2;
    NSArray *segmentedArray3;
    
    //定义分数局数按钮
    UISegmentedControl *segmentedControl;
    UISegmentedControl *segmentedControl2;
    UISegmentedControl *segmentedControl3;
    
    //用来存放设定的值
    float volumeValue;
    float soundEffectValue;
    int backGroundValue;
    int headPortaitValue;
    int pointAndTurnsValue;
    int square3Value;
    int maxSwitchValue;
    int scole;
    
    //下拉列表
    NSArray * nameList;
    NSMutableArray * nameList1;
    UITableView * nameTable;
    
    int index;
}

@property (retain) UITextField* userNameText;

+(CCScene*)scene;
-(void)playEffect;
@end
