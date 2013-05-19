//
//  CD2Database.m
//  CDDGame
//
//  Created by  on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CD2Database.h"


@implementation CD2Database

@synthesize userName1;
@synthesize volume;            //音量
@synthesize soundEffect;       //音效
@synthesize headPortrait;      //头像
@synthesize pointOrTurns;  //按分数或局数
@synthesize square3Select;       //是否方块3先出
@synthesize selectMaxSwitch;     //是否顶大
@synthesize backGroundMusic;//选择背景音乐
@synthesize score;               //分数

@synthesize computer1;
@synthesize computer2;
@synthesize computer3;
@synthesize headComputer1;
@synthesize headComputer2;
@synthesize headComputer3;


//打开数据库
-(void) openDatabase
{
    //数据表名称
//    userTableName = [[NSString alloc]init];
    userTableName = @"lin4";
    NSArray * documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * databaseFilePath = [[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"mydatabase"];
    if(sqlite3_open([databaseFilePath UTF8String], &database) == SQLITE_OK){
        NSLog(@"open sqlite database ok.");
    }else{
        NSLog(@"open sqlite database failed.");
    }
}

//创建表
-(void) createTable
{
    char * errorMsg;
    NSString * createSqlite = [NSString stringWithFormat:@"create table if not exists %@ (name text, volume real, soundEffect real, pointOrTurns integer, square3Select integer, selectMaxSwitch integer, backGroundMusic integer, headPortrait integer, score integer, use integer, computerName1 text, computerName2 text, computerName3 text, headComputer1 integer, headComputer2 integer, headComputer3 integer)",userTableName];
    if (sqlite3_exec(database, [createSqlite UTF8String], NULL, NULL, &errorMsg ) == SQLITE_OK) {
        NSLog(@"create table ok.");
    }else{
        NSLog(@"create table failed.");
    }
}

////创建分数排名的表
//-(void) createScorePlace
//{
//    char * errorMsg;
//    NSString * createSqlite = [NSString stringWithFormat:@"create table if not exists %@ (name text,score integer)",scoreRanking];
//    if (sqlite3_exec(database, [createSqlite UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
//        NSLog(@"create scoreplace ok.");
//    }
//}

////更新分数
//-(void) insertScoreName:(NSString *)name score:(int)x
//{
//    char * errorMsg;
//    NSString * sqlite = [NSString stringWithFormat:@"INSERT OR ROLLBACK INTO '%@'('%@','%@') VALUES ('%@','%d')",scoreRanking,@"name",@"score",name,x];
//    if (sqlite3_exec(database, [sqlite UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
//        NSLog(@"insert score ok.");
//    }else{
//        NSLog(@"insert score faild.");
//    }
//}

//插入数据，如果有重复，则不插入数据
- (void) insertUserWithName:(NSString*) name
{
    char* errorMsg;
    //先判断数据是否有重复
    NSString * selectSql = [NSString stringWithFormat:@"select name from %@ where name='%@'",userTableName , name];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [selectSql UTF8String], -1, &statement, nil)==SQLITE_OK) { 
        NSLog(@"select judge ok."); 
    }else{
        NSLog(@"select judge failed");
    }
    if (sqlite3_step(statement) == SQLITE_ROW) {
        NSLog(@"已有相同的用户名");
        sqlite3_finalize(statement);
    }else{
        NSLog(@"创建默认用户名");
        computer1 = @"computer";
        computer2 = @"computer";
        computer3 = @"computer";
        NSString * selectSqlite = [NSString stringWithFormat:@"insert or rollback into '%@' ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') values ('%@','%f','%f','%d','%d','%d','%d','%d','%d','%d','%@','%@','%@','%d','%d','%d')" , userTableName, @"name", @"volume", @"soundEffect", @"pointOrTurns", @"square3Select", @"selectMaxSwitch", @"backGroundMusic", @"headPortrait",@"score", @"use", @"computerName1",@"computerName2",@"computerName3",@"headComputer1",@"headComputer2",@"headComputer3",name,0.5,0.5,11,0,0,0,0,0,0,computer1,computer2,computer3,1,2,3];
        if (sqlite3_exec(database, [selectSqlite UTF8String], NULL, NULL, &errorMsg)==SQLITE_OK) { 
            NSLog(@"insert ok."); 
            volume = 0.5;
            soundEffect = 0.5;
            pointOrTurns = 11;
            square3Select = 0;
            selectMaxSwitch = 0;
            backGroundMusic = 0;
            headPortrait = 0;
            score = 0;
            
        }else{
            NSLog(@"insert faild."); 
        }
    }
}


//增加新用户或者更新用户设置
- (void) addNewUserOrUpdateUserSetting:(NSString *)name withPointOrTurns:(int) pointOrTurns1 andSquare3:(int) square3Select1 andMaxSwitch:(int) selectMaxSwitch1 andBackGroundMusic:(int) backGroundMusic1 andHeadPortrait:(int) headPortrait1
{
    //判断用户名是否已存在
    char *errorMsg;
    NSString * selectSqlite = [NSString stringWithFormat:@"select name from %@ where name='%@'",userTableName,name];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(database, [selectSqlite UTF8String], -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"select ok.");
    }else{
        NSLog(@"select failed.");
    }
    if (sqlite3_step(statement) == SQLITE_ROW) {
        NSLog(@"用户名已存在");
        NSString * selectSqliteYes = [NSString stringWithFormat:@"update %@ set pointOrTurns='%d',square3Select='%d',selectMaxSwitch='%d',backGroundMusic='%d',headPortrait='%d' where name='%@'", userTableName, pointOrTurns1, square3Select1, selectMaxSwitch1, backGroundMusic1, headPortrait1, name];
        if (sqlite3_exec(database, [selectSqliteYes UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
            NSLog(@"update ok.");
        }else{
            NSLog(@"update failed.");
        }

        sqlite3_finalize(statement);
    }else{
        NSLog(@"创建新用户名并保存其设置");
        computer1 = @"computer";
        computer2 = @"computer";
        computer3 = @"computer";
        NSString * selectSqlite = [NSString stringWithFormat:@"insert or rollback into '%@' ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') values ('%@','%f','%f','%d','%d','%d','%d','%d','%d','%d','%@','%@','%@','%d','%d','%d')" , userTableName, @"name", @"volume", @"soundEffect", @"pointOrTurns", @"square3Select", @"selectMaxSwitch", @"backGroundMusic", @"headPortrait",@"score", @"use", @"computerName1",@"computerName2",@"computerName3",@"headComputer1",@"headComputer2",@"headComputer3",name,0.5,0.5,pointOrTurns1,square3Select1,selectMaxSwitch1,backGroundMusic1,headPortrait1,0,0,computer1,computer2,computer3,1,2,3];
        if (sqlite3_exec(database, [selectSqlite UTF8String], NULL, NULL, &errorMsg)==SQLITE_OK) { 
            NSLog(@"insert ok."); 
            volume = 0.5;
            soundEffect = 0.5;
            pointOrTurns = pointOrTurns1;
            square3Select = square3Select1;
            selectMaxSwitch = selectMaxSwitch1;
            backGroundMusic = backGroundMusic1;
            headPortrait = headPortrait1;
        }else{
            NSLog(@"insert faild."); 
        }
    }
}

//删除用户
-(void) deletUser:(NSString *)name
{
    char * errorMsg;
    NSString * deleteSqlite = [NSString stringWithFormat:@"delete from %@ where name='%@'",userTableName,name];
    if (sqlite3_exec(database, [deleteSqlite UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"@delete ok.");
    }else{
        NSLog(@"delete failed.");
    }
}

//更新音量、音效、背景音乐数据
- (void) upDateVolumeSoundEffectAndMusic:(NSString *)name withVolume:(float)volume andSoundEffect:(float)soundEffect andBackgroundMusic:(int)backGroundMusic
{
    char * errorMsg;
    NSString * selectSqlite = [NSString stringWithFormat:@"update '%@' set volume='%f',soundEffect='%f',backGroundMusic='%d' where name='%@'",userTableName, volume, soundEffect, backGroundMusic, name];
    if (sqlite3_exec(database, [selectSqlite UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"update ok.");
    }else{
        NSLog(@"update failed.");
    }
}

//更新用户分数
- (void)updateUserEndScore:(NSString *)name withScore:(int)score
{
    char * errorMsg;
    NSString * updateSqlite = [NSString stringWithFormat:@"update '%@' set score='%d' where name='%@'",userTableName,score,name];
    if (sqlite3_exec(database, [updateSqlite UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"update ok.");
    }else{
        NSLog(@"update failed.");
    }
}

//使用用户名
- (void) useThisName:(NSString *)name
{
    char * errorMsg;
    NSString * clearSqlite = [NSString stringWithFormat:@"UPDATE %@ SET use='0'" , userTableName];
    if (sqlite3_exec(database, [clearSqlite UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"use clear ok.");
    }else{
        NSLog(@"use clear failed.");
    }
    
    NSString * updateSqlite = [NSString stringWithFormat:@"update %@ set use='1' where name='%@'", userTableName, name];
    if (sqlite3_exec(database, [updateSqlite UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"useName is ok.");
    }else{
        NSLog(@"useName is failed.");
    }
}

//- (NSString *) selectUser1
//{
//    NSString * selectSqlite = [NSString stringWithFormat:@"select name,score from %@ where use='%d'",userTableName,1];
//    sqlite3_stmt * statement;
//    if (sqlite3_prepare(database, [selectSqlite UTF8String], -1, &statement, nil) == SQLITE_OK) {
//        NSLog(@"select is ok.");
//    }else{
//        NSLog(@"select failed.");
//    }
//    if (sqlite3_step(statement) == SQLITE_ROW) {
//        NSLog(@"row>>,name %@",userName1);
//        NSString * userName = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
//        userName1 = userName;
//        NSLog(@"row>>,name %@",userName1);
//        score = sqlite3_column_double(statement, 1);
//        NSLog(@"row>>,score %d",score);
//        [userName release];
//    }
//    return nil;
//}



//选择上次使用的用户名
- (NSString *) selectLastName
{
    NSString * selectSqlite = [NSString stringWithFormat:@"select name, volume, soundEffect, pointOrTurns, square3Select, selectMaxSwitch, backGroundMusic, headPortrait, score, computerName1, computerName2, computerName3, headComputer1, headComputer2, headComputer3 from %@ where use='%d'",userTableName,1];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(database, [selectSqlite UTF8String], -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"select is ok");
    }else{
        NSLog(@"select failed");
    }
    NSString * userName = nil;
    if (sqlite3_step(statement) == SQLITE_ROW) {
        userName = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
        NSLog(@"row>>,name %@",userName);
        userName1 = userName;
        NSLog(@"row>>,name1 %@",userName1);
        
        volume = sqlite3_column_double(statement, 1);
        soundEffect = sqlite3_column_double(statement, 2);
        pointOrTurns = sqlite3_column_double(statement, 3);
        square3Select = sqlite3_column_double(statement, 4);
        selectMaxSwitch = sqlite3_column_double(statement, 5);
        backGroundMusic = sqlite3_column_double(statement, 6);
        headPortrait = sqlite3_column_double(statement, 7);
        score = sqlite3_column_double(statement, 8);
        NSLog(@"volume score =%f %d,",volume, score);
        userName = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 9) encoding:NSUTF8StringEncoding];
        computer1 = userName;
        userName = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 10) encoding:NSUTF8StringEncoding];
        computer2 = userName;
        userName = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 11) encoding:NSUTF8StringEncoding];
        computer3 = userName;
        headComputer1 = sqlite3_column_double(statement, 12);
        headComputer2 = sqlite3_column_double(statement, 13);
        headComputer3 = sqlite3_column_double(statement, 14);
        [userName release];
    }
    sqlite3_finalize(statement);
//    [userName release];
    return nil;
//    [userName release];
}

//判断用户列表中是否已有用户
- (BOOL) isNameTableEmpty
{
    NSString * selectSqlite = [NSString stringWithFormat:@"select name from %@",userTableName];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(database, [selectSqlite UTF8String], -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"select ok");
    }
    BOOL isEmpty = YES;
    if (sqlite3_step(statement) == SQLITE_ROW) {
        isEmpty = NO;
    }
    sqlite3_finalize(statement);
    NSLog(@"isEmpty = %d",isEmpty);
    
    return isEmpty;
}

//获得所有用户的名字和分数
- (NSMutableArray *) getAllUserName
{
    NSMutableArray * allUserName = [[NSMutableArray alloc] init];
    NSString * selectSqlite = [NSString stringWithFormat:@"select name,score from %@",userTableName];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(database, [selectSqlite UTF8String], -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"select all name is ok.");
    }
    while (sqlite3_step(statement) == SQLITE_ROW) {
        NSString * name = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
        NSLog(@"all name row>>,name %@",name);
        [allUserName addObject:name];
        [name release];
    }
    sqlite3_finalize(statement);
    return allUserName;
}

//得到排序的名字
- (NSMutableArray *) getRankingName
{
    NSMutableArray * rankName = [[NSMutableArray alloc] init];
    NSString * selectSqlite = [NSString stringWithFormat:@"select name,score from %@ order by score desc",userTableName];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(database, [selectSqlite UTF8String], -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"select is ok.");
    }
    while (sqlite3_step(statement)==SQLITE_ROW) {
        NSString * name = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
        [rankName addObject:name];
        NSLog(@"name = %@",name);
        [name release];
    }
    sqlite3_finalize(statement);
    return rankName;
}

//得到排序的分数
- (NSMutableArray *) getRankingScore
{
    NSMutableArray * rankScore = [[NSMutableArray alloc] init];
    NSString * selectSqlite = [NSString stringWithFormat:@"select name,score from %@ order by score desc",userTableName];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(database, [selectSqlite UTF8String], -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"select is ok.");
    }
    while (sqlite3_step(statement)==SQLITE_ROW) {
        NSString * _score = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement, 1)];
        [rankScore addObject:_score];
        NSLog(@"score = %@",_score);
    }
    sqlite3_finalize(statement);
    return rankScore;
}

//关闭数据库
- (void) closeDatabase
{
    //释放sqlite中的文件
    sqlite3_finalize(nextStatement);
    //关闭数据库
    sqlite3_close(database);
    NSLog(@"close database");
}

-(void)dealloc
{
    [super dealloc];
}
@end
