//
//  Card.m
//  CDDGame
//
//  Created by  on 12-8-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "Card.h"



@implementation Card

@synthesize cardNum;
@synthesize suit;
@synthesize isSelect;
@synthesize isTaked;
@synthesize flag;

-(id)initObjectWithNum:(int)number
{
    
    self = [self initWithFile:[[NSString alloc]initWithFormat:@"%d.png",number]];
//    self.visible = NO;
    self.scale   = 0.5f;
    return self;
}

-(id)initObjectWithType:(int)suitType andNum:(int)number
{
    if (number == 1) {
        self.cardNum = number + 13;
    }else if(number == 2){
        self.cardNum = number + 14;
    }else{
        self.cardNum  = number;
    }
//    self.cardNum  = number;
    self.suit     = suitType;
    self.isSelect = NO;
    self.isTaked  = NO;
    
    return self;
}

-(Card*)maxCard:(Card*)card
{
    if(card.cardNum == 1)
        return [[Card alloc]initObjectWithType:card.suit andNum:card.cardNum+13];
    else if(card.cardNum == 2)
    {
        return [[Card alloc]initObjectWithType:card.suit andNum:card.cardNum+14];
    }else{
        return [[Card alloc]initObjectWithType:card.suit andNum:card.cardNum];
    }
}

- (Boolean) isEqual:(Card *)_card
{
    if ((_card.cardNum == 3)&&(_card.suit == 1)) {
        return YES;
    }else{
        return NO;
    }
}


- (Boolean) isSameCard:(Card *)_card
{
    if ((self.cardNum == _card.cardNum) && (self.suit == _card.suit)) {
        return YES;
    }else{
        return NO;
    }
}

- (Boolean) compareLess:(Card *)card
{
    return self.cardNum < card.cardNum || (self.cardNum == card.cardNum && self.suit < card.suit);
}

- (void) setFlagValue:(int)_flag
{
    self.flag = _flag;
}

@end
