//
//  PositionGetter.m
//  CDDGame
//
//  Created by xc on 13-5-20.
//
//

#import "PositionGetter.h"
#import "PlistLoad.h"

@implementation PositionGetter
@synthesize dic;

-(id)initWithPlistName:(NSString *)name
{
    if(self = [super init])
    {
        NSString * str=[PlistLoad returnTypeName];
//        NSString * str=@"Type4";//test
//        NSString * str=@"Type5";//test
        if ([str isEqualToString:@"Type5"]) {
            typeDevice=[[NSString alloc ]initWithString:@"Type5"];
            name=[name stringByAppendingString:@"New"];
        }
        else
        {
              typeDevice=[[NSString alloc ]initWithString:@"Type4"];
        }
       //默认是type4
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
        dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
 
    
    }
    return self;
}

-(NSString *)getTypeD
{
    return typeDevice;

}
-(CGPoint)getElementPosition:(NSString *)dicName
{
    NSMutableDictionary *posiDic = [dic objectForKey:dicName];
    NSNumber * x = [posiDic objectForKey:@"x"];
    NSNumber * y = [posiDic objectForKey:@"y"];
  
    float  _x=[x floatValue];
    float _y=[y floatValue];
   
    return  CGPointMake(_x, _y);

    
}

-(float)getElementScale:(NSString *)dicName
{
    NSMutableDictionary *posiDic = [dic objectForKey:dicName];
    NSNumber * scale = [posiDic objectForKey:@"scale"];
    return scale.floatValue;
}

-(void)setElementPosition:(CCNode *)element
                  sign:(NSString *)name
{
    element.position = [self getElementPosition:name];
    element.scale =[self getElementScale:name];
 
}

-(void)setViewCenter:(UIView *)element
                     sign:(NSString *)name
{
    element.center = [self getElementPosition:name];
 
    
}

-(CGRect)setFramePosition:(CGRect )name
{
    NSLog(@"ss=%@",typeDevice);
    if ([typeDevice isEqualToString:@"Type5"]) {
        name.origin.x=name.origin.x+40;
    }
    return name;
    
}
-(void)dealloc
{
    [super dealloc];
}


@end
