//
//  protocal.h
//  CDDGame
//
//  Created by mac on 13-11-8.
//
//

#ifndef CDDGame_protocal_h
#define CDDGame_protocal_h

@protocol RectSwitchDelegate <NSObject>

@optional
-(NSString *)detectDevice;
@required
-(CGRect)switchRect:(CGRect)rect;
-(CGPoint)switchCGPoint:(CGPoint)point;
@end

#endif
