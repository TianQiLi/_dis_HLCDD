//
//  CardType.m
//  CDDGame
//
//  Created by  on 12-8-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CardType.h"
#import "Card.h"

@implementation CardType

+ (void) sortCards:(NSMutableArray *)cards//排序
{
    //排序
    int i,j,k;

    for (i = 0; i <[cards count]; i++) {
        for (k = j = i; j < [cards count]; j++) {
            if ([[cards objectAtIndex:j] compareLess:[cards objectAtIndex:k]]) {
                k = j;
            }
        }
        if (k != i) {
            [cards exchangeObjectAtIndex:i withObjectAtIndex:k];
        }
    }

}

+ (cardType) getCardType: (NSMutableArray*) selectedCard//判断所有牌的类型
{
    int count = [selectedCard count];
    cardType type;
    if(count == 1){
        type = SINGLE; 
    }else if(count == 2){
        Card *one = [selectedCard objectAtIndex:0];
        Card *two = [selectedCard objectAtIndex:1];
        if(one.cardNum == two.cardNum){
            type = COUPLE; 
        }else{
            type = INVALID; 
        }
    }else if(count == 3){
        if([[selectedCard objectAtIndex:0] cardNum] == [[selectedCard objectAtIndex:1] cardNum]
           && [[selectedCard objectAtIndex:1] cardNum] == [[selectedCard objectAtIndex:2] cardNum]){
            type = THREE; 
        }else{
            type = INVALID; 
        }
    }else if(count == 5){
        Boolean seq, flush; 
        seq = false; 
        flush = false; 
                
        [self sortCards:selectedCard];
        
        int i; 
        int tmpArray[] = {1, 10, 11, 12, 13};
//        for(i = 0; i < count; i++){
//            if([[selectedCard objectAtIndex:i] cardNumber] != tmpArray[i]) break; 
//        }
//        if(i == count){
//            seq = YES; 
//        }
        for(i = 0; i < count-1; i++){
            tmpArray[i] = [[selectedCard objectAtIndex:i+1] cardNum] - 
            [[selectedCard objectAtIndex:i] cardNum]; 
        }
        if(tmpArray[0] == 1 && tmpArray[1] == 1 && tmpArray[2] == 1 && tmpArray[3] == 1){
            seq = YES; 
        }
        for(i = 1; i < count; i++){
            if([[selectedCard objectAtIndex:i] suit] != [[selectedCard objectAtIndex:0] suit]){
                break; 
            }
        }
        if(i == count){
            flush = true; 
        }
        if(seq && flush){
            type = STRAIGHTFLUSH; 
        }else if(seq){
            type = MIXSEQ; 
        }else if(flush){
            type = FLUSH; 
        }else{
            int s = 0; 
            for(i = 0; i < count-1; i++){
                if(tmpArray[i] == 0){
                    s++; 
                }
            }
            if(s == 3){
                if(tmpArray[0] == 0 && tmpArray[3] == 0){
                    type = CAPTURE; 
                }else{
                    type = KINGTONG; 
                }
            }else{
                type = INVALID; 
            }
        }
        
    }else{
        type = INVALID; 
    }
    return type; 
}

+ (Boolean) isEqual:(Card *)_card
{
    if ((_card.cardNum == 3)&&(_card.suit == 1)) {
        return YES;
    }else{
        return NO;
    }
}

//判断selectedCards是否能大过tempCards,大过则返回YES
+ (Boolean) compareCards:(NSMutableArray*) selectedCards _tempCard:(NSMutableArray*) tempCards
{
    cardType _selectedcards = [self getCardType:selectedCards];
    cardType _tempcards = [self getCardType:tempCards];
    if (_selectedcards != INVALID && _selectedcards >= _tempcards) {
        switch (_tempcards) {
            case STRAIGHTFLUSH:
                if ([[tempCards objectAtIndex:4] compareLess:[selectedCards objectAtIndex:4]]) {
                    return YES;
                }else{
                    return NO;
                }
                
            case KINGTONG:
                if (_selectedcards > _tempcards) {
                    return YES;
                }else{
                    if ([[tempCards objectAtIndex:2] compareLess:[selectedCards objectAtIndex:2]]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
            case CAPTURE:
                if (_selectedcards > _tempcards) {
                    return YES;
                }else{
                    if ([[tempCards objectAtIndex:2] compareLess:[selectedCards objectAtIndex:2]]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
            case FLUSH:
                if (_selectedcards > _tempcards) {
                    return YES;
                }else{
                    if ([[tempCards objectAtIndex:4] compareLess:[selectedCards objectAtIndex:4]]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
            case MIXSEQ:
                if (_selectedcards > _tempcards) {
                    return YES;
                }else{
                    if ([[tempCards objectAtIndex:4] compareLess:[selectedCards objectAtIndex:4]]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
            case THREE:
                if (_selectedcards == _tempcards) {
                    if ([[tempCards objectAtIndex:0] compareLess:[selectedCards objectAtIndex:0]]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return NO;
                }
                
            case COUPLE:
                if (_selectedcards == _tempcards) {
                    if ([[tempCards objectAtIndex:1] compareLess:[selectedCards objectAtIndex:1]]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return NO;
                }
                
            case SINGLE:
                if (_selectedcards == _tempcards) {
                    if ([[tempCards objectAtIndex:0] compareLess:[selectedCards objectAtIndex:0]]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return NO;
                }
                
            default:
                return NO;
        }
    }else{
        return NO;
    }
}
//- (void) dealloc
//{
//    [super dealloc];
//}

@end
