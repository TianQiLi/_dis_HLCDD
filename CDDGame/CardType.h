//
//  CardType.h
//  CDDGame
//
//  Created by  on 12-8-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Card.h"

@interface CardType : CCNode {
    
}

+ (NSMutableArray *) sortCards:(NSMutableArray *)_cards;
+ (cardType) getCardType: (NSMutableArray*) selectedCard;
+ (Boolean) isEqual:(Card *)_card;
+ (Boolean) compareCards:(NSMutableArray*) selectedCards _tempCard:(NSMutableArray*) tempCards;

@end
