//
//  PositionGetter.h
//  CDDGame
//
//  Created by xc on 13-5-20.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PositionGetter : NSObject
{
    NSMutableDictionary * dic;
    NSString * typeDevice;

}
@property (retain,nonatomic) NSMutableDictionary* dic;
-(id)initWithPlistName:(NSString *)name;

-(void)setElementPosition:(CCNode *)element
                     sign:(NSString *)name;

-(void)setViewCenter:(UIView *)element
                  sign:(NSString *)name;
-(NSString *)getTypeD;

-(void)dealloc;
@end
