//
//  Card.h
//  CDDGame
//
//  Created by  on 12-8-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enumeration.h"
@interface Card : CCSprite 
{
    int cardNum;
    SuitType suit;
    Boolean  isSelect;
    //        Boolean  isTake;
    Boolean  isTaked;//用于排序比较作为标志位
    int flag;         //card标志位

    
}

@property (readwrite) int cardNum;
@property (readwrite) SuitType suit;
@property (readwrite) Boolean  isSelect;
//    @property (readwrite) Boolean  isTake;
@property (readwrite) Boolean  isTaked;
@property (readwrite)int flag;

-(id)initObjectWithType:(int)suitType andNum:(int)number;
-(id)initObjectWithNum:(int)number;
-(Card*)maxCard:(Card*)card;

- (Boolean) compareLess:(Card *)card;
- (void) setFlagValue:(int)_flag;
- (Boolean) isSameCard:(Card *)_card;
- (Boolean) isEqual:(Card *)_card;


@end

