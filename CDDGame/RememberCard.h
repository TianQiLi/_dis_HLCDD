//
//  RememberCard.h
//  CDDGame
//
//  Created by new45 on 13-7-28.
//
//


#import <Foundation/Foundation.h>
//#import "Enumeration.h"
#import "cocos2d.h"

@interface RememberCard:NSObject
{
    int cardNum2;
    int suit2;
    Boolean  isSelect2;
    //    int nextElem;
    Boolean isHead;
}
@property int cardNum2;
@property int suit2;
@property Boolean isSelect2;
@property Boolean isHead2;
//-(void)drawcard:(RememberCard *)card,float xCard,float yCard;
 
@end

