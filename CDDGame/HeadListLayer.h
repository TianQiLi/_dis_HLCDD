//
//  HeadListLayer.h
//  head_test
//
//  Created by apple_3 on 12-8-27.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HeadListLayer : CCLayer <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
     UIView * viewHead;// 容器
    UIScrollView *scrollView;
    CCMenu * buttonMenu;
    NSArray * headImgArry;//存储列表图片
    UIButton * headBtn;
    UIButton * surebtn;
    int select_index;//保存被选图片的序号 用于验证
    NSString * select_img;//保存被选图片的名字
}
-(void)drawHead;
-(void)selectHead:(id)sender;
-(void)clickSureBtn:(id)sender;
@end
