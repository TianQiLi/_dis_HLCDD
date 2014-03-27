//
//  PlistLoad.h
//  CDDGame
//
//  Created by mac on 13-11-10.
//
//

#import <Foundation/Foundation.h>

@interface PlistLoad : NSObject
{
   

}
+(NSArray *)loadPlist:(NSString *)fileName;
+(NSString *)returnTypeName;
@end
