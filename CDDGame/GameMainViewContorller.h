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

@interface GameMainViewContorller : CCLayer {
    
    //定义数据库
    CD2Database * database;
    NSString * userName;
    CCMenu * about;
    CCMenu * goBack;
}
+(CCScene*)scene;
-(void)clickStart;
@end
