//
//  CD2Database.h
//  CDDGame
//
//  Created by  on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <sqlite3.h>

@interface CD2Database : CCNode {
    //数据库的名字
    sqlite3 * database;
    
    //存储用户列表
    sqlite3_stmt * nextStatement;
    
    //记录用户信息表
    NSString * userTableName;
    NSString * userName1;
    float volume;            //音量
    float soundEffect;       //音效
    int headPortrait;      //头像
    int pointOrTurns;  //按分数或局数
    int square3Select;       //是否方块3先出
    int selectMaxSwitch;     //是否顶大
    int backGroundMusic;//选择背景音乐
    long int score;               //分数
    
    //记录电脑玩家信息
    NSString * computer1;
    NSString * computer2;
    NSString * computer3;
    int headComputer1;
    int headComputer2;
    int headComputer3;

    
    //记录分数排名
    NSString * scoreRanking;
}

@property (retain) NSString * userName1;
@property float volume;
@property float soundEffect;       //音效
@property int headPortrait;      //头像
@property int pointOrTurns;  //按分数或局数
@property int square3Select;       //是否方块3先出
@property int selectMaxSwitch;     //是否顶大
@property int backGroundMusic;//选择背景音乐
@property long int score;               //分数

@property (retain)NSString * computer1;
@property (retain)NSString * computer2;
@property (retain)NSString * computer3;
@property int headComputer1;
@property int headComputer2;
@property int headComputer3;

-(void) openDatabase;
-(void) createTable;
- (void) insertUserWithName:(NSString*) name;
- (void) addNewUserOrUpdateUserSetting:(NSString *)name withPointOrTurns:(int) pointOrTurns1 andSquare3:(int) square3Select1 andMaxSwitch:(int) selectMaxSwitch1 andBackGroundMusic:(int) backGroundMusic1 andHeadPortrait:(int) headPortrait1;
- (void) upDateVolumeSoundEffectAndMusic:(NSString *)name withVolume:(float)volume andSoundEffect:(float)soundEffect andBackgroundMusic:(int)backGroundMusic;
- (void)updateUserEndScore:(NSString *)name withScore:(int)score;
- (void) useThisName:(NSString *)name;
-(void) deletUser:(NSString *)name;
- (NSString *) selectLastName;
- (BOOL) isNameTableEmpty;
- (NSMutableArray *) getAllUserName;
- (NSMutableArray *) getRankingName;
- (NSMutableArray *) getRankingScore;

-(void) closeDatabase;

@end
