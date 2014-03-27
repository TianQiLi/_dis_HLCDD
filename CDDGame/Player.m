//
//  Player.m
//  CDDGame
//
//  Created by  on 12-8-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "CardType.h"
#import "Card.h"
#import "SimpleAudioEngine.h"
@implementation Player

@synthesize playerName;
@synthesize playerState;
@synthesize playerType;
@synthesize playerPos;
@synthesize onHandCardsNum;
@synthesize selectCardsNum; 
@synthesize selectCards;
@synthesize cardsOnHand;
@synthesize lastCards;
@synthesize showedAllCards;
@synthesize tScore;
@synthesize scoreGet;
@synthesize currentScore;
@synthesize isShowCard;

@synthesize needSquare3;
@synthesize maxSingle;
@synthesize secondSingle;
@synthesize maxCouple;
@synthesize _isMaxSingle;
@synthesize _isSecondSingle;
@synthesize _isMaxCouple;
@synthesize whenAnyOneSingle;
@synthesize needMaxCard;
@synthesize cardList;
@synthesize isLastOne;


-(id)initPlayerWithPlayerType:(PlayerType)playerType1 PlayerState:(PlayerState)playerState1 Postion:(int)playerPos1
{
    //[self init];
    
    self.playerState = playerState1;
    self.playerType  = playerType1;
    self.playerPos = playerPos1;
    self.cardsOnHand = [[NSMutableArray alloc]init];
    self.selectCards = [[NSMutableArray alloc]init];
    self.lastCards   = [[NSMutableArray alloc]init];
    
    self.onHandCardsNum = 13;
    self.selectCardsNum = 0;
    self.tScore = 0;
    self.scoreGet = 0;
    ////
   
      
    return self;
}

-(Boolean)hasDiamodsThree
{
    for (int i=0; i<cardsOnHand.count; i++) 
    {
        Card* cardTemp = [cardsOnHand objectAtIndex:i];
        if (cardTemp.cardNum == 3 && cardTemp.suit == DIAMONDS) 
            return YES;
    }
    return NO;
}

-(Boolean)selectDiamodsThree
{
    for(int i=0; i<selectCards.count; i++)
    {
        Card* cardTemp = [selectCards objectAtIndex:i];
        if(cardTemp.cardNum == 3 && cardTemp.suit == DIAMONDS)
            return YES;
    }
    return NO;
}

-(void)selectCardsAction:(NSMutableArray*)player
{
    if(playerType == COMPUTER)
    {
        if(lastCards.count != 0)
        {
            for(int i=0; i<lastCards.count; i++)
            {
                Card* cardTemp = [lastCards objectAtIndex:i];
                cardTemp.visible = NO;
            }
        }
        
        Card* cardTemp = [cardsOnHand objectAtIndex:onHandCardsNum-1];
        [cardTemp setIsSelect:YES];
        [selectCards addObject:cardTemp];
        selectCardsNum++;
    }
}

-(void)showCard:(id)game
{
    [lastCards removeAllObjects];
//        lastCards = [[NSMutableArray alloc]init];
    NSLog(@"%d",self.selectCards.count);
    switch(playerPos)
    {
        case 0:
            break;
        case 1:
        {
            if (cardList == nil) {
                cardList = [[NSMutableArray alloc]init];
            }
            for (int i = 0; i < cardList.count; i++) {
                Card * cardTemp =[cardList objectAtIndex:i];
                cardTemp.visible = NO;
            }
            [cardList removeAllObjects];
            if (self.selectCards.count != 0) {
                for (int i=0; i < self.selectCards.count; i++) 
                {    
                    Card *   cardTemp = [self.selectCards objectAtIndex:i];
                    //出牌的位置待定
                    cardTemp.visible = YES;
                    cardTemp.scale=0.42;
                    [cardTemp runAction:[CCPlace actionWithPosition:CGPointMake(335.0f+i*13.0f, 190.0f)]];
                    [game addChild:cardTemp ];
                    [cardList addObject:cardTemp];
                    NSLog(@"%d",cardList.count);
                    NSLog(@"%d",111);
                }
                [[SimpleAudioEngine sharedEngine] playEffect:@"launch_deny2.wav"];

            }else{
                isShowCard = NO;
            }
        }
            break;
        case 2:
        {
            if (cardList == nil) {
                cardList = [[NSMutableArray alloc]init];
            }
            for (int i = 0; i < self.cardList.count; i++) {
                Card * cardTemp =[self.cardList objectAtIndex:i];
                cardTemp.visible = NO;
            }
            [cardList removeAllObjects];
            if (self.selectCards.count != 0) {
                for (int i=0; i < self.selectCards.count; i++) 
                {    
                    Card *   cardTemp = [self.selectCards objectAtIndex:i];
                    //出牌的位置待定
                    cardTemp.visible = YES;
                    cardTemp.scale=0.42;
                    [cardTemp runAction:[CCPlace actionWithPosition:CGPointMake(225.0f+i*13.0f, 230.0f)]];
                    [game addChild:cardTemp ];
                    [self.cardList addObject:cardTemp];
                    NSLog(@"%d",111);
                }
                [[SimpleAudioEngine sharedEngine] playEffect:@"launch_deny2.wav"];

            }else{
                isShowCard = NO;
            }
        }
            break;
        case 3:
        {
            if (cardList == nil) {
                cardList = [[NSMutableArray alloc]init];
            }
            for (int i = 0; i < self.cardList.count; i++) {
                Card * cardTemp =[self.cardList objectAtIndex:i];
                cardTemp.visible = NO;
            }
            [cardList removeAllObjects];
            if (self.selectCards.count != 0) {
                for (int i=0; i < self.selectCards.count; i++) 
                {    
                    Card *   cardTemp = [self.selectCards objectAtIndex:i];
                    //出牌的位置待定
                    cardTemp.visible = YES;
                    cardTemp.scale=0.42;
                    [cardTemp runAction:[CCPlace actionWithPosition:CGPointMake(115.0f+i*13.0f, 190.0f)]];
                    [game addChild:cardTemp ];
                    [self.cardList addObject:cardTemp];
                    NSLog(@"%d",111);
                }
                [[SimpleAudioEngine sharedEngine] playEffect:@"launch_deny2.wav"];

            }else{
                isShowCard = NO;
            }
        }
            break;
    }
    isShowCard = YES;
    for(int i=0; i < selectCards.count; i++)
    {
        [lastCards addObject:[selectCards objectAtIndex:i]];
//            [cardsOnHand removeObject:[selectCards objectAtIndex:i]];
    }
    self.onHandCardsNum = cardsOnHand.count;
    
    if (showedAllCards == nil) {
        showedAllCards = [[NSMutableArray alloc]
                          init];
    }
    for (int i = 0 ; i < cardList.count ; i ++) {
        Card *   cardTemp = [self.cardList objectAtIndex:i];
        [self.showedAllCards addObject:cardTemp];
        
    }
    
    /*Test*/
    for (int i = 0; i < showedAllCards.count; i ++ ) {
        Card *   cardTemp = [self.showedAllCards objectAtIndex:i];
        NSLog(@"Test :  %d %d", cardTemp.cardNum,
              cardTemp.suit);
    }
        
//        [self.selectCards removeAllObjects]; 
//        selectCards = [[NSMutableArray alloc]init];

//        selectCardsNum = 0;
    
}

-(int)scoreCard//计算得分
{ 
    
    if(cardsOnHand.count < 8)
        scoreGet = cardsOnHand.count;
    else if(cardsOnHand.count>=8 && cardsOnHand.count<10)
        scoreGet = 2*cardsOnHand.count;
    else if(cardsOnHand.count>=10 && cardsOnHand.count<13)
        scoreGet = 3*cardsOnHand.count;
    else if(cardsOnHand.count == 13)
        scoreGet = 4*cardsOnHand.count;
    
    for(int i=0; i<cardsOnHand.count; i++)
    {
        Card* cardTemp = [cardsOnHand objectAtIndex:i];
        if(cardTemp.suit == 4 && cardTemp.cardNum == 2+14 && cardsOnHand.count >= 8)
        {
            scoreGet = scoreGet * 2;
            break;
        }
    }
    return scoreGet;
}

-(int)totalScore:(NSMutableArray *)player ScoreZero:(int)scoreZero ScoreOne:(int)scoreOne ScoreTwo:(int)scoreTwo ScoreThree:(int)scoreThree
{
    switch (playerPos) 
    {
        case 0:
        {
            tScore = scoreOne+scoreTwo+scoreThree-3*scoreZero;
            return tScore;
        }
            break;
        case 1:
        {
            tScore = scoreZero+scoreTwo+scoreThree-3*scoreOne;
            return tScore;
        }
            break;
        case 2:
        {
            tScore = scoreZero+scoreOne+scoreThree-3*scoreTwo;
            return tScore;
        }
            break;
        case 3:
        {
            tScore = scoreZero+scoreOne+scoreTwo-3*scoreThree;
            return tScore;
        }
        default:
            break;
    }
    return tScore;
}

-(void) giveShowCards:(NSMutableArray *)_cards
{
    //    NSMutableArray * temp = [[NSMutableArray alloc]init];
    for (int i = 0; i < [_cards count]; i++) {
        //        Card * _card = [[Card alloc]init];
        Card * _card = [_cards objectAtIndex:i];
        [selectCards addObject:_card];
        //        [_card release];
    }
    //    return temp;
}

- (void) giveSingleCard:(Card *)_card
{
    //    NSMutableArray * temp = [[NSMutableArray alloc]init];
    //    Card * card = [[Card alloc]init];
    Card * card = _card;
    [selectCards addObject:card];
    //    [card release];
    //    return temp;
}

//AI出牌策略
- (void) playerShowCards
{
    [self initCardtHash:cardsOnHand];//构建哈希表
    [selectCards removeAllObjects];
    
    if (cardsOnHand.count ==13 && needSquare3 == YES) {
        if ([cardHash[STRAIGHTFLUSH] count] != 0) {
            for (int i = 0; i < [cardHash[STRAIGHTFLUSH] count]; i++) {
                int j;
                for (j = 0; j < 5; j++) {
                    if ([CardType isEqual:[[cardHash[STRAIGHTFLUSH] objectAtIndex:i] objectAtIndex:j]]) {
                        [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];
                    }
                }
                if (j < 5) {
                    break;
                }
            }
        }
        
        if ([cardHash[KINGTONG] count] != 0 && [selectCards count] == 0) {
            for (int i = 0; i < [cardHash[KINGTONG] count]; i++) {
                int j;
                for (j = 0; j < 5; j++) {
                    //                    Card * _card = [[cardHash[KINGTONG] objectAtIndex:i] objectAtIndex:j];
                    if ([CardType isEqual:[[cardHash[KINGTONG] objectAtIndex:i] objectAtIndex:j]]) {
                        [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];
                    }
                }
                if (j < 5) {
                    break;
                }
            }
        }
        
        if ([cardHash[CAPTURE] count] != 0 && [selectCards count] == 0) {
            for (int i = 0; i < [cardHash[CAPTURE] count]; i++) {
                int j;
                for (j = 0; j < 5; j++) {
                    if ([CardType isEqual:[[cardHash[CAPTURE] objectAtIndex:i] objectAtIndex:j]]) {
                        [self giveShowCards:[cardHash[CAPTURE] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];
                    }
                }
                if (j < 5) {
                    break;
                }
            }
        }
        
        if ([cardHash[FLUSH] count] != 0 && [selectCards count] == 0) {
            for (int i = 0; i < [cardHash[FLUSH] count]; i++) {
                int j;
                for (j = 0; j < 5; j++) {
                    if ([CardType isEqual:[[cardHash[FLUSH] objectAtIndex:i] objectAtIndex:j]]) {
                        [self giveShowCards:[cardHash[FLUSH] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];
                    }
                }
                if (j < 5) {
                    break;
                }
            }
        }
        
        if ([cardHash[MIXSEQ] count] != 0 && [selectCards count] == 0) {
            for (int i = 0; i < [cardHash[MIXSEQ] count]; i++) {
                int j;
                for (j = 0; j < 5; j++) {
                    if ([CardType isEqual:[[cardHash[MIXSEQ] objectAtIndex:i] objectAtIndex:j]]) {
                        [self giveShowCards:[cardHash[MIXSEQ] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];
                    }
                }
                if (j < 5) {
                    break;
                }
            }
        }
        
        if ([cardHash[THREE] count] != 0 && [selectCards count] == 0) {
            for (int i = 0; i < [cardHash[THREE] count]; i++) {
                int j;
                for (j = 0; j < 3; j++) {
                    if ([CardType isEqual:[[cardHash[THREE] objectAtIndex:i] objectAtIndex:j]]) {
                        [self giveShowCards:[cardHash[THREE] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];
                    }
                }
                if (j < 3) {
                    break;
                }
            }
        }
        
        if ([cardHash[COUPLE] count] != 0 && [selectCards count] == 0) {
            for (int i = 0; i < [cardHash[COUPLE] count]; i++) {
                int j;
                for (j = 0; j < 2; j++) {
                    if ([CardType isEqual:[[cardHash[COUPLE] objectAtIndex:i] objectAtIndex:j]]) {
                        [self giveShowCards:[cardHash[COUPLE] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];
                    }
                }
                if (j < 2) {
                    break;
                }
            }
        }
        
        if ([cardHash[SINGLE] count] != 0 && [selectCards count] == 0) {
            for (int i = 0; i < [cardHash[SINGLE] count]; i++) {
                if ([CardType isEqual:[cardHash[SINGLE] objectAtIndex:i]]) {
                    [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:i]];
                    break;
                }else{
                    [selectCards removeAllObjects];
                }
            }
        }
    }
        
    if (cardsOnHand.count > 8 && needSquare3 == NO) {
        if (([cardHash[STRAIGHTFLUSH] count] != 0 || [cardHash[KINGTONG] count] != 0 || [cardHash[CAPTURE] count] != 0) && needMaxCard == NO) 
            //若有同花顺、四带一、三代二时，有顺子或同花则直接打出，无则去单最小打出
        {
            [CardType sortCards:cardHash[SINGLE]];
            if ([cardHash[MIXSEQ] count] != 0) 
            {
                [self giveShowCards:[cardHash[MIXSEQ] objectAtIndex:0]];
            }else if([cardHash[FLUSH] count] != 0){
                [self giveShowCards:[cardHash[FLUSH] objectAtIndex:0]];
            }else if([cardHash[SINGLE] count] != 0  && ([[cardHash[SINGLE] objectAtIndex:0] cardNum] != 2+14)){
                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
            }else if([cardHash[COUPLE] count] != 0){
                [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
            }else if([cardHash[THREE] count] != 0){
                [self giveShowCards:[cardHash[THREE] objectAtIndex:0]];
            }else if(cardHash[CAPTURE].count != 0){
                [self giveShowCards:[cardHash[CAPTURE] objectAtIndex:0]];
            }else if(cardHash[KINGTONG].count != 0){
                [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:0]];
            }else if(cardHash[STRAIGHTFLUSH].count != 0){
                [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:0]];
            }else{
                [selectCards removeAllObjects];
            }
        }else if(_isMaxCouple == YES && [cardHash[COUPLE] count] > 1)//有对最大则打对最小
        {
            [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
            
        }else if(_isMaxSingle == YES && needMaxCard == NO && cardHash[COUPLE].count != 0)//有单最大双有3、4则打3、4，无则打单最小
        {
            if ([[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0] cardNum] == 3 || [[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0] cardNum] == 4) {
                [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
            }else{
                if ([cardHash[SINGLE] count] != 0 && needMaxCard != YES) {
                    
                    [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
                }
            }
        }else if([cardHash[MIXSEQ] count] != 0)//有顺子则打出
        {
            [self giveShowCards:[cardHash[MIXSEQ] objectAtIndex:0]];
        }else if([cardHash[FLUSH] count] != 0)//有同花则打出
        {
            [self giveShowCards:[cardHash[FLUSH] objectAtIndex:0]];
        }else if(cardHash[CAPTURE].count != 0)//有三带二则打出
        {
            [self giveShowCards:[cardHash[CAPTURE] objectAtIndex:0]];
        }else if(cardHash[KINGTONG].count != 0)//有四带一则打出
        {
            [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:0]];
        }else if([cardHash[STRAIGHTFLUSH] count] != 0)//有同花顺则打出
        {
            [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:0]];
        }else if([cardHash[THREE] count] != 0)//有三张则打出
        {
            [self giveShowCards:[cardHash[THREE] objectAtIndex:0]];
        }else//比较对和单张，打出最小数字，处理单张
        {
            if (needMaxCard != YES) //当不需要顶大时
            {
                if ([cardHash[SINGLE] count] != 0 && [cardHash[COUPLE] count] != 0) {
                    Card * _card1 = [[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0];
                    Card * _card2 = [cardHash[SINGLE] objectAtIndex:0];
                    if ([_card1 compareLess:_card2]) {
                        [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                    }else{
                        [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
                    }
                }else if([cardHash[SINGLE] count] == 0 && [cardHash[COUPLE] count] != 0){
                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                }else if([cardHash[SINGLE] count] != 0 && [cardHash[COUPLE] count] == 0){
                    [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
                }else{
                    [selectCards removeAllObjects];//处理牌出错
                }
            }else if(needMaxCard == YES)//顶大时
            {
                if ([cardHash[COUPLE] count] != 0) {
                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                }else{
                    [CardType sortCards:cardsOnHand];
                    [self giveSingleCard:[cardsOnHand objectAtIndex:(cardsOnHand.count - 1)]];
                }
            }else{
                [selectCards removeAllObjects];//处理牌出错
            }
        }
    }
    
    if ((3 < cardsOnHand.count)&&(cardsOnHand.count < 9))
    {
        if(_isMaxCouple == YES && [cardHash[COUPLE] count] > 1)//有对最大则打对最小
        {
            [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
        }else if([cardHash[STRAIGHTFLUSH] count] != 0)//有同花顺则打出
        {
            [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:0]];
        }else if(cardHash[KINGTONG].count != 0)//有四带一则打出
        {
            [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:0]];
        }else if(cardHash[CAPTURE].count != 0)//有三带二则打出
        {
            [self giveShowCards:[cardHash[CAPTURE] objectAtIndex:0]];
        }else if([cardHash[MIXSEQ] count] != 0)//有顺子则打出
        {
            [self giveShowCards:[cardHash[MIXSEQ] objectAtIndex:0]];
        }else if([cardHash[FLUSH] count] != 0)//有同花则打出
        {
            [self giveShowCards:[cardHash[FLUSH] objectAtIndex:0]];
        }else if([cardHash[THREE] count] != 0)//有三张则打出
        {
            [self giveShowCards:[cardHash[THREE] objectAtIndex:0]];
        }else if(_isMaxSingle == YES && needMaxCard == NO)//有单张最大双有3、4则打3、4，无则打单最小
        {
            if (cardHash[COUPLE].count != 0) {
                if ([[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0] cardNum] == 3 || [[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0] cardNum] == 4) {
                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                }else if([cardHash[SINGLE] count] > 1 && needMaxCard != YES){
                    [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
                }else{
                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                }
            }else if([cardHash[SINGLE] count] != 0 && needMaxCard != YES){
                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
            }else{
                [selectCards removeAllObjects];//处理牌出错
            }
        }else//比较对和单张，打出最小数字，处理单张
        {
            if (needMaxCard == NO) //当不需要顶大时
            {
                if ([cardHash[SINGLE] count] != 0 && [cardHash[COUPLE] count] != 0) {
                    Card * _card1 = [[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0];
                    [CardType sortCards:cardHash[SINGLE]];
                    Card * _card2 = [cardHash[SINGLE] objectAtIndex:0];
                    if ([_card1 compareLess:_card2]) {
                        [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                    }else{
                        [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
                    }
                }else if([cardHash[SINGLE] count] == 0 && [cardHash[COUPLE] count] != 0){
                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                }else if([cardHash[SINGLE] count] != 0 && [cardHash[COUPLE] count] == 0){
                    [CardType sortCards:cardHash[SINGLE]];
                    [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
                }else{
                    [selectCards removeAllObjects];//处理牌出错
                }
            }else if(needMaxCard == YES)//顶大时
            {
                if ([cardHash[COUPLE] count] != 0) {
                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                }else{
                    [CardType sortCards:cardsOnHand];
                    [self giveSingleCard:[cardsOnHand objectAtIndex:(cardsOnHand.count - 1)]];                    
                }
            }else{
                [selectCards removeAllObjects];//处理牌出错
            }
        }
    }
    
    if (cardsOnHand.count == 3) {
        if ([cardHash[THREE] count] != 0) //三张都为同号
        {
            [self giveShowCards:[cardHash[THREE] objectAtIndex:0]];
        }else if(_isMaxCouple == YES)//当有对最大时
        {
            [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
        }else if(needMaxCard == YES)//当顶大时
        {
            if ([cardHash[COUPLE] count] != 0) {
                [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
            }else if([cardHash[SINGLE] count] != 0)
            {
                [CardType sortCards:cardHash[SINGLE]]; 
                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:2]];            
            }else{
                [selectCards removeAllObjects];//处理牌出错
            }
        }else if(_isMaxSingle == YES)//当有单最大时
        {
            if ([cardHash[COUPLE] count] != 0) {
                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
            }else{
                [CardType sortCards:cardHash[SINGLE]]; 
                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:1]];            
            }
        }else if(_isMaxSingle == NO)//当没有单最大时
        {
            if ([cardHash[SINGLE] count] != 0 && [cardHash[COUPLE] count] != 0) {
                Card * _card1 = [[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0];
                [CardType sortCards:cardHash[SINGLE]];
                Card * _card2 = [cardHash[SINGLE] objectAtIndex:0];
                if ([_card1 compareLess:_card2]) {
                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
                }else{
                    [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
                }
            }else if([cardHash[COUPLE] count] == 0){
                [CardType sortCards:cardHash[SINGLE]];
                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
            }else{
                [selectCards removeAllObjects];//处理牌出错
            }
        }else//出错
        {
            [selectCards removeAllObjects];//处理牌出错
        }
    }
    
    if (cardsOnHand.count == 2) {
        if ([cardHash[COUPLE] count] != 0) //为对时
        {
            [self giveShowCards:[cardHash[COUPLE] objectAtIndex:0]];
        }else if(_isMaxSingle == YES || needMaxCard == YES)//当有单最大或顶大时
        {
            [CardType sortCards:cardHash[SINGLE]]; 
            [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:1]];            
        }else if(_isMaxSingle == NO)//当没有单最大时
        {
            [CardType sortCards:cardHash[SINGLE]]; 
            [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
        }else{
            [selectCards removeAllObjects];//处理牌出错
        }
    }
    
    if (cardsOnHand.count == 1) 
    {
        [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:0]];            
    }
    
//    int i, j;
//    int number = selectCards.count;
//    for (i = 0; i < number; i++) {
//        for (j = 0; j < [cardsOnHand count]; ) {
//            if ([[selectCards objectAtIndex:i] isSameCard:[cardsOnHand objectAtIndex:j]]) {
//                [cardsOnHand removeObjectAtIndex:j];
//                break;
//            }else{
//                j++;
//            }
//        }
//    }
    [self removeCardFromOnHand:cardsOnHand object:selectCards];
    
//    NSLog(@"%d",cardsOnHand.count);

//    for (int i = 0; i < selectCards.count; i++) {
//        NSLog(@"%d,%d",[[selectCards objectAtIndex:i] cardNum],[[selectCards objectAtIndex:i] suit]);
//    }
    needSquare3 = NO;
}

- (void)removeCardFromOnHand:(NSMutableArray *)_cardsOnHand object:(NSMutableArray *)_selectCards
{
    int i, j;
    int number = _selectCards.count;
    for (i = 0; i < number; i++) {
        for (j = 0; j < [_cardsOnHand count]; ) {
            if ([[_selectCards objectAtIndex:i] isSameCard:[_cardsOnHand objectAtIndex:j]]) {
                [_cardsOnHand removeObjectAtIndex:j];
                break;
            }else{
                j++;
            }
        }
    }
}

//AI跟牌策略
- (void) playerFollowCards:(NSMutableArray *)_cards
{
    
//    NSLog(@"%d",_isMaxSingle);
//    NSLog(@"%d",_isSecondSingle);
//    NSLog(@"%d",_isMaxCouple);
//    NSLog(@"%d",whenAnyOneSingle);
//    NSLog(@"%d",_cards.count);

    needSquare3 = NO;
    [self initCardtHash:cardsOnHand];//构建哈希表
    [selectCards removeAllObjects];
    [CardType sortCards:_cards];//排序
    
    switch ([CardType getCardType:_cards]) {
        case STRAIGHTFLUSH:
            if ([cardHash[STRAIGHTFLUSH] count] != 0) {
                for (int i = 0; i < [cardHash[STRAIGHTFLUSH] count]; i++) {
                    [CardType sortCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:i]];
                    Card * _card = [[cardHash[STRAIGHTFLUSH] objectAtIndex:i] objectAtIndex:4];
                    if ([[_cards objectAtIndex:4] compareLess:_card]) {
                        [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];//pass
                    }
                }
            }else{
                [selectCards removeAllObjects];//pass
            }
            break;
            
        case KINGTONG:
            if ([cardHash[KINGTONG] count] != 0) {
                for (int i = 0; i < [cardHash[KINGTONG] count]; i++) {
                    [CardType sortCards:[cardHash[KINGTONG] objectAtIndex:i]];
                    Card * _card = [[cardHash[KINGTONG] objectAtIndex:i] objectAtIndex:2];
                    if ([[_cards objectAtIndex:2] compareLess:_card]) {
                        [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];//pass
                    }
                }
            }
            
            if(([cardHash[STRAIGHTFLUSH] count] != 0) && [selectCards count] == 0){
                [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:0]];
            }else if([selectCards count] == 0){
                [selectCards removeAllObjects];//pass
            }
            break;
            
        case CAPTURE:
            if ([cardHash[CAPTURE] count] != 0) {
                for (int i = 0; i < [cardHash[CAPTURE] count]; i++) {
                    [CardType sortCards:[cardHash[CAPTURE] objectAtIndex:i]];
                    Card * _card = [[cardHash[CAPTURE] objectAtIndex:i] objectAtIndex:2];
                    if ([[_cards objectAtIndex:2] compareLess:_card]) {
                        [self giveShowCards:[cardHash[CAPTURE] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];//pass
                    }
                }
            }
            if ([cardHash[KINGTONG] count] != 0 && [selectCards count] == 0) {
                [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:0]];
            }else if([cardHash[STRAIGHTFLUSH] count] != 0 && [selectCards count] == 0){
                [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:0]];
            }else if([selectCards count] == 0){
                [selectCards removeAllObjects];//pass
            }
            break;
            
        case FLUSH:
            if ([cardHash[FLUSH] count] != 0) {
                for (int i = 0; i < [cardHash[FLUSH] count]; i++) {
                    [CardType sortCards:[cardHash[FLUSH] objectAtIndex:i]];
                    Card * _card = [[cardHash[FLUSH] objectAtIndex:i] objectAtIndex:4];
                    if ([[_cards objectAtIndex:4] compareLess:_card]) {
                        [self giveShowCards:[cardHash[FLUSH] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];//pass
                    }
                }
            }
            if ([cardHash[CAPTURE] count] != 0 && [selectCards count] == 0) {
                [self giveShowCards:[cardHash[CAPTURE] objectAtIndex:0]];
            }else if([cardHash[KINGTONG] count] != 0 && [selectCards count] == 0){
                [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:0]];
            }else if([cardHash[STRAIGHTFLUSH] count] != 0 && [selectCards count] == 0){
                [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:0]];
            }else if([selectCards count] == 0){
                [selectCards removeAllObjects];//pass
            }
            break;
            
        case MIXSEQ:
            if ([cardHash[MIXSEQ] count] != 0) {
                for (int i = 0; i < [cardHash[MIXSEQ] count]; i++) {
                    [CardType sortCards:[cardHash[MIXSEQ] objectAtIndex:i]];
                    Card * _card = [[cardHash[MIXSEQ] objectAtIndex:i] objectAtIndex:4];
                    if ([[_cards objectAtIndex:4] compareLess:_card]) {
                        [self giveShowCards:[cardHash[MIXSEQ] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];//pass
                    }
                }
            }
            if ([cardHash[FLUSH] count] != 0 && [selectCards count] == 0) {
                [self giveShowCards:[cardHash[FLUSH] objectAtIndex:0]];
            }else if([cardHash[CAPTURE] count] != 0 && [selectCards count] == 0){
                [self giveShowCards:[cardHash[CAPTURE] objectAtIndex:0]];
            }else if([cardHash[KINGTONG] count] != 0 && [selectCards count] == 0){
                [self giveShowCards:[cardHash[KINGTONG] objectAtIndex:0]];
            }else if([cardHash[STRAIGHTFLUSH] count] != 0 && [selectCards count] == 0){
                [self giveShowCards:[cardHash[STRAIGHTFLUSH] objectAtIndex:0]];
            }else if([selectCards count] == 0){
                [selectCards removeAllObjects];//pass
            }
            break;
            
        case THREE:
            if ([cardHash[THREE] count] != 0) {
                for (int i = 0; i < [cardHash[THREE] count]; i++) {
                    Card * _card = [[cardHash[THREE] objectAtIndex:i] objectAtIndex:0];
                    if ([[_cards objectAtIndex:0] compareLess:_card]) {
                        [self giveShowCards:[cardHash[THREE] objectAtIndex:i]];
                        break;
                    }else{
                        [selectCards removeAllObjects];//pass
                    }
                }
            }else{
                [selectCards removeAllObjects];//pass
            }
            break;
            
        case COUPLE:
            if (whenAnyOneSingle == YES) //当某一家为单时
            {
                if ([cardHash[COUPLE] count] != 0) {
                    for (int i = 0; i < [cardHash[COUPLE] count]; i++) {
                        Card * _card = [[cardHash[COUPLE] objectAtIndex:i] objectAtIndex:1];
                        if ([[_cards objectAtIndex:1] compareLess:_card]) {
                            [self giveShowCards:[cardHash[COUPLE] objectAtIndex:i]];
                            break;
                        }else{
                            [selectCards removeAllObjects];//pass
                        }
                    }
                }
                if ([selectCards count] == 0) {
                    [cardHash[COUPLE] removeAllObjects];
                    [self getCouple:cardsOnHand flag:6];
                    if ([cardHash[COUPLE] count] != 0) {
                        for (int i = 0; i < [cardHash[COUPLE] count]; i++) {
                            Card * _card = [[cardHash[COUPLE] objectAtIndex:i] objectAtIndex:1];
                            if ([[_cards objectAtIndex:1] compareLess:_card]) {
                                [self giveShowCards:[cardHash[COUPLE] objectAtIndex:i]];
                                break;
                            }else{
                                [selectCards removeAllObjects];//pass
                            }
                        }
                    }
                }
                if ([selectCards count] == 0) {
                    [cardHash[COUPLE] removeAllObjects];
                    [self getCouple:cardsOnHand flag:9];
                    if ([cardHash[COUPLE] count] != 0) {
                        for (int i = 0; i < [cardHash[COUPLE] count]; i++) {
                            Card * _card = [[cardHash[COUPLE] objectAtIndex:i] objectAtIndex:1];
                            if ([[_cards objectAtIndex:1] compareLess:_card]) {
                                [self giveShowCards:[cardHash[COUPLE] objectAtIndex:i]];
                                break;
                            }else{
                                [selectCards removeAllObjects];//pass
                            }
                        }
                    }
                }
            }else//正常跟牌状态下
            {
                if (_isMaxCouple == YES) {
                    NSMutableArray *cards = [NSMutableArray arrayWithArray:_cards];
                    //                    [cardHash[COUPLE] removeAllObjects];
                    //                    [self getCouple:cardsOnHand flag:6];
                    if ([cardHash[COUPLE] count] != 0) {
                        for (int i = 0; i < [cardHash[COUPLE] count]; i++) {
                            Card * _card = [[cardHash[COUPLE] objectAtIndex:i] objectAtIndex:1];
                            if ([[cards objectAtIndex:1] compareLess:_card]) {
                                [self giveShowCards:[cardHash[COUPLE] objectAtIndex:i]];
                                break;
                            }else{
                                [selectCards removeAllObjects];//pass
                            }
                        }
                    }else{
                        NSMutableArray *cards = [NSMutableArray arrayWithArray:_cards];
                        [cardHash[COUPLE] removeAllObjects];
                        [self getCouple:cardsOnHand flag:6];
                        if ([cardHash[COUPLE] count] != 0) {
                            for (int i = 0; i < [cardHash[COUPLE] count]; i++) {
                                Card * _card = [[cardHash[COUPLE] objectAtIndex:i] objectAtIndex:1];
                                if ([[cards objectAtIndex:1] compareLess:_card]) {
                                    [self giveShowCards:[cardHash[COUPLE] objectAtIndex:i]];
                                    break;
                                }else{
                                    [selectCards removeAllObjects];//pass
                                }
                            }
                        }
                    }
                }else if(_isMaxCouple == NO){
                    NSMutableArray *cards = [NSMutableArray arrayWithArray:_cards];
                    
                    [cardHash[COUPLE] removeAllObjects];
                    [self getCouple:cardsOnHand flag:6];
                    if ([cardHash[COUPLE] count] != 0) {
                        for (int i = 0; i < [cardHash[COUPLE] count]; i++) {
                            Card * _card = [[cardHash[COUPLE] objectAtIndex:i] objectAtIndex:1];
                            if ([[cards objectAtIndex:1] compareLess:_card]) {
                                [self giveShowCards:[cardHash[COUPLE] objectAtIndex:i]];
                                break;
                            }else{
                                [selectCards removeAllObjects];//pass
                            }
                        }
                    }
                }else{
                    [selectCards removeAllObjects];//pass
                }
            }
            
            if ([selectCards count] != 0) {
                if ([[selectCards objectAtIndex:1] cardNum] == 2+14) {
                    if ([[_cards objectAtIndex:1] cardNum] < 1+13) {
                        [selectCards removeAllObjects];//pass
                    }
                }
            }
            break;
            
        case SINGLE:
            if (needMaxCard == YES) //当需要顶大时
            {
                [CardType sortCards:cardsOnHand];
                for (int i = 0; i < cardsOnHand.count; i++) {
                    Card * _card1 = [_cards objectAtIndex:0];
                    Card * _card2 = [cardsOnHand objectAtIndex:(cardsOnHand.count - i -1)];
                    if ([_card1 compareLess:_card2]) {
                        [self giveSingleCard:_card2];
                        break;
                    }else{
                        [selectCards removeAllObjects];//pass
                    }
                }
            }else//当不需要顶大，正常出牌时
            {
                if (_isMaxSingle == YES) //当单有最大时
                {
                    if (cardsOnHand.count == 2) //单有最大时对两张的处理，出最大
                    {
                        [CardType sortCards:cardsOnHand];
                        Card * _card1 = [cardsOnHand objectAtIndex:1];
                        Card * _card2 = [_cards objectAtIndex:0];
                        if ([_card2 compareLess:_card1]) {
                            [self giveSingleCard:_card1];
                        }else{
                            [selectCards removeAllObjects];
                        }
                    }else if(cardsOnHand.count == 3)//单有最大对三张的处理，能出中间则出中间牌，有对则直接出最大
                    {
                        if (cardHash[COUPLE].count != 0 && _isMaxCouple == NO) {
                            [CardType sortCards:cardsOnHand];
                            Card * _card1 = [cardsOnHand objectAtIndex:2];
                            Card * _card2 = [_cards objectAtIndex:0];
                            if ([_card2 compareLess:_card1]) {
                                [self giveSingleCard:_card1];
                            }else{
                                [selectCards removeAllObjects];
                            }
                        }else{
                            [CardType sortCards:cardsOnHand];
                            Card * _card1 = [cardsOnHand objectAtIndex:1];
                            Card * _card2 = [_cards objectAtIndex:0];
                            if ([_card2 compareLess:_card1]) {
                                [self giveSingleCard:_card1];
                            }else if([_card2 compareLess:[cardsOnHand objectAtIndex:2]]){
                                [self giveSingleCard:[cardsOnHand objectAtIndex:2]];
                            }else{
                                [selectCards removeAllObjects];
                            }
                        }
                    }else{
                        if ([cardHash[SINGLE] count] != 0) {
                            for (int i = 0; i < [cardHash[SINGLE] count]; i++) {
                                Card * _card1 = [_cards objectAtIndex:0];
                                Card * _card2 = [cardHash[SINGLE] objectAtIndex:i];
                                if ([_card1 compareLess:_card2]) {
                                    [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:i]];
                                    break;
                                }else{
                                    [selectCards removeAllObjects];//pass
                                }
                            }
                        }
                        if(selectCards.count == 0){
                            [cardHash[SINGLE] removeAllObjects];
                            [self getSingle:cardsOnHand flag:3];
                            if ([cardHash[SINGLE] count] != 0) {
                                for (int i = 0; i < [cardHash[SINGLE] count]; i++) {
                                    Card * _card1 = [_cards objectAtIndex:0];
                                    Card * _card2 = [cardHash[SINGLE] objectAtIndex:i];
                                    if ([_card1 compareLess:_card2]) {
                                        [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:i]];
                                        break;
                                    }else{
                                        [selectCards removeAllObjects];//pass
                                    }
                                }
                            }
                        }
                        if (selectCards.count == 0) {
                            [cardHash[SINGLE] removeAllObjects];
                            [self getSingle:cardsOnHand flag:6];
                            if ([cardHash[SINGLE] count] != 0) {
                                for (int i = 0; i < [cardHash[SINGLE] count]; i++) {
                                    Card * _card1 = [_cards objectAtIndex:0];
                                    Card * _card2 = [cardHash[SINGLE] objectAtIndex:i];
                                    if ([_card1 compareLess:_card2]) {
                                        [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:i]];
                                        break;
                                    }else{
                                        [selectCards removeAllObjects];//pass
                                    }
                                }
                            }
                        }
                    }
                }else if(_isMaxSingle == NO)//当单没有最大时
                {
                    [cardHash[SINGLE] removeAllObjects];
                    [self getSingle:cardsOnHand flag:6];
                    [CardType sortCards:cardHash[SINGLE]];
                    if ([cardHash[SINGLE] count] != 0) {
                        for (int i = 0; i < [cardHash[SINGLE] count]; i++) {
                            Card * _card1 = [_cards objectAtIndex:0];
                            Card * _card2 = [cardHash[SINGLE] objectAtIndex:i];
                            if ([_card1 compareLess:_card2]) {
                                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:i]];
                                break;
                            }else{
                                [selectCards removeAllObjects];//pass
                            }
                        }
                    }else if([cardHash[SINGLE] count] == 0){
                        [self getSingle:cardsOnHand flag:9];
                        [CardType sortCards:cardHash[SINGLE]];
                        for (int i = 0; i < [cardHash[SINGLE] count]; i++) {
                            Card * _card1 = [_cards objectAtIndex:0];
                            Card * _card2 = [cardHash[SINGLE] objectAtIndex:i];
                            if ([_card1 compareLess:_card2]) {
                                [self giveSingleCard:[cardHash[SINGLE] objectAtIndex:i]];
                                break;
                            }else{
                                [selectCards removeAllObjects];//pass
                            }
                        }
                    }
                }else{
                    [selectCards removeAllObjects];//pass
                }
                
                if ([selectCards count] != 0 && whenAnyOneSingle == NO) {
//                    if ([[selectCards objectAtIndex:0] cardNum] == 2+14) //当出2时无A以上的则不出2
//                    {
//                        if ([[_cards objectAtIndex:0] cardNum] < 13) {
//                            [selectCards removeAllObjects];//pass
//                        }
//                    }
                    if (_isMaxSingle == NO && _isSecondSingle == YES && [[selectCards objectAtIndex:0] isSameCard:maxSingle] && whenAnyOneSingle == NO) //当拥有第二大单牌时则不出次牌
                    {
                        [selectCards removeAllObjects];//pass
                    }
                }
            }
            break;
            
        case INVALID:
            [selectCards removeAllObjects];//pass
            break;
            
        default:
            break;
    }
    
//    int i, j;
//    int number = selectCards.count;
//    for (i = 0; i < number; i++) {
//        for (j = 0; j < [cardsOnHand count]; ) {
//            if ([[selectCards objectAtIndex:i] isSameCard:[cardsOnHand objectAtIndex:j]]) {
//                [cardsOnHand removeObjectAtIndex:j];
//            }else{
//                j++;
//            }
//        }
//    }
    [self removeCardFromOnHand:cardsOnHand object:selectCards];
    NSLog(@"%d",selectCards.count);
}

- (void) setCardsFlag:(NSMutableArray *)_cards flagCard:(NSMutableArray *)_flagcard flag:(int) _flag
{
    for (int i = 0; i < [_flagcard count]; i++) {
        for (int j = 0; j < [_cards count]; j++) {
            if (([[_cards objectAtIndex:j] cardNum] == [[_flagcard objectAtIndex:i] cardNum]) && ([[_cards objectAtIndex:j] suit] == [[_flagcard objectAtIndex:i] suit])) {
                [[_cards objectAtIndex:j] setFlagValue:_flag];
            }
        }
    }
}

- (void) setHashCardsFlag:(NSMutableArray *)_cards flagCard:(NSMutableArray *)_flagcard flag:(int) _flag
{
    NSLog(@"count = %d",[_flagcard count]);
    
    for (int i = 0; i < [_flagcard count]; i++) {
        for (int j = 0; j < [_cards count]; j++) {
            
            for (int k = 0; k < [[_flagcard objectAtIndex:i] count]; k++) {
                if (([[_cards objectAtIndex:j] cardNum] == [[[_flagcard objectAtIndex:i] objectAtIndex:k] cardNum]) && ([[_cards objectAtIndex:j] suit] == [[[_flagcard objectAtIndex:i] objectAtIndex:k] suit])) {
                    [[_cards objectAtIndex:j] setFlagValue:_flag];
                }
            } 
        }
    }
}

//寻找单张最大、第二大，一对最大的牌
- (void) getMaxCards:(NSMutableArray*)cards
{
    if (maxSingle == nil) {
        maxSingle = [[Card alloc]init];
    }
    if (secondSingle == nil) {
        secondSingle = [[Card alloc]init];
    }
    if (maxCouple == nil) {
        maxCouple = [[Card alloc]init];
    }
    NSMutableArray *_cards = [NSMutableArray arrayWithArray:cards];
    
    [self initCardtHash:_cards];
    [cardHash[SINGLE] removeAllObjects];
    [self getSingle:_cards flag:6];
    if (cardHash[SINGLE].count == 0) {
        [self getSingle:_cards flag:9];
    }
    if (cardHash[SINGLE].count == 1) {
        Card * _card = [cardHash[SINGLE] objectAtIndex:0];
        [maxSingle initObjectWithType:_card.suit andNum:_card.cardNum];
        [secondSingle initObjectWithType:1 andNum:3];
    }else{
        Card * _card1 = [cardHash[SINGLE] objectAtIndex:([cardHash[SINGLE] count] - 1)];
        Card * _card2 = [cardHash[SINGLE] objectAtIndex:([cardHash[SINGLE] count] - 2)];
        [maxSingle initObjectWithType:_card1.suit andNum:_card1.cardNum];
        [secondSingle initObjectWithType:_card2.suit andNum:_card2.cardNum];
    }
//    NSLog(@"%d,%d",maxSingle.cardNum,maxSingle.suit);
//    NSLog(@"%d,%d",secondSingle.cardNum,secondSingle.suit);

    [self initCardtHash:_cards];
    [cardHash[COUPLE] removeAllObjects];
    [self getCouple:_cards flag:6];
    if ([cardHash[COUPLE] count] != 0) {
        Card * _card3 = [[cardHash[COUPLE] objectAtIndex:([cardHash[COUPLE] count] - 1)] objectAtIndex:1];
        [maxCouple initObjectWithType:_card3.suit andNum:_card3.cardNum];

    }else{
        [maxCouple initObjectWithType:1 andNum:3];
    }    
//    NSLog(@"%d,%d",maxSingle.cardNum,maxSingle.suit);
//    NSLog(@"%d,%d",secondSingle.cardNum,secondSingle.suit);
//    NSLog(@"%d,%d",maxCouple.cardNum,maxCouple.suit);

}

//添加到hash表
-(void) add_into_hash:(cardType)_cardtype _card:(NSMutableArray*) _card
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for(int i = 0; i < [_card count]; i++){
        //        Card* card = [[Card alloc] init];
        Card * card = [_card objectAtIndex:i];
        [temp addObject:card];
        //        [card release];
    }
    [cardHash[_cardtype] addObject:temp]; 
    [temp release];
}

//添加到单张
- (void) add_into_hash_single:(cardType)_cardtype _card:(Card *)_card
{
    //    Card* card = [[Card alloc] init];
    Card * card = _card;
    [cardHash[SINGLE] addObject:card];
    //    [card release];
}

//替换牌
- (void) replaceCards:(int)i cards:(NSMutableArray *)_card
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for(int j = 0; j < [_card count]; j++){
        //        Card* card = [[Card alloc] init];
        Card * card = [_card objectAtIndex:j];
        [temp addObject:card];
        //        [card release];
    }
    [cardHash[KINGTONG] replaceObjectAtIndex:i withObject:temp];
    [temp release];
}


- (void) initCardtHash:(NSMutableArray *)cards
{
    if (cardHash[0] == nil) {
        for(int i = 0; i < 9; i++){
            cardHash[i] = [[NSMutableArray alloc] init];
        }
    }
    NSMutableArray *_cards = [NSMutableArray arrayWithArray:cards];
    
    for (int i = 0; i < [_cards count]; i++) {
        [[_cards objectAtIndex:i] setFlagValue:0];
    }
    
    for (int i = 0; i < 9; i++) {
        [cardHash[i] removeAllObjects];
    }
    
    //    for (int i = 0; i < [cards count]; i++) {
    //        NSLog(@"number = %d,stype = %d",[[cards objectAtIndex:i] cardNumber],[[cards objectAtIndex:i] cardType]);
    //    }
    
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    NSMutableArray * temp_card = [[NSMutableArray alloc] init];
    int count = [_cards count];
    /*取出同花顺，添加到cardHash*******************************************************************/
    for (int i = 0; (i < 4)&&(count >= 5); i++) {
        for (int j = 0; j < [_cards count]; j++) {
            if ([[_cards objectAtIndex:j] flag] == 0) {
                if ([[_cards objectAtIndex:j] suit] == i) {
                    //                    Card * _card = [[Card alloc] init];
                    Card * _card = [_cards objectAtIndex:j];
                    [temp addObject:_card];
                    NSLog(@"count = %d",[temp count]);
                    //                    [_card release];
                }
            }
        }
        if ([temp count] >= 5) {
            [CardType sortCards:temp];
            for (int k = 0; (k < [temp count])&&([temp count] - k) > 4; ) {
                for (int d = k; d < 5+k; d++) {
                    [temp_card addObject:[temp objectAtIndex:d]];
                }
                if ([CardType getCardType:temp_card] == STRAIGHTFLUSH) {
                    [self add_into_hash:STRAIGHTFLUSH _card:temp_card];
                    [self setCardsFlag:_cards flagCard:temp_card flag:8];
                    [temp_card removeAllObjects];
                    k += 5;
                    count -=5;
                }else k +=1;
                [temp_card removeAllObjects];
            }
        }
        //        NSLog(@"count = %d",[temp count]);
        [temp removeAllObjects];
        //        temp = nil;
        
    }
    /*****************************************************************************************/
    /*选取四个一样的牌****************************************************************************/
    count = [_cards count];
    for (int i = 0; (i < count)&&(count >= 4); i++) {
        if ([[_cards objectAtIndex:i] flag] == 0) {
            [temp addObject:[_cards objectAtIndex:i]];
        }
    }
    NSLog(@"count = %d",[temp count]);
    
    [CardType sortCards:temp];
    
    for (int i = 0; i <[temp count] && [temp count] - i >= 4; ) 
    {
        if ([[temp objectAtIndex:i] cardNum] != [[temp objectAtIndex:i+1] cardNum]) {
            i++;
        }else if([[temp objectAtIndex:i+1] cardNum] != [[temp objectAtIndex:i+2] cardNum]){
            i++;
        }else if([[temp objectAtIndex:i+2] cardNum] != [[temp objectAtIndex:i+3] cardNum]){
            i++;
        }else{
            for (int k = i; k < i+4; k++) {
                [temp_card addObject:[temp objectAtIndex:k]];
            }
            i += 4;
            count -= 4;
            if ([[temp_card objectAtIndex:0] cardNum] != 2+14) {
                NSLog(@"count = %d",[temp_card count]);
                [self setCardsFlag:_cards flagCard:temp_card flag:7];
                [self add_into_hash:KINGTONG _card:temp_card];
            }
            [temp_card removeAllObjects];
        }
    }
    [temp removeAllObjects];
    
    /***************************************************************************************/
    /**选取三个同样的牌*************************************************************************/
    count = [_cards count];
    for (int i = 0; (i < count)&&(count >= 3); i++) {
        if ([[_cards objectAtIndex:i] flag] == 0) {
            [temp addObject:[_cards objectAtIndex:i]];
        }
    }
    if ([temp count] >= 3) {
        [CardType sortCards:temp];
        for (int i = 0; i < [temp count] && [temp count] - i >= 3; ) {
            if ([[temp objectAtIndex:i] cardNum] != [[temp objectAtIndex:i+1] cardNum]) {
                i++;
            }else if([[temp objectAtIndex:i+1] cardNum] != [[temp objectAtIndex:i+2] cardNum]){
                i++;
            }else{
                for (int k =i; k < i+3; k++) {
                    [temp_card addObject:[temp objectAtIndex:k]];
                }
                i += 3;
                count -= 3;
                if ([[temp_card objectAtIndex:0] cardNum] != 2+14) {
                    [self setCardsFlag:_cards flagCard:temp_card flag:5];
                    //                    [cardHash[THREE] addObject:temp_card];
                    [self add_into_hash:THREE _card:temp_card];
                }
                [temp_card removeAllObjects];
            }
        }
    }
    NSLog(@"count = %d",[cardHash[THREE] count]);
    [temp removeAllObjects];
    /*******************************************************************************/
    [self getFlush:_cards flag:5];//寻找同花
    [self getMixSeq:_cards flag:4];//寻找顺子 
    [self getCouple:_cards flag:3];//寻找对
    [self getSingle:_cards flag:2];//寻找单张
    NSLog(@"count = %d",[cardHash[FLUSH] count]);
    
    /*寻找四带一**********************************************************************/
    
    if ([cardHash[KINGTONG] count] != 0) {
        int count = [cardHash[KINGTONG] count];
        for (int i = 0; i < count; i++) {
            temp = [cardHash[KINGTONG] objectAtIndex:0];
            NSLog(@"count = %d",[temp count]);
            
            if ([cardHash[SINGLE] count] != 0 && [[cardHash[SINGLE] objectAtIndex:0] cardNum] != 2+14) {
                [temp addObject:[cardHash[SINGLE] objectAtIndex:0]];
                NSLog(@"count = %d",[temp count]);
                [self add_into_hash:KINGTONG _card:temp];
                NSLog(@"count = %d",[cardHash[KINGTONG] count]);
                NSLog(@"count = %d",[temp count]);
                [temp removeAllObjects];
                [cardHash[SINGLE] removeObjectAtIndex:0];
                [cardHash[KINGTONG] removeObjectAtIndex:0];
            }else if([cardHash[COUPLE] count] != 0){
                temp_card = [cardHash[COUPLE] objectAtIndex:0];
                NSLog(@"count = %d",[temp_card count]);
                //                Card * card = [[Card alloc]init];
                Card * card = [temp_card objectAtIndex:0];
                [temp addObject:card];
                //                [self replaceCards:i cards:temp];
                [self add_into_hash:KINGTONG _card:temp];
                //                [cardHash[SINGLE] addObject:[temp_card objectAtIndex:1]];
                [self add_into_hash_single:SINGLE _card:[temp_card objectAtIndex:1]];
                [CardType sortCards:cardHash[SINGLE]];//排序
                [temp_card removeAllObjects];
                //                [card release];
                [temp removeAllObjects];
                [cardHash[KINGTONG] removeObjectAtIndex:0];
                [cardHash[COUPLE] removeObjectAtIndex:0];
                
            }else if([cardHash[THREE] count] != 0){
                temp_card = [cardHash[THREE] objectAtIndex:0];
                //                [cardHash[THREE] removeObjectAtIndex:0];
                [temp addObject:[temp_card objectAtIndex:0]];
                [self add_into_hash:KINGTONG _card:temp];
                [temp_card removeObjectAtIndex:0];
                //                [cardHash[COUPLE] addObject:temp_card];
                [self add_into_hash:COUPLE _card:temp_card];
                [temp_card removeAllObjects];
                [cardHash[THREE] removeObjectAtIndex:0];
                [temp removeAllObjects];
                [cardHash[KINGTONG] removeObjectAtIndex:0];
                
            }else{
                for (int i = 0; i <2; i++) {
                    [temp_card addObject:[temp objectAtIndex:0]];
                    [temp removeObjectAtIndex:0];
                }
                
                [self add_into_hash:COUPLE _card:temp_card];
                [self add_into_hash:COUPLE _card:temp];
                [temp_card removeAllObjects];
                [temp removeAllObjects];
                [cardHash[KINGTONG] removeObjectAtIndex:0];
                
            }
            //            [temp removeAllObjects];
        }
        
        //        NSLog(@"count = %d",[cardHash[STRAIGHTFLUSH] count]);
        //        NSLog(@"count = %d",[cardHash[KINGTONG] count]);
        //        NSLog(@"count = %d",[[cardHash[KINGTONG] objectAtIndex:0] count]);
        //        for (int i = 0; i < [[cardHash[KINGTONG]objectAtIndex:0] count]; i++) {
        //            NSLog(@"number = %d,type = %d",[[[cardHash[KINGTONG] objectAtIndex:0] objectAtIndex:i] cardNumber],[[[cardHash[KINGTONG] objectAtIndex:0] objectAtIndex:i] cardType]);
        //        }
        //        NSLog(@"count = %d",[cardHash[CAPTURE] count]);
        //        NSLog(@"count = %d",[cardHash[THREE] count]);
        //        NSLog(@"count = %d",[cardHash[FLUSH] count]);
        //        NSLog(@"count = %d",[cardHash[MIXSEQ] count]);
        //        NSLog(@"count = %d",[cardHash[COUPLE] count]);
        ////        NSLog(@"count = %d",[[cardHash[COUPLE] objectAtIndex:0] count]);
        //        NSLog(@"count = %d",[cardHash[SINGLE] count]);
        
        [self setCardsFlag:_cards flagCard:cardHash[SINGLE] flag:1];
        [self setHashCardsFlag:_cards flagCard:cardHash[COUPLE] flag:2];
        //        NSLog(@"flag = %d",[[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0] flag]);
        [self setHashCardsFlag:_cards flagCard:cardHash[KINGTONG] flag:7];
    }
    /****寻找三带二******************************************************************/
    if ([cardHash[THREE] count] != 0) {
        int count = [cardHash[THREE] count];
        for (int i = 0; i < count; i++) {
            temp = [cardHash[THREE] objectAtIndex:([cardHash[THREE] count]-1)];
            if ([cardHash[COUPLE] count] != 0 ) {
                if ([[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0] cardNum] != 2+14) {
                    [temp addObject:[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:0]];
                    [temp addObject:[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:1]];
                    //                        [cardHash[CAPTURE] addObject:temp];
                    [self add_into_hash:CAPTURE _card:temp];
                    NSLog(@"count = %d",[[cardHash[CAPTURE] objectAtIndex:0] count]);
                    [temp removeAllObjects];
                    [cardHash[THREE] removeObjectAtIndex:([cardHash[THREE] count]-1)];
                    [cardHash[COUPLE] removeObjectAtIndex:0];
                }
            }
            [self setHashCardsFlag:_cards flagCard:cardHash[CAPTURE] flag:6];
            //            NSLog(@"flag = %d",[[[cardHash[CAPTURE] objectAtIndex:0] objectAtIndex:0] flag]);
            //            NSLog(@"count = %d",[cardHash[STRAIGHTFLUSH] count]);
            //            NSLog(@"count = %d",[cardHash[CAPTURE] count]);
            //            NSLog(@"count = %d",[[cardHash[CAPTURE] objectAtIndex:0] count]);
            //            NSLog(@"count = %d",[cardHash[THREE] count]);
            //            NSLog(@"count = %d",[cardHash[FLUSH] count]);
            //            NSLog(@"count = %d",[cardHash[MIXSEQ] count]);
            //            NSLog(@"count = %d",[cardHash[COUPLE] count]);
            //            //    NSLog(@"count = %d",[[cardHash[COUPLE] objectAtIndex:0] count]);
            //            
            //            NSLog(@"count = %d",[cardHash[SINGLE] count]);
        }
    }
    //    [temp release];
    //    [temp_card release];
    [self print_hash];
}

- (void) print_hash
{
    NSLog(@"count = %d",[cardHash[STRAIGHTFLUSH] count]);
    if ([cardHash[STRAIGHTFLUSH] count] != 0) {
        for (int i = 0; i < [[cardHash[STRAIGHTFLUSH]objectAtIndex:0] count]; i++) {
            NSLog(@"number = %d,type = %d",[[[cardHash[STRAIGHTFLUSH] objectAtIndex:0] objectAtIndex:i] cardNum],[[[cardHash[STRAIGHTFLUSH] objectAtIndex:0] objectAtIndex:i] suit]);
        }
    }
    
    NSLog(@"count = %d",[cardHash[KINGTONG] count]);
    if ([cardHash[KINGTONG] count] != 0) {
        for (int i = 0; i < [[cardHash[KINGTONG]objectAtIndex:0] count]; i++) {
            NSLog(@"number = %d,type = %d",[[[cardHash[KINGTONG] objectAtIndex:0] objectAtIndex:i] cardNum],[[[cardHash[KINGTONG] objectAtIndex:0] objectAtIndex:i] suit]);
        }
    }
    
    NSLog(@"count = %d",[cardHash[CAPTURE] count]);
    if ([cardHash[CAPTURE] count] != 0) {
        for (int i = 0; i < [[cardHash[CAPTURE]objectAtIndex:0] count]; i++) {
            NSLog(@"number = %d,type = %d",[[[cardHash[CAPTURE] objectAtIndex:0] objectAtIndex:i] cardNum],[[[cardHash[CAPTURE] objectAtIndex:0] objectAtIndex:i] suit]);
        }
    }
    
    NSLog(@"count = %d",[cardHash[THREE] count]);
    if ([cardHash[THREE] count] != 0) {
        for (int i = 0; i < [[cardHash[THREE]objectAtIndex:0] count]; i++) {
            NSLog(@"number = %d,type = %d",[[[cardHash[THREE] objectAtIndex:0] objectAtIndex:i] cardNum],[[[cardHash[THREE] objectAtIndex:0] objectAtIndex:i] suit]);
        }
    }
    
    NSLog(@"count = %d",[cardHash[FLUSH] count]);
    if ([cardHash[FLUSH] count] != 0) {
        for (int i = 0; i < [[cardHash[FLUSH]objectAtIndex:0] count]; i++) {
            NSLog(@"number = %d,type = %d",[[[cardHash[FLUSH] objectAtIndex:0] objectAtIndex:i] cardNum],[[[cardHash[FLUSH] objectAtIndex:0] objectAtIndex:i] suit]);
        }
    }
    
    NSLog(@"count = %d",[cardHash[MIXSEQ] count]);
    if ([cardHash[MIXSEQ] count] != 0) {
        for (int i = 0; i < [[cardHash[MIXSEQ]objectAtIndex:0] count]; i++) {
            NSLog(@"number = %d,type = %d",[[[cardHash[MIXSEQ] objectAtIndex:0] objectAtIndex:i] cardNum],[[[cardHash[MIXSEQ] objectAtIndex:0] objectAtIndex:i] suit]);
        }
    }
    
    NSLog(@"count = %d",[cardHash[COUPLE] count]);
    if ([cardHash[COUPLE] count] != 0) {
        for (int i = 0; i < [[cardHash[COUPLE]objectAtIndex:0] count]; i++) {
            NSLog(@"number = %d,type = %d",[[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:i] cardNum],[[[cardHash[COUPLE] objectAtIndex:0] objectAtIndex:i] suit]);
        }
    }
    
    NSLog(@"count = %d",[cardHash[SINGLE] count]);
    if ([cardHash[SINGLE] count] != 0) {
        for (int i = 0; i < [cardHash[SINGLE] count]; i++) {
            NSLog(@"number = %d,type = %d",[[cardHash[SINGLE] objectAtIndex:i] cardNum],[[cardHash[SINGLE] objectAtIndex:i] suit]);
        }
    }
    
}

//寻找同花
- (void) getFlush:(NSMutableArray *)_cards flag:(int)_flag
{
    
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    NSMutableArray * temp_card = [[NSMutableArray alloc] init];
    int count = [_cards count];
    for (int i = 0; (i < 4)&&(count >= 5); i++) {
        for (int j = 0; j < count; j++) {
            if ([[_cards objectAtIndex:j] flag] < _flag) {
                if ([[_cards objectAtIndex:j] suit] == i) {
                    //                    Card * _card = [[Card alloc] init];
                    Card * _card = [_cards objectAtIndex:j];
                    [temp addObject:_card];
                    NSLog(@"count = %d",[temp count]);
                    //                    [_card release];
                }
            }
        }
        //        NSLog(@"count = %d",[temp count]);
        
        if ([temp count] >= 5) {
            [CardType sortCards:temp];
            for (int k = 0; (k < [temp count])&&([temp count] - k) >= 5; ) {
                for (int j = k; j < k+5; j++) {
                    [temp_card addObject:[temp objectAtIndex:j]];
                }
                //                [cardHash[FLUSH] addObject:temp_card];
                [self add_into_hash:FLUSH _card:temp_card];
                [self setCardsFlag:_cards flagCard:temp_card flag:4];
                [temp_card removeAllObjects];
                k += 5;
                count -= 5;
            }
        }
        [temp removeAllObjects];
    }
    [temp release];
    [temp_card release];
}

//选择顺子
- (void) getMixSeq:(NSMutableArray *)_cards flag:(int)_flag
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    NSMutableArray * temp2 = [[NSMutableArray alloc]init];
    NSMutableArray * temp_card = [[NSMutableArray alloc] init];
    int count = [_cards count];
    for (int i =0; (i < count)&&(count >= 5); i++) {
        if ([[_cards objectAtIndex:i] flag] < _flag) {
            [temp addObject:[_cards objectAtIndex:i]];
        }
    }
    //    [CardType sortCards:temp];
    
    if ([temp count] >= 5) {
        [CardType sortCards:temp];
        [temp2 addObject:[temp objectAtIndex:0]];
        for (int i = 0;i < ([temp count]-1); i++) {
            if ([[temp objectAtIndex:i] cardNum] != [[temp objectAtIndex:i+1] cardNum]) {
                [temp2 addObject:[temp objectAtIndex:i+1]];
            }
        }
        
        for (int k = 0; (k < [temp2 count]) && ([temp2 count] - k) > 4; ) {
            for (int d = k; d < 5+k; d++) {
                [temp_card addObject:[temp2 objectAtIndex:d]];
            }
            
            if ([CardType getCardType:temp_card] == MIXSEQ) {
                //                [cardHash[MIXSEQ] addObject:temp_card];
                [self add_into_hash:MIXSEQ _card:temp_card];
                [self setCardsFlag:_cards flagCard:temp_card flag:3];
                [temp2 removeAllObjects];
                k += 5;
                count -= 5;
            }else{
                k += 1;
            }
            [temp_card removeAllObjects];
        }
    }
    [temp release];
    [temp2 release];
    [temp_card release];
}

//寻找对
- (void) getCouple:(NSMutableArray *)_cards flag:(int)_flag
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    NSMutableArray * temp_card = [[NSMutableArray alloc] init];
    int count = [_cards count];
    for (int i = 0; (i < count) && (count >= 2); i++) {
        if ([[_cards objectAtIndex:i] flag] < _flag) {
            [temp addObject:[_cards objectAtIndex:i]];
        }
    }
    /*************************************************/
    if ([temp count] >= 2) {
        [CardType sortCards:temp];
        for (int j = 0; j < [temp count] && [temp count] - j >= 2; ) {
            if ([[temp objectAtIndex:j] cardNum] != [[temp objectAtIndex:j+1] cardNum]) {
                j++;
            }else{
                for (int k = j; k < j+2; k++) {
                    [temp_card addObject:[temp objectAtIndex:k]];
                }
                //                [cardHash[COUPLE] addObject:temp_card];
                [self add_into_hash:COUPLE _card:temp_card];
                [self setCardsFlag:_cards flagCard:temp_card flag:2];
                j += 2;
                count -= 2;
                [temp_card removeAllObjects];
            }
        }
        [temp removeAllObjects];
    }
    [temp release];
    [temp_card release];
}

- (void) getSingle:(NSMutableArray *)_cards flag:(int)_flag
{
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    int count = [_cards count];
    for (int i = 0; (i < count) && (count >= 1); i++) {
        if ([[_cards objectAtIndex:i] flag] < _flag) {
            [temp addObject:[_cards objectAtIndex:i]];
        }
    }
    
    if ([temp count] >= 1) {
        [CardType sortCards:temp];
        
        for (int k = 0; k < [temp count]; k++) {
            //            [cardHash[SINGLE] addObject:[temp objectAtIndex:k]];
            [self add_into_hash_single:SINGLE _card:[temp objectAtIndex:k]];
            [self setCardsFlag:_cards flagCard:temp flag:1];
        }
    }
    [temp release];
}

@end
