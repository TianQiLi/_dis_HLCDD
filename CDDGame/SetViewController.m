//
//  SetViewController.m
//  CDDGame
//
//  Created by  on 12-8-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SetViewController.h"
#import "GameMainViewContorller.h"
#import "CJSONDeserializer.h"
#import <AVFoundation/AVFoundation.h>

@implementation SetViewController

@synthesize userNameText;


+(CCScene *) scene
{
    CCScene * scene = [CCScene node];
    SetViewController * layer = [SetViewController node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    self = [super init];
    if (self) {
        //允许触碰
        self.isTouchEnabled = YES;
        
        //设置背景图片
        CCSprite * backGroud = [CCSprite spriteWithFile:@"settingbackground111.png"];
        backGroud.anchorPoint = CGPointZero;
        [self addChild:backGroud];
        
        //读取数据库的值
        database = [[CD2Database alloc]init];
        [database openDatabase];
        [database createTable];
        userName = [[NSString alloc]initWithFormat:@"tk"];
        [database selectLastName];
//        NSLog(@"名字1：'%@'",userName);
        userName = database.userName1;
        NSLog(@"名字2：'%@'",userName);
        volumeValue = database.volume;
        soundEffectValue = database.soundEffect;
        headPortaitValue = database.headPortrait;
        NSLog(@"头像：‘%d’",headPortaitValue);
        backGroundValue = database.backGroundMusic;
        square3Value = database.square3Select;
        pointAndTurnsValue = database.pointOrTurns;
        maxSwitchValue = database.selectMaxSwitch;
        NSLog(@"输出为：%d",backGroundValue);
//        [database closeDatabase];
//        [database release];
        
        //添加确定按钮
        CCSprite * sureButton_off = [CCSprite spriteWithFile:@"sureButton.png"];
        CCSprite * sureButton_on  = [CCSprite spriteWithFile:@"btnsurebutton.png"];
        CCMenuItemImage * sureButton = [CCMenuItemImage itemFromNormalSprite:sureButton_off selectedSprite:sureButton_on target:self selector:@selector(clickSureButton)];
        CCMenu * sureButton1 = [CCMenu menuWithItems:sureButton, nil];
        sureButton1.scale = .6f;
        sureButton1.position = CGPointMake(350.0f, -45.0f);
        [self addChild:sureButton1];
        
        //添加取消设置按钮
        CCSprite * repeatButton_off = [CCSprite spriteWithFile:@"cancle.png"];
        CCSprite * repeatButton_on  = [CCSprite spriteWithFile:@"btncancle.png"];
        CCMenuItemImage * repeatButton = [CCMenuItemImage itemFromNormalSprite:repeatButton_off selectedSprite:repeatButton_on target:self selector:@selector(clickrepeatButton)];
        CCMenu * repeatButton1 = [CCMenu menuWithItems:repeatButton, nil];
        repeatButton1.scale = .6f;
        repeatButton1.position = CGPointMake(-60.0f, -45.0f);
        [self addChild:repeatButton1];
        
        //用户编辑框
        userNameText = [[UITextField alloc]init];
//        CGAffineTransform rotation = CGAffineTransformMakeRotation(1.57079633);
//        [userNameText setTransform:rotation];
        [userNameText setFrame:CGRectMake(200.0f,88.0f, 136.0f, 26.0f)];
//        [userNameText setContentHorizontalAlignment:UIControlContentVerticalAlignmentTop];
//        [userNameText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [userNameText addTarget:self action:@selector(removeFieldAction) forControlEvents:UIControlEventEditingDidEndOnExit];
        [userNameText addTarget:self action:@selector(textFieldAction) forControlEvents:UIControlEventTouchDown];
        userNameText.backgroundColor = [UIColor whiteColor];
        userNameText.textColor       = [UIColor blackColor];
        userNameText.placeholder     =@"输入新名字";
        NSLog(@"名字：'%@'",userName);
        if (userName!=nil) {
            userNameText.text = userName;
        }
//        self.userNameText.text = userName;
//        userNameText.text = userName;

        userNameText = [userNameText autorelease];
        [[[CCDirector sharedDirector]openGLView]addSubview:userNameText];
//        userNameText.text = userName;
//        [userNameText setText:[NSString stringWithFormat:@"%@",userName]];
//        [userNameText resignFirstResponder];
//        userNameText.text = [database selectLastName];
        
        //添加下拉按钮
        CCSprite* setdownbtn_off = [CCSprite spriteWithFile:@"btnsetdown.png"]; 
        CCSprite* setdownbtn_on  = [CCSprite spriteWithFile:@"btnsetdown.png"];
        CCMenuItemImage* setdownbtnImg = [CCMenuItemImage itemFromNormalSprite:setdownbtn_off selectedSprite:setdownbtn_on target:self selector:@selector(clickSetdown)];
        setdownbtnImg.scale = .5f;
//        //添加设置头像按钮
//        CCSprite * setPhoto_off = [CCSprite spriteWithFile:@"setphoto.png"];
//        CCSprite * setPhoto_on  = [CCSprite spriteWithFile:@"setphoto.png"];
//        CCMenuItemImage *setPhoto = [CCMenuItemImage itemFromNormalSprite:setPhoto_off selectedSprite:setPhoto_on target:self selector:@selector(clickSetPhoto)];
//        setPhoto.scale = 1.0f;
        //添加删除按钮
        CCSprite * deleteName_off = [CCSprite spriteWithFile:@"bt_delete111.png"];
        CCSprite * deleteName_on  = [CCSprite spriteWithFile:@"bt_delete.png"];
        CCMenuItemImage * deleteName = [CCMenuItemImage itemFromNormalSprite:deleteName_off selectedSprite:deleteName_on target:self selector:@selector(clickDeleteName)];
        deleteName.scale = .7f;
        CCMenu* setdownbtn = [CCMenu menuWithItems:setdownbtnImg,deleteName, nil];
        [setdownbtn alignItemsHorizontallyWithPadding:10];
        setdownbtn.position = CGPointMake(375.0f, 218.0f);
        [self addChild:setdownbtn];
              
//        NSArray *segmentedArray =[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
//        //初始化
//        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
//        segmentedControl.frame = CGRectMake(100, 100, 100, 100);
//        segmentedControl.selectedSegmentIndex = 2;
//        segmentedControl.tintColor = [UIColor whiteColor];
//        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;//设置风格
//        segmentedControl.momentary = NO;//设置在点击后是否恢复原样
////        [self addChild:segmentedControl];
        
        //定义分数、局数选择
        segmentedArray =[[NSArray alloc]initWithObjects:@"分数",@"局数",nil];
        segmentedControl=[[UISegmentedControl alloc] initWithItems:segmentedArray];
//        CGAffineTransform rotation2 = CGAffineTransformMakeRotation(1.57079633);
//        [segmentedControl setTransform:rotation2];
        segmentedControl.frame = CGRectMake(200, 120, 180, 40);
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.momentary = NO;
//        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self action:@selector(clickSetGameTurns:) forControlEvents:UIControlEventValueChanged];
        [segmentedControl autorelease];
        [[[CCDirector sharedDirector]openGLView]addSubview:segmentedControl];
        
        //定义分数
        segmentedArray2 = [[NSArray alloc]initWithObjects:@"100",@"200",@"500", nil];
        segmentedControl2 = [[UISegmentedControl alloc]initWithItems:segmentedArray2];
//        CGAffineTransform rotation3 = CGAffineTransformMakeRotation(1.57079633);
//        [segmentedControl2 setTransform:rotation3];
        segmentedControl2.frame = CGRectMake(200, 160, 180, 40);
        segmentedControl2.momentary = NO;
        segmentedControl2.hidden = NO;
        [segmentedControl2 addTarget:self action:@selector(clickPointValue:) forControlEvents:UIControlEventValueChanged];
        [segmentedControl2 autorelease];
        [segmentedArray2 autorelease];
        [[[CCDirector sharedDirector]openGLView]addSubview:segmentedControl2];

        //定义局数
        segmentedArray3 = [[NSArray alloc]initWithObjects:@"10",@"20",@"50", nil];
        segmentedControl3 = [[UISegmentedControl alloc]initWithItems:segmentedArray3];
//        CGAffineTransform rotation4 = CGAffineTransformMakeRotation(1.57079633);
//        [segmentedControl3 setTransform:rotation4];
        segmentedControl3.frame = CGRectMake(200, 160, 180, 40);
        segmentedControl3.momentary = NO;
        segmentedControl3.hidden = YES;
        [segmentedControl3 addTarget:self action:@selector(clickTurnsValue:) forControlEvents:UIControlEventValueChanged];
        [segmentedControl3 autorelease];
        [[[CCDirector sharedDirector]openGLView]addSubview:segmentedControl3];
        
        //读取上次的规则设置
        switch (pointAndTurnsValue) {
            case 11:
                segmentedControl.selectedSegmentIndex  = 0;
                segmentedControl2.selectedSegmentIndex = 0;
                break;
            
            case 12:
                segmentedControl.selectedSegmentIndex  = 0;
                segmentedControl2.selectedSegmentIndex = 1;
                break;
                
            case 13:
                segmentedControl.selectedSegmentIndex  = 0;
                segmentedControl2.selectedSegmentIndex = 2;
                break;
                
            case 21:
                segmentedControl.selectedSegmentIndex  = 1;
                segmentedControl3.selectedSegmentIndex = 0;
                break;
                
            case 22:
                segmentedControl.selectedSegmentIndex  = 1;
                segmentedControl3.selectedSegmentIndex = 1;
                break;
                
            case 23:
                segmentedControl.selectedSegmentIndex  = 1;
                segmentedControl3.selectedSegmentIndex = 2;
                break;
                
            default:
                break;
        }
        
        //添加方块3先出按钮
        square3ButtonNo_off = [CCSprite spriteWithFile:@"clickCancel111.png"];
        CCMenuItemImage * square3Button1 = [CCMenuItemImage itemFromNormalSprite:square3ButtonNo_off selectedSprite:nil target:self selector:@selector(clickSquare3ButtonYes)];
        square3ButtonMenuNo = [CCMenu menuWithItems:square3Button1, nil];
        square3ButtonMenuNo.scale = 1;
//        square3ButtonMenuNo.visible = YES;
        square3ButtonMenuNo.position = CGPointMake(370, 100);
        [self addChild:square3ButtonMenuNo];
        square3ButtonYes_off = [CCSprite spriteWithFile:@"clicksure111.png"];
        CCMenuItemImage * sqare3Button2 = [CCMenuItemImage itemFromNormalSprite:square3ButtonYes_off selectedSprite:nil target:self selector:@selector(clickSquare3ButtonNo)];
        square3ButtonMenuYes = [CCMenu menuWithItems:sqare3Button2, nil];
        square3ButtonMenuYes.scale = 1;
//        square3ButtonMenuYes.visible = NO;
        square3ButtonMenuYes.position = CGPointMake(370, 100);
        [self addChild:square3ButtonMenuYes];
        
        //读取上次方块3值
        switch (square3Value) {
            case 0:
                square3ButtonMenuNo.visible  = YES;
                square3ButtonMenuYes.visible = NO;
                break;
                
            case 1:
                square3ButtonMenuNo.visible  = NO;
                square3ButtonMenuYes.visible = YES;
                break;
                
            default:
                break;
        }
        
        //添加是否顶大
        maxSwitchNo = [CCSprite spriteWithFile:@"clickCancel111.png"];
        CCMenuItemImage * maxSwitch2 = [CCMenuItemImage itemFromNormalSprite:maxSwitchNo selectedSprite:nil target:self selector:@selector(clickmaxSwitchYes)];
        maxSwitchMenuNo= [CCMenu menuWithItems:maxSwitch2, nil];
//        maxSwitchMenuNo.scale = .6;
//        maxSwitchMenuNo.visible = YES;
        maxSwitchMenuNo.position = CGPointMake(370, 70);
        [self addChild:maxSwitchMenuNo];
        maxSwitchMenuYes = [CCSprite spriteWithFile:@"clicksure111.png"];
        CCMenuItemImage * maxSwitch1 = [CCMenuItemImage itemFromNormalSprite:maxSwitchMenuYes selectedSprite:nil target:self selector:@selector(clickmaxSwitchNo)];
        maxSwitchMenuYes = [CCMenu menuWithItems:maxSwitch1, nil];
//        maxSwitchMenuYes.scale = .6;
//        maxSwitchMenuYes.visible = NO;
        maxSwitchMenuYes.position = CGPointMake(370, 70);
        [self addChild:maxSwitchMenuYes];
        
        //读取上次玩家是否顶大值
        switch (maxSwitchValue) {
            case 0:
                maxSwitchMenuNo.visible  = YES;
                maxSwitchMenuYes.visible = NO;
                break;
                
            case 1:
                maxSwitchMenuNo.visible  = NO;
                maxSwitchMenuYes.visible = YES;
                break;
                
            default:
                break;
        }
        
//        //添加方块3先出
//        square3Buttonswitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        [square3Buttonswitch setTransform:rotation];
////        square3Buttonswitch.frame = CGRectMake(100, 100, 10, 80);
//        [square3Buttonswitch autorelease];
//        [[[[CCDirector sharedDirector]openGLView]window]addSubview:square3Buttonswitch];
        
        //初始化名字下拉菜单
//        nameList = [[NSArray alloc]initWithObjects:@"tanke1",@"tanke2",@"tanke3",@"tanke4",@"tanke5",@"tanke6",@"tanke7",@"tanke8",@"tanke9", nil];
//        nameList1 = [[NSMutableArray alloc]initWithArray:[database getAllUserName]];
//        int count = nameList1.count;
//        NSLog(@"name : %d",count);
//        nameTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
////        [nameTable setTransform:rotation];
//        [nameTable setFrame:CGRectMake(50, 50, 380, 234)];
//        nameTable.delegate = (id)self;
//        nameTable.dataSource = (id)self;
//        [nameTable setHidden:YES];
//        [nameTable autorelease];
//        [[[CCDirector sharedDirector]openGLView]addSubview:nameTable];

        [database closeDatabase];
        [database release];

    }
    
    
    return self;
}

//放回可选项的数目
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameList1.count;
}

//设置没项的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

//初始化下拉列表
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"nameTable";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[cellid autorelease]];
    }
    cell.textLabel.text = (NSString *)[nameList1 objectAtIndex:indexPath.row];
    cell.textLabel.font = userNameText.font;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

//选中下拉表并设置用户的名字
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    userNameText.text = (NSString *)[nameList1 objectAtIndex:indexPath.row];
//    index = indexPath.row;
//    NSLog(@"%d",index);
    [nameTable setHidden:YES];
}

-(void)clickSureButton
{
    if (userNameText.text == nil || [userNameText.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
//        NSIndexSet * test = [[NSIndexSet alloc]initWithIndex:5];
//        [nameTable deleteSections:test withRowAnimation:UITableViewRowAnimationTop];
    }else{
        //打开数据库
        database = [[CD2Database alloc]init];
        [database openDatabase];
        [database createTable];
        //插入或更新数据
        [database addNewUserOrUpdateUserSetting:userNameText.text withPointOrTurns:pointAndTurnsValue andSquare3:square3Value andMaxSwitch:maxSwitchValue andBackGroundMusic:backGroundValue andHeadPortrait:headPortaitValue];
        [database useThisName:userNameText.text];
        NSString *name = userNameText.text;
        NSLog(@"当前名字：%@",name);
        
//        //插入或更新数据
//        [database addNewUserOrUpdateUserSetting:userNameText.text withPointOrTurns:11 andSquare3:0 andMaxSwitch:0 andBackGroundMusic:0 andHeadPortrait:0];
        NSLog(@"volume='%f',soundeffect='%f',headportrait='%d',background='%d',pointandturns='%d',square3='%d',maxSwitch='%d'",volumeValue,soundEffectValue,headPortaitValue,backGroundValue,pointAndTurnsValue,square3Value,maxSwitchValue);
        
        [nameTable setHidden:YES];

        //关闭数据库
        [database closeDatabase];
        [database release];
        [userNameText removeFromSuperview];
        [segmentedControl removeFromSuperview];
        [segmentedControl2 removeFromSuperview];
        [segmentedControl3 removeFromSuperview];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.3f scene:[GameMainViewContorller scene]]];
    }
}

-(void)clickrepeatButton
{
    [nameTable setHidden:YES];
    [userNameText removeFromSuperview];
    [segmentedControl removeFromSuperview];
    [segmentedControl2 removeFromSuperview];
    [segmentedControl3 removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.3f scene:[GameMainViewContorller scene]]];
}

-(void)clickSetdown
{
//    [nameTable setHidden:NO];
    database = [[CD2Database alloc]init];
    [database openDatabase];
    [database createTable];
    nameList1 = [[NSMutableArray alloc]initWithArray:[database getAllUserName]];
    int count = nameList1.count;
    NSLog(@"name : %d",count);
    nameTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
    //        [nameTable setTransform:rotation];
    [nameTable setFrame:CGRectMake(80, 82, 335, 174)];
    nameTable.delegate = (id)self;
    nameTable.dataSource = (id)self;
    [nameTable setHidden:NO];
    [nameTable autorelease];
    [[[CCDirector sharedDirector]openGLView]addSubview:nameTable];
    
    [database closeDatabase];
    [database release];
    
//
//    NSMutableArray * userAllName = [[NSMutableArray alloc]initWithArray:[database getAllUserName]];
//    
//    if ([userAllName count] != 0 ) {
//        NSLog(@"getName is ok.");
//        UIActionSheet * allNameList = [[UIActionSheet alloc]initWithTitle:@"用户名列表" 
//                                                                 delegate:self 
//                                                        cancelButtonTitle:nil
//                                                   destructiveButtonTitle:nil 
//                                                        otherButtonTitles:nil];        
//        for (int i = 0; i < [userAllName count]; i++) {
//            NSString * name = [userAllName objectAtIndex:i];
//            [allNameList addButtonWithTitle:name];
//        }
//        
//        UIButton * button = (UIButton *)self;
//        [allNameList showFromRect:button inView:self.view animated:YES];
//        [allNameList release];
//        
//    }else{
//        NSLog(@"getName failed.");
//    }
//    
//    [userAllName release];
//    [database closeDatabase];
//    [database release];
}

//- (IBAction)buttonPressed:(id)sender 
//{
//
//    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"所有用户名" 
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:@"确定"
//                                                    otherButtonTitles:nil];
//    CGAffineTransform rotation4 = CGAffineTransformMakeRotation(1.57079633);
//    [actionSheet setTransform:rotation4];
//    actionSheet.frame = CGRectMake(100, 100, 100, 100);
//
//    [[[[CCDirector sharedDirector]openGLView]window]addSubview:actionSheet];
//
//}

//- (void) actionSheet:(UIActionSheet *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
////    if (buttonIndex < 0) {
////        NSLog(@"actionSheet failed.");
////    }
////    database = [[CD2Database alloc]init];
////    [database openDatabase];
////    [database createTable];
////    
////    NSMutableArray * userAllName = [database getAllUserName];
////    NSString * selectName = [userAllName objectAtIndex:buttonIndex];
////    userNameText.text = selectName;
////    
////    
//////    [userAllName release];
////    [database closeDatabase];
////    [database release];
//

-(void)textFieldAction
{
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.3f scene:[SetViewController scene]]];
    userNameText.text = nil;
}

- (void)removeFieldAction
{
    
}
-(void)touchTextFieldAction
{
    
}

-(void)clickDeleteName
{
    if (userNameText.text != nil) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定删除该用户" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        database = [[CD2Database alloc]init];
        [database openDatabase];
        [database createTable];
        [database deletUser:userNameText.text];
//        NSIndexSet * temp = [[NSIndexSet alloc]initWithIndex:index];
//        [nameTable deleteSections:temp withRowAnimation:UITableViewRowAnimationTop];
        userNameText.text = nil;
        [database closeDatabase];
    }
}

-(void)clickSetPhoto
{
    
}

-(void)clickSetBackgroundMusic
{
    
}

-(void)clickSquare3ButtonYes
{
    square3ButtonMenuYes.visible = YES;
    square3ButtonMenuNo.visible  = NO;
    square3Value = 1;
}

-(void)clickSquare3ButtonNo
{
    square3ButtonMenuYes.visible = NO;
    square3ButtonMenuNo.visible  = YES;
    square3Value = 0;
}

-(void)clickmaxSwitchYes
{
    maxSwitchMenuYes.visible = YES;
    maxSwitchMenuNo.visible  = NO;
    maxSwitchValue = 1;
}

-(void)clickmaxSwitchNo
{
    maxSwitchMenuYes.visible = NO;
    maxSwitchMenuNo.visible  = YES;
    maxSwitchValue = 0;
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

-(void)clickSetGameTurns:(UISegmentedControl *) Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %i",Index);
    switch (Index) {
        case 0:
            segmentedControl3.hidden = YES;
            segmentedControl2.hidden = NO;
            break;
            
        case 1:
            segmentedControl3.hidden = NO;
            segmentedControl2.hidden = YES;
            break;
            
        default:
            break;
    }
}

-(void)clickPointValue:(UISegmentedControl *) Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %i",Index);
    switch (Index) {
        case 0:
            pointAndTurnsValue = 11;
            break;
        
        case 1:
            pointAndTurnsValue = 12;
            break;
            
        case 2:
            pointAndTurnsValue = 13;
            break;
        
        default:
            break;
    }

}

- (void) clickTurnsValue:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %i",Index);
    switch (Index) {
        case 0:
            pointAndTurnsValue = 21;
            break;
            
        case 1:
            pointAndTurnsValue = 22;
            break;
            
        case 2:
            pointAndTurnsValue = 23;
            break;
            
        default:
            break;
    }
}

@end
