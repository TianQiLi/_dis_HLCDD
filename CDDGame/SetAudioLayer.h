//
//  SetAudio.h
//  Audio_music_test
//
//  Created by apple_3 on 12-8-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//<CCLabelProtocol,CCRGBAProtocol>

@interface SetAudioLayer : CCLayer<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView * view;//作为容器
//    CCLayer * layerItem;
    NSArray * arrayMusicList;//存放音乐列表歌曲名
    CCMenu * musicList;
    NSString * musicName_selected;//存放所选这的歌曲名
    int tag;//保存列表项被选序号
    UILabel * labelMusic;//显示所选歌曲名
    UIButton * dropBtn;//下拉按钮
    UISlider* musicVolumn;
    UISlider* effectVolumn; 
}
@property (retain)UIView * view;
@property (retain)NSArray* arrayMusicList;
@property (retain)NSString*  musicName_selected;
@property (retain) UISlider*    musicVolumn;
@property (retain) UISlider*    effectVolumn;
-(void)drawAudioItem;
-(void)drawMusicList;
-(void)clickDrop:(id)sender;
-(void) changeMusicVol:(id)sender;
-(void) changeEffectVol:(id)sender;
-(void)clickSure_music:(id)sender;
-(void)clickReset_music:(id)sender;
 
@end
