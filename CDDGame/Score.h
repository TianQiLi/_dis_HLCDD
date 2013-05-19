//
//  Score.h
//  CDDGame
//
//  Created by  on 12-9-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Score : CCLayer {
    UITableView * nameTable;
    NSMutableArray * scoreShow;
    NSMutableArray * scoreList;

}

@end
