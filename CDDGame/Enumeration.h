//
//  Enumeration.h
//  CDDGame
//
//  Created by  on 12-8-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"



//the number of different dots
#define DotNum 13

//the number of different suits
#define SuitNum 4
typedef enum
{
    DIAMONDS =1,  //方块
    CLUB = 2,      //梅花
    HEARTS =3,    //红桃
    SPADE = 4,     //黑桃 
}SuitType;


typedef enum 
{
    Update   = 1,
    Menu     = 2,
    Pause    = 3,
    Continue = 4,
    Notice   = 5,
    Escape   = 6,
    End      = 7
}GameState;
typedef enum
{
    USER = 1,  //user player
    COMPUTER=2//computer player
}PlayerType;

typedef enum
{
    TakeTurn = 1,
    OffTurn  = 2
}PlayerState;

//typedef enum
//{
//    benko  = 1,
//    fenko  = 2,
//    fenke  = 3,
//    sanzhi = 4,
//    push   = 5,
//    none   = 6
//}PlayerName;

//手势方向
typedef enum
{
    LEFT,
    RIGHT,
    UP,
    DOWN
}GestureDir;

 
typedef enum {
    INVALID = 0,  //非法
    SINGLE,       //单张
    COUPLE,       //一对
    THREE,        //三张
    MIXSEQ,       //杂顺
    FLUSH,        //同花
    CAPTURE,      //三带二
    KINGTONG,     //四带一
    STRAIGHTFLUSH //同花顺
} cardType;
@interface Enumeration : CCLayer {
    
}

@end
