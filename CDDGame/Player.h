//
//  Player.h
//  CDDGame
//
//  Created by  on 12-8-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Card.h"
#import "Enumeration.h"
//#import "PlayGameView.h"

@interface Player : CCSprite 
{
    PlayerType      playerType;
    PlayerState     playerState;
    NSString *playerName;
    
    NSMutableArray*        cardsOnHand;
    NSMutableArray*        selectCards;
    NSMutableArray*        lastCards;
    NSMutableArray*        showedAllCards;
    
    int             onHandCardsNum;
    int             selectCardsNum;
    int             playerPos;
    
    //分数
    int             tScore;     //每一局的得分总数(没有用，可以去掉)
    int             scoreGet;
    int             currentScore; //最终得分
    /**********************************************/
    Boolean isShowCard;//标示是否当前出牌
    //最大和第二大单
    Card * maxSingle;
    Card * secondSingle;
    Card * maxCouple;//最大对
    
    //是否拥有最大的牌
    Boolean _isMaxSingle;
    Boolean _isSecondSingle;
    Boolean _isMaxCouple;
    
    Boolean whenAnyOneSingle;//某一家为单时
    Boolean needMaxCard;//需要顶大时
    Boolean needSquare3;//是否需要方块3
    NSMutableArray * cardList;

    //存在牌型的数组
    NSMutableArray * cardHash[9];
    Boolean isLastOne;

}

@property (readwrite) PlayerType  playerType;
@property (readwrite) PlayerState playerState;
@property (readwrite) int         onHandCardsNum;
@property (readwrite) int         selectCardsNum;
@property (readwrite) int         playerPos;
@property (readwrite) int         tScore;
@property (readwrite) int         scoreGet;
@property (readwrite) int         currentScore;
@property (readwrite) Boolean isShowCard;
@property (retain) NSString *playerName;
@property (retain)    NSMutableArray*   cardsOnHand;
@property (retain)    NSMutableArray*   selectCards;
@property (retain)    NSMutableArray*   lastCards;
@property (retain)    NSMutableArray* showedAllCards;

/****************************************/
@property (retain)NSMutableArray * cardList;
@property (readwrite)Boolean needSquare3;
@property (retain)Card * maxSingle;
@property (retain)Card * secondSingle;
@property (retain)Card * maxCouple;
@property (readwrite)Boolean _isMaxSingle;
@property (readwrite)Boolean _isSecondSingle;
@property (readwrite)Boolean _isMaxCouple;
@property (readwrite)Boolean whenAnyOneSingle;
@property (readwrite)Boolean needMaxCard;
@property (readwrite)Boolean isLastOne;


-(id)initPlayerWithPlayerType:(PlayerType)playerType1 PlayerState:(PlayerState)playerState1 Postion:(int)playerPos1;

-(Boolean)hasDiamodsThree;
-(Boolean)selectDiamodsThree;
-(void)selectCardsAction:(NSMutableArray*)player;
-(void)showCard:(id)game;
-(int)scoreCard;
-(int)totalScore:(NSMutableArray*)player ScoreZero:(int)scoreZero ScoreOne:(int)scoreTwo ScoreTwo:(int)scoreTwo ScoreThree:(int)scoreThree;

- (void) playerShowCards;
- (void) playerFollowCards:(NSMutableArray *)_cards;
- (void) setCardsFlag:(NSMutableArray *)_cards flagCard:(NSMutableArray *)_flagcard flag:(int) _flag;
- (void) getFlush:(NSMutableArray *)_cards flag:(int)_flag;
- (void) getMixSeq:(NSMutableArray *)_cards flag:(int)_flag;
- (void) getCouple:(NSMutableArray *)_cards flag:(int)_flag;
- (void) getSingle:(NSMutableArray *)_cards flag:(int)_flag;
- (void) initCardtHash:(NSMutableArray *)_cards;
- (void) getMaxCards:(NSMutableArray*)cards;
//- (void) manageCardsOnHand:(Card *)_card;
- (void) replaceCards:(int)i cards:(NSMutableArray *)_card;
- (void) print_hash;
-(void) giveShowCards:(NSMutableArray *)_cards;
- (void) giveSingleCard:(Card *)_card;
-(void) add_into_hash:(cardType)_cardtype _card:(NSMutableArray*) _card;
- (void) add_into_hash_single:(cardType)_cardtype _card:(Card *)_card;
- (void) getMaxCards:(NSMutableArray*)cards;
- (void) setHashCardsFlag:(NSMutableArray *)_cards flagCard:(NSMutableArray *)_flagcard flag:(int) _flag;
- (void)removeCardFromOnHand:(NSMutableArray *)_cardsOnHand object:(NSMutableArray *)_selectCards;

@end