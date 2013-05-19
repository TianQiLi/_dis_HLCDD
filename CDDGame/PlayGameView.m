//
//  PlayGameView.m
//  CDDGame
//
//  Created by  on 12-8-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayGameView.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "GameMainViewContorller.h"
#import "CD2Database.h"
#import "SimpleAudioEngine.h"
#import "CardType.h"
#import "RankingList.h"
#import "YouMiView.h"

@implementation PlayGameView

@synthesize playersList;
@synthesize cardsList;
@synthesize backCards1;
@synthesize backCards2;
@synthesize backCards3;
@synthesize gestureRecognizer1;
@synthesize gestureRecognizer2;
@synthesize gestureRecognizer3;
@synthesize gestureRecognizer4;
@synthesize showCards;

+(CCScene *)scene
{
    CCScene * scene=[CCScene node];
    PlayGameView *  layer=[PlayGameView node];
    
    UISwipeGestureRecognizer * gestureRecognizer;
    gestureRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:layer action:@selector(handleSwipeFrom:)];
    gestureRecognizer.direction=UISwipeGestureRecognizerDirectionUp;
    
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    gestureRecognizer.delegate=delegate.viewController;
    [delegate.viewController.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
    gestureRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:layer action:@selector(handleSwipeFrom:)];
    gestureRecognizer.direction=UISwipeGestureRecognizerDirectionDown;
    [delegate.viewController.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
    gestureRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:layer action:@selector(handleSwipeFrom:)];
    gestureRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;
    [delegate.viewController.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
    gestureRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:layer action:@selector(handleSwipeFrom:)];
    gestureRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    [delegate.viewController.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
    // add layer as a child to scene   
    [scene  addChild:layer]; 
    return  scene;
}

-(id)init
{
    
    if(self =[super  init])
    {
        
//        //添加广告
//        [YouMiView setShouldCacheImage:NO];
//        YouMiView *adView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:nil];
//        adView.appID = @"62630359b71510c5";
//        adView.appSecret = @"93631ff3218c4908";
//        adView.appVersion = @"1.0";
//        [adView start];
//        [[[CCDirector sharedDirector] openGLView] addSubview: adView];
        
       //记录分数
        dataBase = [[CD2Database alloc]init];
        [dataBase openDatabase];
        [dataBase createTable];
        [dataBase selectLastName];
        score = dataBase.score;
        userName = dataBase.userName1;
        NSLog(@"the score is  %ld",score);
        [dataBase updateUserEndScore:dataBase.userName1 withScore:score-100];
        [dataBase selectLastName];
        NSLog(@"the score2 is %ld",dataBase.score);
        square3Select = dataBase.square3Select;
        selectMaxSwitch = dataBase.selectMaxSwitch;
        pointOrTurns = dataBase.pointOrTurns;
        [dataBase closeDatabase];
        [dataBase release];
        
        //允许触碰
        self.isTouchEnabled=YES;  
        //设置排序标志为no
        change=NO;
        //初始时gameState为Update
        gameState = Update;
        //初始化手势方向
        gestureDir=-1;
        //标记音乐层是否已添加
        added=NO;
        //标记积分表层是否已经添加,初始化为no
        added_rank=NO;
        //设置背景
        CCSprite *backGroud = [CCSprite spriteWithFile:@"gamebackground.png"];
        backGroud.anchorPoint = CGPointMake(0, 0);
        [self addChild:backGroud  z:0  tag:1];
        
        //显示总金币数
        CCSprite * goldNumber = [CCSprite spriteWithFile:@"金币数.png"];
        goldNumber.position = CGPointMake(380, 300);
        goldNumber.scale = .6;
        [self addChild:goldNumber];
        
       //初始化暂停按钮
        [self drawPause]; 
        
        //绘制弹出菜单项默认隐藏
        [self drawMenu];
        
        //初始化52张牌
        [self initCardsList];
        
        //初始化playerList，并且显示分数和牌数
        [self initPlayersList];
        //初始化头像按钮
        [self drawHeadBtn];
        //初始化每个comptuerplayer背面牌
        [self initBackCardsList];
        
        //随机分牌
        [self distributeCards];
        //确定分牌后的接管权
        [self playerTakeTurn];
 
//        //游戏结束得分
//        [self drawScore];
//        [self clickRank];
        //绘制玩家pass label
        [self drawPassLabel];
        // 设定时间回调函数,修改游戏用时显示
//        [self scoreShow]; 

        if (score == 0) {
            guideIndex = [CCSprite spriteWithFile:@"提示箭头.png"];
            guideIndex.anchorPoint = CGPointZero;
            guideIndex.visible = YES;
            [self addChild:guideIndex z:0];
//            [self schedule:@selector(countTime:) interval:0.8f];
        }
        [self schedule:@selector(step:) interval:0.9f];
    }
    return  self;
}


-(void)countTime:(ccTime)dt
{
    //记录时间
//        NSString *timestring = [NSString stringWithFormat:@"游戏时间: %d", (int)time];
//        [self removeChild:labletime cleanup:YES];
//       labletime = [CCLabelTTF labelWithString:timestring fontName:@"Marker Felt" fontSize:11];
//        labletime.anchorPoint = CGPointZero;
//        labletime.color = ccWHITE;
//        labletime.position    = CGPointMake(410.0f,290.0f);
//        labletime.visible=NO;
//        [self addChild:labletime z:1];
    [self removeChild:guideIndex cleanup:YES];
    guideIndex = [CCSprite spriteWithFile:@"提示箭头.png"];
    guideIndex.anchorPoint = CGPointZero;
    guideIndex.visible = YES;
    [self addChild:guideIndex z:0];
    if((int)time%8==0||time ==0)
    {
        guideIndex.visible = NO;
    } 
    time += dt;

}

-(void)step:(ccTime)delayTime
{
    switch(gameState)
    {
        case Update:
        {
            [self gameUpdate];
        }break;
        case Menu:
        {
            //[self drawMenu];
        }break;
        case Pause:break;
        case Continue:break;
        case Escape:break;
        case Notice:break;
        case End:
        {
            [self gameEnd];
        }
            break;
        default:break;
    }
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if(gameState==Update)
    {
        if (recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
            //上 出牌
            gestureDir=UP;
            [self clickShow:showMenu];
            NSLog(@"方向为up：%d",gestureDir);
            
        }
        else if(recognizer.direction==UISwipeGestureRecognizerDirectionDown)
        {
            //下 重选牌
            gestureDir=DOWN;
            [self clickReset:resetMenu];
            NSLog(@"方向为down：%d",gestureDir);
            
        }
        else if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
        {
            //左  排序
            gestureDir=LEFT;
            [self sortCard];
            NSLog(@"方向为left：%d",gestureDir);
            
        }
        else if(recognizer.direction==UISwipeGestureRecognizerDirectionRight)
        {
            //右 pass
            gestureDir=RIGHT;
            [self clickPass:passMenu];
            NSLog(@"方向为right：%d",gestureDir);
            
        }
        
    }
    
}

 -(void)initCardsList
{   int num=52;
    int nowPos;
    int Num=52;
    int v[Num];
    for(int ii = 0; ii < Num; ii++){
        v[ii] = ii; 
    }
    num = Num; 
    //初始化52张牌
    cardsList = [[NSMutableArray alloc]init] ;
    for(int i=0; i<4; i++)
    {
        switch(i)
        {
            case 0:
            {
                for(int j=0; j<13; j++)
                {
                    nowPos = arc4random() % num;
                    //                    NSLog(@"序号为%d",nowPos);
                    Card* cardTemp = [[Card alloc]initObjectWithNum:v[nowPos]+1 ];
                    [cardTemp initObjectWithType:v[nowPos]/DotNum+1  andNum:(v[nowPos]) % DotNum+1 ];
                    //                    NSLog(@"%d",v[nowPos]/DotNum);
                    [cardsList addObject:cardTemp];
                    v[nowPos] = v[--num]; 
                    //                    [self addChild:cardTemp z:1 ];
                    [cardTemp release];
                }
                break;
            }
            case 1:
            {
                for(int j=0; j<13; j++)
                {
                    nowPos = arc4random() % num;
                    Card* cardTemp = [[Card alloc]initObjectWithNum:v[nowPos]+1 ];
                    [cardTemp initObjectWithType:v[nowPos]/DotNum+1  andNum:(v[nowPos] % DotNum) + 1 ];
                    //NSLog(@"%d",v[nowPos]/DotNum);
                    [cardsList addObject:cardTemp];
                    v[nowPos] = v[--num]; 
                    //[self addChild:cardTemp z:1];
                    [cardTemp release];
                }
                break;
            }
            case 2:
            {
                for(int j=0; j<13; j++)
                {
                    nowPos = arc4random() % num;
                    
                    Card* cardTemp = [[Card alloc]initObjectWithNum:v[nowPos]+1];
                    [cardTemp initObjectWithType:v[nowPos]/DotNum+1  andNum:(v[nowPos] % DotNum) + 1 ];
                    // NSLog(@"%d",v[nowPos]/DotNum);
                    [cardsList addObject:cardTemp];
                    v[nowPos] = v[--num]; 
                    [cardTemp release];
                    //  [self addChild:cardTemp z:1];
                    
                }
                break;
            }
            case 3:
            {
                for(int j=0; j<13; j++)
                {
                    nowPos = arc4random() % num;
                    Card* cardTemp = [[Card alloc]initObjectWithNum:v[nowPos]+1];
                    [cardTemp initObjectWithType:v[nowPos]/DotNum+1  andNum:(v[nowPos] % DotNum) + 1 ];
                    
                    [cardsList addObject:cardTemp];
                    v[nowPos] = v[--num]; 
                    [cardTemp release];
                    // [self addChild:cardTemp z:1];
                    
                }
                break;
            }
        }
    }
} 

-(void)initPlayersList
{
//    for (int i = 0; i < 4; i++) {
//        player[i] = [[Player alloc]init];
//        player[i].cardsOnHand = [[NSMutableArray alloc] init];
//        player[i].selectCards = [[NSMutableArray alloc] init];
//        player[i].maxSingle = [[Card alloc] init];
//        player[i].secondSingle = [[Card alloc] init];
//        player[i].maxCouple = [[Card alloc] init];
//        //        [player[i].cardsOnHand removeAllObjects];
//        player[i].cardList = [[NSMutableArray alloc]init];
//    } 

    //初始化playerList，并且显示分数和牌数
    playersList = [[NSMutableArray alloc]init];
    for(int i=0; i<4; i++)
    {
        switch(i)
        {
            case 0:
            {
                //player0是用户
                Player* playerTemp = [[Player alloc]initWithFile:@"player0.png"];
                playerTemp.anchorPoint = CGPointZero;
                //卡通头像大小
                 playerTemp.scale = 0.7f;
                playerTemp.playerName=@"linda";
                NSLog(@"player0=%@",playerTemp.playerName);
                [playerTemp initPlayerWithPlayerType:USER PlayerState:OffTurn Postion:i];
                //头像位置,左下角为原点（0，0）头像与显示牌数的距离为35
                [playerTemp setPosition:CGPointMake(15.0f, 46.0f)];
                //触控点未改，还是（60.40）
                [playersList addObject:playerTemp];
                [self addChild:[playersList objectAtIndex:0] z:1 tag:2+i];
                /////对头像添加事件
//                CCSprite * bb = [CCSprite  spriteWithFile:@"player0.png"];
//                CCMenuItemImage* p0  = [CCMenuItemImage itemFromNormalSprite:playerTemp selectedSprite:bb target:self selector:@selector(clickHead:)];
//                CCMenu * pp0=[CCMenu menuWithItems:p0, nil];
//                pp0.position=CGPointMake(60, 60);
//                [self addChild:pp0 z:1 tag:2+i];
                NSString* cardNumString = [NSString stringWithFormat:@"%d",13];
                player0CardNum = [CCLabelTTF labelWithString:cardNumString fontName:@"Marker Felt" fontSize:12];
//                player0CardNum.anchorPoint = CGPointZero;
                player0CardNum.color = ccYELLOW;
                //显示牌数的位置
                player0CardNum.position    = CGPointMake(40.0f,20.0f);
                [self addChild:player0CardNum z:1];
                [playerTemp release];
                //显示玩家名字
                _userName = [[UILabel alloc]init];
                _userName.text = userName;
                _userName.textAlignment = UITextAlignmentCenter;
                _userName.backgroundColor = [UIColor clearColor];
                _userName.textColor = [UIColor whiteColor];
                [_userName setFont:[UIFont fontWithName:@"Helvetica" size:14]];
                [_userName setNumberOfLines:10];
                _userName.hidden = NO;
                [_userName setFrame:CGRectMake(0, 272, 75, 20)];
                [[[CCDirector sharedDirector]openGLView]addSubview:_userName];
                //显示总金币数
                _goldSum = [[UILabel alloc]init];
                NSString * _goldSum2 =[NSString stringWithFormat:@"%ld",score];
                _goldSum.text = _goldSum2;
                _goldSum.textAlignment = UITextAlignmentLeft;
                _goldSum.backgroundColor = [UIColor clearColor];
                _goldSum.textColor = [UIColor yellowColor];
                [_goldSum setFont:[UIFont fontWithName:@"Helvetica" size:15]];
                [_goldSum setNumberOfLines:20];
                _goldSum.hidden = NO;
                [_goldSum setFrame:CGRectMake(389, 5, 90, 20)];
                [[[CCDirector sharedDirector]openGLView]addSubview:_goldSum];
                break;
            }
                
            case 1:
            {
               Player* playerTemp = [[Player alloc]initWithFile:@"player1.png"];   
                playerTemp.anchorPoint = CGPointZero;
                playerTemp.scale = 0.7f;
                playerTemp.playerName=[[NSString alloc]initWithFormat:@"tanke" ];
                [playerTemp initPlayerWithPlayerType:COMPUTER PlayerState:OffTurn Postion:i];
                //玩家位置
                [playerTemp setPosition:CGPointMake(422.0f, 180.0f)];
                [playersList addObject:playerTemp];
                [self addChild:[playersList objectAtIndex:1] z:1 tag:2+i];
                
                NSString* cardNumString = [NSString stringWithFormat:@"%d",13];
                player1CardNum = [CCLabelTTF labelWithString:cardNumString fontName:@"Marker Felt" fontSize:12];
                player1CardNum.anchorPoint = CGPointZero;
                player1CardNum.color = ccYELLOW;
                player1CardNum.position = CGPointMake(450.0f, 155.0f);
                [self addChild:player1CardNum z:1];
                 [playerTemp release];
                
                CCLabelTTF * nextPlayer111 = [CCLabelTTF labelWithString:@"下家" fontName:@"Marker Felt" fontSize:15];
                nextPlayer111.position = CGPointMake(445, 242);
                nextPlayer111.color = ccWHITE;
                [self addChild:nextPlayer111 z:1];
                
                break;
            }
            case 2:
            {
                Player* playerTemp = [[Player alloc]initWithFile:@"player2.png"];   
                playerTemp.anchorPoint = CGPointZero;
                playerTemp.scale = 0.7f;
                playerTemp.playerName = [[NSString alloc]initWithFormat:@"小赵"];
                [playerTemp initPlayerWithPlayerType:COMPUTER PlayerState:OffTurn Postion:i];
                //玩家位置
                [playerTemp setPosition:CGPointMake(160.0f, 260.0f)];
                [playersList addObject:playerTemp];
                [self addChild:[playersList objectAtIndex:2] z:1 tag:2+i];
                NSString* cardNumString = [NSString stringWithFormat:@"%d",13];
                player2CardNum = [CCLabelTTF labelWithString:cardNumString fontName:@"Marker Felt" fontSize:12];
                player2CardNum.anchorPoint = CGPointZero;
                player2CardNum.color = ccYELLOW;
                //显示牌数的位置
                player2CardNum.position    = CGPointMake(220.0f, 260.0f);
                [self addChild:player2CardNum z:1];
                 [playerTemp release]; [playerTemp release];
                CCLabelTTF * facePlayer = [CCLabelTTF labelWithString:@"对家" fontName:@"Marker Felt" fontSize:15];
                facePlayer.position = CGPointMake(145, 285);
                facePlayer.color = ccWHITE;
                [self addChild:facePlayer z:1];
                break;
            }
            case 3:
            {
                Player* playerTemp = [[Player alloc]initWithFile:@"player3.png"];   
                playerTemp.anchorPoint = CGPointZero;
                playerTemp.scale = 0.7f;
                playerTemp.playerName = [[NSString alloc]initWithFormat:@"小李"];
                [playerTemp initPlayerWithPlayerType:COMPUTER   PlayerState:OffTurn  Postion:i];
                //玩家位置
                [playerTemp setPosition:CGPointMake(16.0f, 180.0f)];
                [playersList addObject:playerTemp];
                [self addChild:[playersList objectAtIndex:3] z:1 tag:2+i];
                
                NSString* cardNumString = [NSString stringWithFormat:@"%d",13];
                player3CardNum = [CCLabelTTF labelWithString:cardNumString fontName:@"Marker Felt" fontSize:12];
                player3CardNum.anchorPoint = CGPointZero;
                player3CardNum.color = ccYELLOW;
                
                //显示牌数的位置
                player3CardNum.position    = CGPointMake(45.0f, 155.0f);
                [self addChild:player3CardNum z:1];
                 [playerTemp release];
                CCLabelTTF * abovePlayer = [CCLabelTTF labelWithString:@"上家" fontName:@"Marker Felt" fontSize:15];
                abovePlayer.position = CGPointMake(40, 242);
                abovePlayer.color = ccWHITE;
                [self addChild:abovePlayer z:1];
                break;
            }
        }            
    }    
}

-(void)drawPassLabel
{
    passlabel0=[CCLabelTTF labelWithString:@"pass" fontName:@"Marker Felt" fontSize:25.0];
    passlabel0.anchorPoint=CGPointZero;
    passlabel0.position=CGPointMake(230.0f, 120.0f);
    passlabel0.visible=NO;
    passlabel0.color = ccYELLOW;
    [self addChild:passlabel0 ];
    
    passlabel1=[CCLabelTTF labelWithString:@"pass" fontName:@"Marker Felt" fontSize:25.0];
    passlabel1.anchorPoint=CGPointZero;
    passlabel1.position=CGPointMake(360.0f, 190.0f);
    passlabel1.visible=NO;
    passlabel1.color = ccYELLOW;
//    passlabel1.rotation=90.0;
    [self addChild:passlabel1 ];
    
    passlabel2=[CCLabelTTF labelWithString:@"pass" fontName:@"Marker Felt" fontSize:25.0];
    passlabel2.anchorPoint=CGPointZero;
    passlabel2.position=CGPointMake(180.0f, 220.0f);
    passlabel2.visible=NO;
    passlabel2.color = ccYELLOW;
    [self addChild:passlabel2 ];
    
    passlabel3=[CCLabelTTF labelWithString:@"pass" fontName:@"Marker Felt" fontSize:25.0];
    passlabel3.anchorPoint=CGPointZero;
    passlabel3.position=CGPointMake(90.0f, 180.0f);
    passlabel3.visible=NO;
    passlabel3.color = ccYELLOW;
//    passlabel3.rotation=-90.0;
    [self addChild:passlabel3 ];

}


-(void)drawHeadBtn
{
    
    for (int i=0; i<4; ++i)//循环创建四个玩家头像按钮,右上角为原点
    {
        headbutton=[UIButton  buttonWithType:UIButtonTypeCustom];
        if (i==0)
        {
            [headbutton setFrame:CGRectMake (16.0f, 208.0f, 60.0f,60.0f)];
        }
        if (i==1)
        {
            [headbutton setFrame:CGRectMake (423.0f,80.0f, 60.0f, 60.0f)];
        }
        if (i==2)
        {
            [headbutton setFrame:CGRectMake (160.0f, 10.0f, 60.0f, 60.0f)];
        }
        if (i==3) 
        {
            [headbutton setFrame:CGRectMake (15.0f, 80.0f, 60.0f, 60.0f)];
        }
        [headbutton setAlpha:1.0];
        headbutton.tag=i+1;
        headbutton.enabled=YES;
//        [headbutton setBackgroundColor:[UIColor clearColor]];
        [headbutton addTarget:self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
        [[[CCDirector sharedDirector] openGLView] addSubview:headbutton];
    }
    
}

-(void)initBackCardsList
{
    
    for(int i=1; i<4; i++)
    {
        switch(i)
        {
            case 1:
            {
//                backCards1 = [[NSMutableArray alloc]init];
                for(int j=0; j<13; j++)
                {
                    CCSprite* backCardTemp = [[CCSprite alloc]initWithFile:@"backcard.png"];
                    //backCardTemp.rotation = -90.0f;
                    backCardTemp.scale    = 0.9f;
                    
                    //牌的背面位置
                    backCardTemp.position = CGPointMake(437.0f, 163.0f);
                    
                    [self addChild:backCardTemp z:1];
//                    [backCards1 addObject:backCardTemp];
                    [backCardTemp  release];
                    
                }
                break;
            }
            case 2:
            {
//                backCards2 = [[NSMutableArray alloc]init];
                for(int j=0; j<13; j++)
                {
                    CCSprite* backCardTemp = [[CCSprite alloc]initWithFile:@"backcard.png"];
                    backCardTemp.scale    = 0.9f;
                    
                    backCardTemp.position = CGPointMake(227.0f, 292.0f);
                    
                    [self addChild:backCardTemp z:1];
//                    [backCards2 addObject:backCardTemp];
                     [backCardTemp  release];
                }
                break;
            }
            case 3:
            {
//                backCards3 = [[NSMutableArray alloc]init];
                for(int j=0; j<13; j++)
                {
                    CCSprite* backCardTemp = [[CCSprite alloc]initWithFile:@"backcard.png"];
                    //backCardTemp.rotation = 90.0f;
                    backCardTemp.scale    = 0.9f;
                    backCardTemp.position = CGPointMake(31.0f, 163.0f);
                    [self addChild:backCardTemp z:1];
//                    [backCards3 addObject:backCardTemp];
                     [backCardTemp  release];
                }
                break;
            }
        }
    }
}


-(void)distributeCards
{
    for(int i=0; i<4; i++)
    {
        switch(i)
        {
            case 0:
            {
                player[0] = [playersList objectAtIndex:0];
                for(int j=0; j<13; j++)
                {
              
                    Card* cardTemp = [cardsList objectAtIndex:(j)];
                    cardTemp.visible = YES;
                    cardTemp.scale = 0.63f;
                    cardTemp.anchorPoint = CGPointZero;
                    cardTemp.position = CGPointMake(74.0f+j*27.0f, 10.0f);//直线排列

                    [player[0].cardsOnHand addObject:cardTemp];
                    [self addChild:cardTemp z:1];//添加显示用户玩家牌
                }
            }
                break;

            case 1:
            {
                player[1] = [playersList objectAtIndex:1];
               for(int j=0; j<13; j++)
                {
                    Card* cardTemp = [cardsList objectAtIndex:(13+j)];
                   [player[1].cardsOnHand addObject:cardTemp];
                     
                }
            }
                break;
                
            case 2:
            {
                player[2] = [playersList objectAtIndex:2];
                for(int j=0; j<13; j++)
                {
                    Card* cardTemp = [cardsList objectAtIndex:(26+j)];
                    [player[2].cardsOnHand addObject:cardTemp];
                      
                }
            }
                break;
            
            case 3:
            {
                player[3] = [playersList objectAtIndex:3];
                for(int j=0; j<13; j++)
                {
                    Card* cardTemp = [cardsList objectAtIndex:(39+j)];
                    [player[3].cardsOnHand addObject:cardTemp];
                                   
                }
            }
                break;
        }
    }
}

-(void)playerTakeTurn
{
    winner = [NSUserDefaults standardUserDefaults];
    NSNumber * banker = [winner objectForKey:@"tanke"];
    NSLog(@"%d",[banker intValue]);
    int isNeedSquare3;
    if (square3Select == 1) {
        isNeedSquare3 = 0;
    }else{
        isNeedSquare3 = [banker intValue];
    }
    switch (isNeedSquare3) {
        case 0:
        {
            for(int i=0; i<4; i++)
            {
                Player* playerTemp = [playersList objectAtIndex:i];
                if(playerTemp.hasDiamodsThree)
                {
                    [playerTemp setPlayerState:TakeTurn];
                    lastPos = -1;
                    currentPlayer = playerTemp;
                    currentPlayer.isLastOne = YES;
                    currentPlayer.needSquare3 = YES;
                    //            NSLog(@"当前玩家为%d",i); 
                }
            }
        }
            break;
            
        case 1:
        {
            Player* playerTemp = [playersList objectAtIndex:0];
            [playerTemp setPlayerState:TakeTurn];
            lastPos = 0;
            currentPlayer = playerTemp;
            currentPlayer.isLastOne = YES;
            currentPlayer.needSquare3 = NO;
        }
            break;
            
        case 2:
        {
            Player* playerTemp = [playersList objectAtIndex:1];
            [playerTemp setPlayerState:TakeTurn];
            lastPos = 1;
            currentPlayer = playerTemp;
            currentPlayer.isLastOne = YES;
            currentPlayer.needSquare3 = NO;
        }
            break;
            
        case 3:
        {
            Player* playerTemp = [playersList objectAtIndex:2];
            [playerTemp setPlayerState:TakeTurn];
            lastPos = 2;
            currentPlayer = playerTemp;
            currentPlayer.isLastOne = YES;
            currentPlayer.needSquare3 = NO;
        }
            break;
            
        case 4:
        {
            Player* playerTemp = [playersList objectAtIndex:3];
            [playerTemp setPlayerState:TakeTurn];
            lastPos = 3;
            currentPlayer = playerTemp;
            currentPlayer.isLastOne = YES;
            currentPlayer.needSquare3 = NO;
        }
            break;
            
        default:
            break;
    }
    [winner removeObjectForKey:@"tanke"];
}

-(Boolean)testEnd
{
    if(currentPlayer.cardsOnHand.count == 0)
    {
        //        if(self)//局数达到
        //        {}
        //        else
        //        {}
        //        if(self)//点数达到
        //        {}
        //        else
        //        {}
        gameState = End;
//        [self drawScore ];
        return YES;
        
    }
    else
    {
//        NSLog(@"游戏未结束，当前玩家:%d,手中牌数为：%d",currentPlayer.playerPos,currentPlayer.cardsOnHand.count);
        return NO;
    }
    
}

-(void)calculateScore
{
    if (scoreList == nil) {
        scoreList = [[NSMutableArray alloc]init];
    }

    NSUserDefaults * gameEnd = [NSUserDefaults standardUserDefaults];
//    NSUserDefaults * gameEnd111 = [NSUserDefaults standardUserDefaults];
    scoreList = [gameEnd objectForKey:@"allScore"];
    NSLog(@"%d",scoreList.count);

    NSMutableArray * scoreTemp;
//    if (scoreTemp == nil) {
        scoreTemp = [[NSMutableArray alloc]init];
//    }
    
    for (int i = 0; i < scoreList.count; i++) {
        NSNumber * temp = [scoreList objectAtIndex:i];
        [scoreTemp addObject:temp];
    }
    
    NSNumber * playerNumber;
    Player * playerTemp;
    for (int i = 0; i < 4; i++) {
        playerTemp = [playersList objectAtIndex:i];
        scoreCard0 = [playerTemp scoreCard];
        playerNumber = [NSNumber numberWithInt:scoreCard0];
//        NSLog(@"%d",[playerNumber intValue]);
        [scoreTemp addObject:playerNumber];
//        NSLog(@"%d",scoreList.count);
    }
    
    NSLog(@"%d",scoreTemp.count);
    NSUserDefaults * gameEnd1 = [NSUserDefaults standardUserDefaults];
    [gameEnd1 setObject:scoreTemp forKey:@"allScore"];
    
    sumScore0 = [self calculate:scoreTemp index:0];//第一个玩家总分
    NSLog(@"%d",sumScore0);
    sumScore1 = [self calculate:scoreTemp index:1];//第二个玩家总分
    NSLog(@"%d",sumScore1);
    sumScore2 = [self calculate:scoreTemp index:2];//第三个玩家总分
    NSLog(@"%d",sumScore2);
    sumScore3 = [self calculate:scoreTemp index:3];//第四个玩家总分
    NSLog(@"%d",sumScore3);
    int turns = 0;//轮次统计
    turns = scoreTemp.count/4;
    NSLog(@"%d",turns);

    switch (pointOrTurns) {
        case 11:
        {
            if (sumScore0 >= 100 || sumScore1 >= 100 || sumScore2 >= 100 || sumScore3 >= 100)
            {
                //本大局游戏结束
//                [gameEnd1 removeObjectForKey:@"allScore"];
                [winner removeObjectForKey:@"tanke"];
                [self drawScore ];
            }else{
                //每轮次分数榜
                [self scoreShow];
            }
        }
            break;
            
        case 12:
        {
            if (sumScore0 >= 200 || sumScore1 >= 200 || sumScore2 >= 200 || sumScore3 >= 200) {
                //本大局游戏结束
//                [gameEnd1 removeObjectForKey:@"allScore"];
                [winner removeObjectForKey:@"tanke"];
                [self drawScore ];

            }else{
                //每轮次分数榜
                [self scoreShow];
            }
        }
            break;
            
        case 13:
        {
            if (sumScore0 >= 500 || sumScore1 >= 500 || sumScore2 >= 500 || sumScore3 >= 500) {
                //本大局游戏结束
//                [gameEnd1 removeObjectForKey:@"allScore"];
                [winner removeObjectForKey:@"tanke"];
                [self drawScore ];

            }else{
                //每轮次分数榜
                [self scoreShow ];

            }
        }
            break;
            
        case 21:
        {
            if (turns == 10) {
                //本大局游戏结束
//                [gameEnd1 removeObjectForKey:@"allScore"];
                [winner removeObjectForKey:@"tanke"];
                [self drawScore ];

            }else{
                //每轮次分数榜
                [self scoreShow ];

            }
        }
            break;
            
        case 22:
        {
            if (turns == 20) {
                //本大局游戏结束
//                [gameEnd1 removeObjectForKey:@"allScore"];
                [winner removeObjectForKey:@"tanke"];
                [self drawScore ];
            }else{
                //每轮次分数榜
                [self scoreShow ];

            }
        }
            break;
            
        case 23:
        {
            if (turns == 50) {
                //本大局游戏结束
//                [gameEnd1 removeObjectForKey:@"allScore"];
                [winner removeObjectForKey:@"tanke"];
                [self drawScore ];
            }else{
                //每轮次分数榜
                [self scoreShow ];

            }
        }
            break;
            
        default:
            break;
    }
    
//    [scoreList autorelease];
//    [scoreTemp autorelease];
}

- (void) scoreShow//当局结束后分数小计显示
{
    
//    //        //添加广告
//            [YouMiView setShouldCacheImage:NO];
//            YouMiView *adView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:nil];
//   
//           adView.appID = @"62630359b71510c5";
//            adView.appSecret = @"93631ff3218c4908";
//            adView.appVersion = @"1.0";
//          [adView start];
//           [[[CCDirector sharedDirector] openGLView] addSubview: adView];
    [_userName setHidden:YES];
    [_goldSum setHidden:YES];
    dataBase = [[CD2Database alloc]init];
    [dataBase openDatabase];
    [dataBase createTable];
    [dataBase selectLastName];
//    score = dataBase.score;
    NSLog(@"the score is  %ld",score);
    [dataBase updateUserEndScore:dataBase.userName1 withScore:score];
    [dataBase selectLastName];
    NSLog(@"the score2 is %ld",dataBase.score);
    [dataBase closeDatabase];
    [dataBase release];

    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4) 
        {
            temphead.enabled=NO;
        }
    }

    CCSprite * score_sprite_on =[CCSprite spriteWithFile:@"得分.png"];
    CCSprite * score_sprite_off =[CCSprite spriteWithFile:@"得分.png"];
    CCMenuItemImage * score_sprite_menuItem = [CCMenuItemImage itemFromNormalSprite:score_sprite_on selectedSprite:score_sprite_off target:self selector:@selector(clickGetScoreShow)];
    CCMenu * score_sprite = [CCMenu menuWithItems:score_sprite_menuItem, nil];
    score_sprite.anchorPoint=CGPointMake(0.0f, 0.0f);
    score_sprite.visible =YES;
    [self addChild:score_sprite z:2];
    
    CCSprite *  continue_score_off=[CCSprite spriteWithFile:@"continue111.png"];
    CCSprite *contineu_score_on=[CCSprite spriteWithFile:@"btncontinue111.png"];
    CCMenuItemImage * img=[CCMenuItemImage itemFromNormalSprite:continue_score_off selectedSprite:contineu_score_on target:self selector:@selector(clickContinueGame:)];
    CCMenu * continueMenu=[CCMenu menuWithItems:img, nil];
    continueMenu.anchorPoint=CGPointZero;
    continueMenu.scale=0.65f;
    continueMenu.position=CGPointMake(240.0f, 50.0f);
    continueMenu.visible=YES;
    [self addChild:continueMenu z:2];

    NSMutableArray * tempList;
    if (tempList == nil) {
        tempList = [[NSMutableArray alloc]init];
    }
    NSUserDefaults * gameEnd = [NSUserDefaults standardUserDefaults];
    tempList = [gameEnd objectForKey:@"allScore"];
    NSLog(@"%d",tempList.count);
    
    //滚动试图
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 120.0f)];//设置可视化界面大小
    scrollView.pagingEnabled=YES;
//    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.center = CGPointMake(242.0,173.0);
    int line = tempList.count/4;//列数
//    int line =10;//列数
    scrollView.contentSize = CGSizeMake(320, (line+ 1)*25);//真实大小
    scrollView.alwaysBounceVertical = YES;//支持上下滑动
    scrollView.hidden = NO;
    [[[CCDirector sharedDirector]openGLView]addSubview:scrollView];
    //显示得分版
    for (int j = 0; j < line; j++) {
        UILabel * showTurns = [[UILabel alloc]init];
        NSString * tempScore1 = [NSString stringWithFormat:@"%d",j+1];
        showTurns.text = tempScore1;
        showTurns.textAlignment = UITextAlignmentCenter;
        showTurns.backgroundColor = [UIColor lightTextColor];
        showTurns.textColor = [UIColor yellowColor];
//            showScore.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
        [showTurns setFrame:CGRectMake(0,0+j*25, 60, 25)];
        [scrollView addSubview:showTurns];
        
        for (int i = 0; i < 4; i++) {
            int index = [[tempList objectAtIndex:j*4+i] intValue];
            NSString * tempScore2 = [NSString stringWithFormat:@"%d",index];
            UILabel * showScore = [[UILabel alloc]init];
            showScore.text = tempScore2;
            showScore.textAlignment = UITextAlignmentCenter;
            showScore.backgroundColor = [UIColor lightTextColor];
            showScore.textColor = [UIColor yellowColor];
            [showScore setFrame:CGRectMake(61+i*62,0+j*25, 62, 25)];
            [scrollView addSubview:showScore];
        }
    }
    UILabel * sumScore = [[UILabel alloc]init];
    NSString * tempSum = [NSString stringWithFormat:@"总分"];
    sumScore.text = tempSum;
    sumScore.textAlignment = UITextAlignmentCenter;
    sumScore.backgroundColor = [UIColor lightTextColor];
    sumScore.textColor = [UIColor yellowColor];
    [sumScore setFrame:CGRectMake(0,1+line*25, 60, 25)];
    [scrollView addSubview:sumScore];
    int tempSumScore[4] = {sumScore0,sumScore1,sumScore2,sumScore3};
    for (int i = 0; i < 4; i++) {
        NSString * tempScore2 = [NSString stringWithFormat:@"%d",tempSumScore[i]];
        UILabel * showScore = [[UILabel alloc]init];
        showScore.text = tempScore2;
        showScore.textAlignment = UITextAlignmentCenter;
        showScore.backgroundColor = [UIColor lightTextColor];
        showScore.textColor = [UIColor yellowColor];
        [showScore setFrame:CGRectMake(61+i*62,1+line*25, 62, 25)];
        [scrollView addSubview:showScore];
    }    
    
//    NSString * temp;
//    int j = 0;
//    for (int i = 0; i < tempList.count; i = i+4) {
//        int index1 = [[tempList objectAtIndex:i+0] intValue];
//        int index2 = [[tempList objectAtIndex:i+1] intValue];
//        int index3 = [[tempList objectAtIndex:i+2] intValue];
//        int index4 = [[tempList objectAtIndex:i+3] intValue];
//        j = j++;
//        temp = [NSString stringWithFormat:@"   %d      %d      %d      %d      %d", j, index1,index2, index3, index4];
//        [scoreShow addObject:temp];
//    }
//    NSString * tempSum = [NSString stringWithFormat:@"总分： %d      %d      %d      %d", sumScore0,sumScore1, sumScore2, sumScore3];
//    [scoreShow addObject:tempSum];
//    
//    int count = scoreShow.count;
//    NSLog(@"name : %d",count);
//
//    scoreBoard = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
////    CGAffineTransform rotation = CGAffineTransformMakeRotation(1.57079633);
////    [scoreBoard setTransform:rotation];
//    [scoreBoard setFrame:CGRectMake(65, 80, 335, 150)];
//    scoreBoard.delegate = (id)self;
//    scoreBoard.dataSource = (id)self;
//    [scoreBoard setHidden:NO];
//    [scoreBoard autorelease];
//    [[[CCDirector sharedDirector]openGLView]addSubview:scoreBoard];
}

-(void)clickGetScoreShow
{
    
}

//放回可选项的数目
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return scoreShow.count;
    
}

//设置每项的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

//初始化下拉列表
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"nameTable";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[cellid autorelease]];
    }
    cell.textLabel.text = (NSString *)[scoreShow objectAtIndex:indexPath.row];
    //    cell.textLabel.font = userNameText.font;
    //    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

- (int) calculate:(NSMutableArray *)scoreTemp index:(int)n
{
    int sum = 0;
    int temp = scoreTemp.count;
    for (int i = n; i < temp; i = i+4) {
        sum += [[scoreTemp objectAtIndex:i] intValue];
    }
    return sum;
}

-(void)drawPause
{
    
    //绘制暂停按钮
    CCSprite* pause_off = [CCSprite spriteWithFile:@"bt_pause_off.png"];
    CCSprite* pause_on  = [CCSprite spriteWithFile:@"bt_pause_on.png"];
    CCMenuItemImage  * pauseImg=[CCMenuItemImage itemFromNormalSprite:pause_off selectedSprite:pause_on target:self selector:@selector(clickPause:)];
    pauseMenu = [CCMenu menuWithItems:pauseImg, nil];
    //参考点
    pauseMenu.anchorPoint = CGPointZero;
    //图片大小，改为0.4
    pauseMenu.scale       = 0.7f;
    //改为18.303
    pauseMenu.position    = CGPointMake(30.0f, 295.0f);
    [self addChild:pauseMenu z:1  tag:2];
    
        
}
-(void)drawMenu
{//绘制弹出菜单项
//    gameState=Pause;
    //返回游戏
    CCSprite * menu_bg1 = [CCSprite spriteWithFile:@"gameMenu.png"];
    CCSprite * menu_bg22 = [CCSprite spriteWithFile:@"游戏菜单.png"];
    menu_bg = [CCMenuItemImage itemFromNormalSprite:menu_bg1 selectedSprite:menu_bg22 target:self selector:@selector(clickMenu_bg)];
    menu_bg.position = CGPointMake(240.0f, 160.0f);
    menu_bg.visible  = NO;
    [self addChild:menu_bg  z:3 tag:1];
    
    CCSprite * backGame    = [CCSprite  spriteWithFile:@"backgame.png"];
    CCSprite * backGame_on = [CCSprite  spriteWithFile:@"btnbackgame.png"];
    CCMenuItemImage* back  = [CCMenuItemImage itemFromNormalSprite:backGame selectedSprite:backGame_on target:self selector:@selector(clickBackGame:)];
    //重新开始
    CCSprite * newGame    = [CCSprite  spriteWithFile:@"newgame.png"];
    CCSprite * newGame_on = [CCSprite  spriteWithFile:@"btnnewgame.png"];
    CCMenuItemImage* new  = [CCMenuItemImage itemFromNormalSprite:newGame selectedSprite:newGame_on target:self selector:@selector(clickNewGame:)];
    //设置音效
    CCSprite * setVoice    = [CCSprite  spriteWithFile:@"setvoice111.png"];
    CCSprite * setVoice_on = [CCSprite  spriteWithFile:@"btnsetvoice.png"];
    CCMenuItemImage* set = [CCMenuItemImage itemFromNormalSprite:setVoice  selectedSprite:setVoice_on target:self selector:@selector(clickSetVoice:)];
    //查看规则
    CCSprite * lookRegular = [CCSprite  spriteWithFile:@"look111.png"];
    CCSprite * lookRegular_on = [CCSprite  spriteWithFile:@"btnlook.png"];
    CCMenuItemImage* regular = [CCMenuItemImage itemFromNormalSprite:lookRegular selectedSprite:lookRegular_on target:self selector:@selector(clickRegular:)];
    //查看排行
    CCSprite * lookRank    = [CCSprite  spriteWithFile:@"rank.png"];
    CCSprite * lookRank_on = [CCSprite  spriteWithFile:@"btnrank.png"];
    
    CCMenuItemImage* rank=[CCMenuItemImage itemFromNormalSprite:lookRank   selectedSprite:lookRank_on target:self selector:@selector(clickRank)];
    ////添加到菜单列表
    mainMenu=[CCMenu menuWithItems:back,new,set,regular,rank, nil];
    
    [mainMenu  alignItemsVerticallyWithPadding:10];       //将项目纵向对齐
//    mainMenu.anchorPoint=CGPointZero;
    mainMenu.scale=0.7f;
//    mainMenu.position=CGPointMake(0, 0);
    mainMenu.anchorPoint = ccp(0.07, 0.0);
    mainMenu.visible=NO;
    
    [self addChild:mainMenu  z:3 tag:2];        //把mainMenu加入视图中
}

-(void)clickMenu_bg
{
    
}

-(void)drawScore
{
//    //添加广告
//    [YouMiView setShouldCacheImage:NO];
//    YouMiView *adView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier468x60 delegate:nil];
//    adView.appID = @"62630359b71510c5";
//    adView.appSecret = @"93631ff3218c4908";
//    adView.appVersion = @"1.0";
//    [adView start];
//    [[[CCDirector sharedDirector] openGLView] addSubview: adView];
    
    [_userName setHidden:YES];
    [_goldSum setHidden:YES];
    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4) 
        {
            temphead.enabled=NO;
        }
    }
    //得分视图
     //背景图片
    CCSprite *  score_sprite_on =[CCSprite spriteWithFile:@"游戏结束和得分.png"];
    CCSprite *  score_sprite_off=[CCSprite spriteWithFile:@"游戏结束和得分.png"];
    CCMenuItemImage * score_sprite_MenuItem=[CCMenuItemImage itemFromNormalSprite:score_sprite_on selectedSprite:score_sprite_off target:self selector:@selector(clickGetScoreBackgroud)];
    CCMenu * score_sprite=[CCMenu menuWithItems:score_sprite_MenuItem, nil];
    score_sprite.anchorPoint=CGPointZero;
    score_sprite.visible =YES;
    [self addChild:score_sprite z:2];

    NSMutableArray * tempList;
    if (tempList == nil) {
        tempList = [[NSMutableArray alloc]init];
    }
    NSUserDefaults * gameEnd = [NSUserDefaults standardUserDefaults];
    tempList = [gameEnd objectForKey:@"allScore"];
    NSLog(@"%d",tempList.count);
    [gameEnd removeObjectForKey:@"allScore"];

    //滚动试图
    scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 120.0f)];//设置可视化界面大小
    scrollView2.pagingEnabled=YES;
//    scrollView2.backgroundColor = [UIColor whiteColor];
    scrollView2.center = CGPointMake(242.0,136.0);
    int line = tempList.count/4;//列数
//    int line =10;//列数
    scrollView2.contentSize = CGSizeMake(320, (line+ 1)*25);//真实大小
    scrollView2.alwaysBounceVertical = YES;//支持上下滑动
    scrollView2.hidden = NO;
    [[[CCDirector sharedDirector]openGLView]addSubview:scrollView2];
    //显示得分版
    for (int j = 0; j < line; j++) {
        UILabel * showTurns = [[UILabel alloc]init];
        NSString * tempScore1 = [NSString stringWithFormat:@"%d",j+1];
        showTurns.text = tempScore1;
        showTurns.textAlignment = UITextAlignmentCenter;
        showTurns.backgroundColor = [UIColor lightTextColor];
        showTurns.textColor = [UIColor yellowColor];
        //            showScore.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
        [showTurns setFrame:CGRectMake(0,0+j*25, 60, 25)];
        [scrollView2 addSubview:showTurns];
        
        for (int i = 0; i < 4; i++) {
            int index = [[tempList objectAtIndex:j*4+i] intValue];
            NSString * tempScore2 = [NSString stringWithFormat:@"%d",index];
            UILabel * showScore = [[UILabel alloc]init];
            showScore.text = tempScore2;
            showScore.textAlignment = UITextAlignmentCenter;
            showScore.backgroundColor = [UIColor lightTextColor];
            showScore.textColor = [UIColor yellowColor];
            [showScore setFrame:CGRectMake(61+i*62,0+j*25, 62, 25)];
            [scrollView2 addSubview:showScore];
        }
    }
    UILabel * sumScore = [[UILabel alloc]init];
    NSString * tempSum = [NSString stringWithFormat:@"总分"];
    sumScore.text = tempSum;
    sumScore.textAlignment = UITextAlignmentCenter;
    sumScore.backgroundColor = [UIColor lightTextColor];
    sumScore.textColor = [UIColor yellowColor];
    [sumScore setFrame:CGRectMake(0,1+line*25, 60, 25)];
    [scrollView2 addSubview:sumScore];
    int tempSumScore[4] = {sumScore0,sumScore1,sumScore2,sumScore3};
    for (int i = 0; i < 4; i++) {
        NSString * tempScore2 = [NSString stringWithFormat:@"%d",tempSumScore[i]];
        UILabel * showScore = [[UILabel alloc]init];
        showScore.text = tempScore2;
        showScore.textAlignment = UITextAlignmentCenter;
        showScore.backgroundColor = [UIColor lightTextColor];
        showScore.textColor = [UIColor yellowColor];
        [showScore setFrame:CGRectMake(61+i*62,1+line*25, 62, 25)];
        [scrollView2 addSubview:showScore];
    }    

    int averageScore = (sumScore0+sumScore1+sumScore2+sumScore3)/4;
    int getScore = averageScore - sumScore0;
    NSLog(@"the score is  %ld",score);
    displayScore = score + getScore;
    dataBase = [[CD2Database alloc]init];
    [dataBase openDatabase];
    [dataBase createTable];
    [dataBase selectLastName];
    [dataBase updateUserEndScore:dataBase.userName1 withScore:displayScore];
    [dataBase selectLastName];
    NSLog(@"the score2 is %ld",dataBase.score);
    [dataBase closeDatabase];
    [dataBase release];
    
    //获得的金币数
    NSString* _getScore = [NSString stringWithFormat:@"%d",getScore];
    CCLabelTTF * showGetScore = [CCLabelTTF labelWithString:_getScore fontName:@"Marker Felt" fontSize:20];
    //    playerAllScore.anchorPoint = CGPointZero;
    showGetScore.color = ccYELLOW;
    showGetScore.position    = CGPointMake(160.0f,95.0f);
    [self addChild:showGetScore z:2];
    
    //总金币数
    NSLog(@"the displayscore is  %ld",displayScore);
    NSString* allScore = [NSString stringWithFormat:@"%ld",displayScore];
    CCLabelTTF * playerAllScore = [CCLabelTTF labelWithString:allScore fontName:@"Marker Felt" fontSize:20];
//    playerAllScore.anchorPoint = CGPointZero;
    playerAllScore.color = ccYELLOW;
    playerAllScore.position    = CGPointMake(340.0f,95.0f);
    [self addChild:playerAllScore z:2];
    
    //重新开始按钮
    CCSprite * continue_score_off=[CCSprite spriteWithFile:@"重新开始按钮.png"];
    CCSprite *contineu_score_on=[CCSprite spriteWithFile:@"btn重新开始按钮.png"];
    CCMenuItemImage * img=[CCMenuItemImage itemFromNormalSprite:continue_score_off selectedSprite:contineu_score_on target:self selector:@selector(clickContinueGame:)];
    CCMenu * continueMenu=[CCMenu menuWithItems:img, nil];
    continueMenu.anchorPoint=CGPointZero;
    continueMenu.scale=0.55f;
    continueMenu.position=CGPointMake(330.0f, 62.0f);
    continueMenu.visible=YES;
    [self addChild:continueMenu z:2];
    //主菜单按钮
    CCSprite * mainMenu_on =[CCSprite spriteWithFile:@"主菜单.png"];
    CCSprite * mainMenu_off=[CCSprite spriteWithFile:@"btn主菜单.png"];
    CCMenuItemImage * mainMenuItem = [CCMenuItemImage itemFromNormalSprite:mainMenu_on selectedSprite:mainMenu_off target:self selector:@selector(clickMainVeiw:)];
    CCMenu * btmainMenu =[CCMenu menuWithItems:mainMenuItem, nil];
    btmainMenu.anchorPoint=CGPointZero;
    btmainMenu.scale=0.55f;
    btmainMenu.position=CGPointMake(150.0f, 62.0f);
    btmainMenu.visible=YES;
    [self addChild:btmainMenu z:2];
}

-(void)clickGetScoreBackgroud
{
    
}

-(void)clickMainVeiw:()sender
{
    [scrollView2 setHidden:YES];
    [scrollView2 release];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.3f scene:[GameMainViewContorller scene]]];
}

-(void)clickContinueGame:(id)sender
{
    gameState=Continue;
    [scrollView2 setHidden:YES];
    [scrollView2 release];
    [scrollView setHidden:YES];
    [scrollView release];
//    [scoreBoard setHidden:YES];
    //一局结束后继续
//    dataBase = [[CD2Database alloc]init];
//    [dataBase openDatabase];
//    [dataBase createTable];
//    [dataBase selectLastName];
//    [dataBase updateUserEndScore:dataBase.userName1 withScore:score];
//    
//    [dataBase closeDatabase];
//    [dataBase release];
    CCScene * sc=[CCScene node];
    [sc addChild:[ PlayGameView scene]];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInB  transitionWithDuration:0.1f scene:sc] ];
}

//验证牌型
-(void)drawNotice
{
    //添加手势对象
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger num = [delegate.viewController.view gestureRecognizers].count;
    NSLog(@"shoushi个数为%d",num);
    gestureRecognizer1 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:2];
    gestureRecognizer2 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:3];
    gestureRecognizer3 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:0];
    gestureRecognizer4 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:1];
    
    gestureRecognizer1.enabled = NO;
    gestureRecognizer2.enabled = NO;
    gestureRecognizer3.enabled = NO;
    gestureRecognizer4.enabled = NO;
    NSLog(@"菜单关闭手势");
    
    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4)
        {
            temphead.enabled=NO;
        }
    }
    if (gameState ==Update) {
        CCSprite * alert_1 = [CCSprite spriteWithFile:@"提示不符合规则.png"];
        CCSprite * alert_2 = [CCSprite spriteWithFile:@"提示不符合规则.png"];
        CCMenuItemImage * alert_item = [CCMenuItemImage itemFromNormalSprite:alert_1 selectedSprite:alert_2 target:self selector:@selector(clickHidden)];
        alert_menu = [CCMenu menuWithItems:alert_item, nil];
        alert_menu.anchorPoint = CGPointZero;
//        alert_item.position = CGPointMake(0, 0);
        alert_menu.visible = YES;
        [self addChild:alert_menu z:3];
    }
    gameState=Update;

//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"亲！不符合出牌规则！" delegate:self cancelButtonTitle:@"知道" otherButtonTitles:nil];
//        alert.tag=2;
//        [alert show];
//        [alert release];
}
//
-(void)drawNotice_NeedMaxCard
{
    //添加手势对象
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger num = [delegate.viewController.view gestureRecognizers].count;
    NSLog(@"shoushi个数为%d",num);
    gestureRecognizer1 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:2];
    gestureRecognizer2 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:3];
    gestureRecognizer3 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:0];
    gestureRecognizer4 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:1];
    
    gestureRecognizer1.enabled = NO;
    gestureRecognizer2.enabled = NO;
    gestureRecognizer3.enabled = NO;
    gestureRecognizer4.enabled = NO;
    NSLog(@"菜单关闭手势");
    
    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4)
        {
            temphead.enabled=NO;
        }
    }
    
    passlabel0.visible = NO;
    if (gameState ==Update) {
        CCSprite * alert_1 = [CCSprite spriteWithFile:@"提示需要顶大.png"];
        CCSprite * alert_2 = [CCSprite spriteWithFile:@"提示需要顶大.png"];
        CCMenuItemImage * alert_item = [CCMenuItemImage itemFromNormalSprite:alert_1 selectedSprite:alert_2 target:self selector:@selector(clickHidden)];
        alert_menu_needMaxCard = [CCMenu menuWithItems:alert_item, nil];
        alert_menu_needMaxCard.anchorPoint = CGPointZero;
        //        alert_item.position = CGPointMake(0, 0);
        alert_menu_needMaxCard.visible = YES;
        [self addChild:alert_menu_needMaxCard z:3];
    }
    gameState=Update;
}

-(void)drawNotice_noCards
{
    //添加手势对象
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger num = [delegate.viewController.view gestureRecognizers].count;
    NSLog(@"shoushi个数为%d",num);
    gestureRecognizer1 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:2];
    gestureRecognizer2 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:3];
    gestureRecognizer3 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:0];
    gestureRecognizer4 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:1];
    
    gestureRecognizer1.enabled = NO;
    gestureRecognizer2.enabled = NO;
    gestureRecognizer3.enabled = NO;
    gestureRecognizer4.enabled = NO;
    NSLog(@"菜单关闭手势");
    
    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4)
        {
            temphead.enabled=NO;
        }
    }
    if (gameState ==Update) {
        CCSprite * alert_1 = [CCSprite spriteWithFile:@"提示未选择任何牌.png"];
        CCSprite * alert_2 = [CCSprite spriteWithFile:@"提示未选择任何牌.png"];
        CCMenuItemImage * alert_item = [CCMenuItemImage itemFromNormalSprite:alert_1 selectedSprite:alert_2 target:self selector:@selector(clickHidden)];
        alert_menu_noCards = [CCMenu menuWithItems:alert_item, nil];
        alert_menu_noCards.anchorPoint = CGPointZero;
        //        alert_item.position = CGPointMake(0, 0);
        alert_menu_noCards.visible = YES;
        [self addChild:alert_menu_noCards z:3];
    }
    gameState=Update;
}

-(void)drawNotice_notYourturns
{
    //添加手势对象
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger num = [delegate.viewController.view gestureRecognizers].count;
    NSLog(@"shoushi个数为%d",num);
    gestureRecognizer1 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:2];
    gestureRecognizer2 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:3];
    gestureRecognizer3 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:0];
    gestureRecognizer4 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:1];
    
    gestureRecognizer1.enabled = NO;
    gestureRecognizer2.enabled = NO;
    gestureRecognizer3.enabled = NO;
    gestureRecognizer4.enabled = NO;
    NSLog(@"菜单关闭手势");
    
    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4)
        {
            temphead.enabled=NO;
        }
    }
    if (gameState ==Update) {
        CCSprite * alert_1 = [CCSprite spriteWithFile:@"提示没轮到出牌.png"];
        CCSprite * alert_2 = [CCSprite spriteWithFile:@"提示没轮到出牌.png"];
        CCMenuItemImage * alert_item = [CCMenuItemImage itemFromNormalSprite:alert_1 selectedSprite:alert_2 target:self selector:@selector(clickHidden)];
        alert_menu_notYourturn = [CCMenu menuWithItems:alert_item, nil];
        alert_menu_notYourturn.anchorPoint = CGPointZero;
        //        alert_item.position = CGPointMake(0, 0);
        alert_menu_notYourturn.visible = YES;
        [self addChild:alert_menu_notYourturn z:3];
    }
    gameState=Update;
}

-(void)drawNotice_neverGiveup
{
    //添加手势对象
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger num = [delegate.viewController.view gestureRecognizers].count;
    NSLog(@"shoushi个数为%d",num);
    gestureRecognizer1 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:2];
    gestureRecognizer2 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:3];
    gestureRecognizer3 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:0];
    gestureRecognizer4 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:1];
    
    gestureRecognizer1.enabled = NO;
    gestureRecognizer2.enabled = NO;
    gestureRecognizer3.enabled = NO;
    gestureRecognizer4.enabled = NO;
    NSLog(@"菜单关闭手势");
    
    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4)
        {
            temphead.enabled=NO;
        }
    }
    if (gameState ==Update) {
        CCSprite * alert_1 = [CCSprite spriteWithFile:@"提示不能放弃牌局.png"];
        CCSprite * alert_2 = [CCSprite spriteWithFile:@"提示不能放弃牌局.png"];
        CCMenuItemImage * alert_item = [CCMenuItemImage itemFromNormalSprite:alert_1 selectedSprite:alert_2 target:self selector:@selector(clickHidden)];
        alert_menu_neverGiveup = [CCMenu menuWithItems:alert_item, nil];
        alert_menu_neverGiveup.anchorPoint = CGPointZero;
        //        alert_item.position = CGPointMake(0, 0);
        alert_menu_neverGiveup.visible = YES;
        [self addChild:alert_menu_neverGiveup z:3];
    }
    gameState=Update;
}

-(void)clickHidden
{
    alert_menu.visible = NO;
    alert_menu_needMaxCard.visible = NO;
    alert_menu_noCards.visible = NO;
    alert_menu_notYourturn.visible = NO;
    alert_menu_neverGiveup.visible = NO;
//    pauseMenu.isTouchEnabled=YES;
    gestureRecognizer1.enabled=YES;
    gestureRecognizer2.enabled=YES;
    gestureRecognizer3.enabled=YES;
    gestureRecognizer4.enabled=YES;
    gameState=Update;
    
    //开启头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4)
        {
            temphead.enabled=YES;
        }
    }
}

//确定拥有最大单和第二大单，与最大对
- (void) determineMaxCards
{
    [player[0] getMaxCards:player[0].cardsOnHand];
    [player[1] getMaxCards:player[1].cardsOnHand];
    [player[2] getMaxCards:player[2].cardsOnHand];
    [player[3] getMaxCards:player[3].cardsOnHand];
    
    if ([player[2].maxSingle compareLess:player[1].maxSingle] && [player[3].maxSingle compareLess:player[1].maxSingle] && [player[0].maxSingle compareLess:player[1].maxSingle]) {
        player[1]._isMaxSingle = YES;
        player[2]._isMaxSingle = NO;
        player[3]._isMaxSingle = NO;
        if ([player[2].maxSingle compareLess:player[1].secondSingle] && [player[3].maxSingle compareLess:player[1].secondSingle] && [player[0].maxSingle compareLess:player[1].secondSingle]) {
            player[1]._isSecondSingle = YES;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].secondSingle compareLess:player[2].maxSingle] && [player[3].maxSingle compareLess:player[2].maxSingle] && [player[0].maxSingle compareLess:player[2].maxSingle]){
            player[2]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].secondSingle compareLess:player[3].maxSingle] && [player[2].maxSingle compareLess:player[3].maxSingle] && [player[0].maxSingle compareLess:player[3].maxSingle]){
            player[3]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
        }else{
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }
        
    }else if([player[1].maxSingle compareLess:player[2].maxSingle] && [player[3].maxSingle compareLess:player[2].maxSingle] && [player[0].maxSingle compareLess:player[2].maxSingle]){
        player[2]._isMaxSingle = YES;
        player[1]._isMaxSingle = NO;
        player[3]._isMaxSingle = NO;
        if ([player[2].secondSingle compareLess:player[1].maxSingle] && [player[3].maxSingle compareLess:player[1].maxSingle] && [player[0].maxSingle compareLess:player[1].maxSingle]) {
            player[1]._isSecondSingle = YES;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].maxSingle compareLess:player[2].secondSingle] && [player[3].maxSingle compareLess:player[2].secondSingle] && [player[0].maxSingle compareLess:player[2].secondSingle]){
            player[2]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].maxSingle compareLess:player[3].maxSingle] && [player[2].secondSingle compareLess:player[3].maxSingle] && [player[0].maxSingle compareLess:player[3].maxSingle]){
            player[3]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
        }else{
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }
        
    }else if([player[2].maxSingle compareLess:player[3].maxSingle] && [player[1].maxSingle compareLess:player[3].maxSingle] && [player[0].maxSingle compareLess:player[3].maxSingle]){
        player[3]._isMaxSingle = YES;
        player[2]._isMaxSingle = NO;
        player[1]._isMaxSingle = NO;
        if ([player[2].maxSingle compareLess:player[1].maxSingle] && [player[3].secondSingle compareLess:player[1].maxSingle] && [player[0].maxSingle compareLess:player[1].maxSingle]) {
            player[1]._isSecondSingle = YES;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].maxSingle compareLess:player[2].maxSingle] && [player[3].secondSingle compareLess:player[2].maxSingle] && [player[0].maxSingle compareLess:player[2].maxSingle]){
            player[2]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].maxSingle compareLess:player[3].secondSingle] && [player[2].maxSingle compareLess:player[3].secondSingle] && [player[0].maxSingle compareLess:player[3].secondSingle]){
            player[3]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
        }else{
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }
    }else{
        player[1]._isMaxSingle = NO;
        player[2]._isMaxSingle = NO;
        player[3]._isMaxSingle = NO;
        if ([player[2].maxSingle compareLess:player[1].maxSingle] && [player[3].maxSingle compareLess:player[1].maxSingle] && [player[0].secondSingle compareLess:player[1].maxSingle]) {
            player[1]._isSecondSingle = YES;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].maxSingle compareLess:player[2].maxSingle] && [player[3].maxSingle compareLess:player[2].maxSingle] && [player[0].secondSingle compareLess:player[2].maxSingle]){
            player[2]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }else if([player[1].maxSingle compareLess:player[3].maxSingle] && [player[2].maxSingle compareLess:player[3].maxSingle] && [player[0].secondSingle compareLess:player[3].maxSingle]){
            player[3]._isSecondSingle = YES;
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
        }else{
            player[1]._isSecondSingle = NO;
            player[2]._isSecondSingle = NO;
            player[3]._isSecondSingle = NO;
        }
    }
    
    if ([player[2].maxCouple compareLess:player[1].maxCouple] && [player[3].maxCouple compareLess:player[1].maxCouple] && [player[0].maxCouple compareLess:player[1].maxCouple]) {
        player[1]._isMaxCouple = YES;
        player[2]._isMaxCouple = NO;
        player[3]._isMaxCouple = NO;
    }else if([player[1].maxCouple compareLess:player[2].maxCouple] && [player[3].maxCouple compareLess:player[2].maxCouple] && [player[0].maxCouple compareLess:player[2].maxCouple]){
        player[2]._isMaxCouple = YES;
        player[1]._isMaxCouple = NO;
        player[3]._isMaxCouple = NO;
    }else if([player[1].maxCouple compareLess:player[3].maxCouple] && [player[2].maxCouple compareLess:player[3].maxCouple] && [player[0].maxCouple compareLess:player[3].maxCouple]){
        player[3]._isMaxCouple = YES;
        player[2]._isMaxCouple = NO;
        player[1]._isMaxCouple = NO;
    }else{
        player[1]._isMaxCouple = NO;
        player[2]._isMaxCouple = NO;
        player[3]._isMaxCouple = NO;
    }
    player[0]._isMaxSingle = NO;
    //    player[1]._isMaxSingle = NO;
    //    player[2]._isMaxSingle = NO;
    //    player[3]._isMaxSingle = NO;
    //    
    player[0]._isSecondSingle = NO;
    //    player[1]._isSecondSingle = NO;
    //    player[2]._isSecondSingle = NO;
    //    player[3]._isSecondSingle = NO;
    //    
    player[0]._isMaxCouple = NO;
    //    player[1]._isMaxCouple = NO;
    //    player[2]._isMaxCouple = NO;
    //    player[3]._isMaxCouple = NO;
    for (int i = 0; i < 4; i++) //确定是否顶大，和当某一位为单张时
    {
        if ([player[i].cardsOnHand count] == 1) {
            player[1].whenAnyOneSingle = YES; 
            player[2].whenAnyOneSingle = YES; 
            player[3].whenAnyOneSingle = YES; 
            break;
        }else{
            player[i].whenAnyOneSingle = NO; 
            player[i].needMaxCard = NO;
        }
    }
    
    if (player[(currentPlayer.playerPos + 1)%4].cardsOnHand.count == 1 && selectMaxSwitch == 1)//下家手牌是否为一张,判断是否需要顶大
    {
        currentPlayer.needMaxCard = YES;
    }
}


-(void)gameUpdate
{
    switch(currentPlayer.playerType)
    {
        case COMPUTER:
        {
            passlabel0.visible=NO;
//            NSLog(@"%d",player[0].cardsOnHand.count);
            [self determineMaxCards];//判断最大值最小值

            if (showCards == nil) {
                showCards = [[NSMutableArray alloc]init];
            }

            if (currentPlayer.isLastOne == YES)
            {
                [currentPlayer playerShowCards];//主动出牌
                if (currentPlayer.selectCards.count!=0)
                {
                    /////////////////////////报牌声音///主动出牌
                    int cardType_temp=[CardType getCardType:currentPlayer.selectCards];
                    Card * cardTemp=[currentPlayer.selectCards objectAtIndex:0];
                    int num=cardTemp.cardNum;
                    NSString * str;
                    switch (cardType_temp)
                    {
                        case 0:
                            break;
                        case 1://单张
                            str=[NSString stringWithFormat:@"./audio/single/%d.wav",num];
                            break;
                        case 2://对
                            str=[NSString stringWithFormat:@"./audio/double/dui%d.wav",num];
                            break;
                        case 3://三张
                            str=[NSString stringWithFormat:@"./audio/sange.wav"];
                            break;
                        case 4://杂顺
                            str=[NSString stringWithFormat:@"./audio/shunzi.wav"];
                            break;
                        case 5://同花
                            str=[NSString stringWithFormat:@"./audio/tonghua.wav"]; 
                            break;
                        case 6://三代二
                            str=[NSString stringWithFormat:@"./audio/sandaiyidui.wav"];
                            break;
                        case 7://四带一
                            str=[NSString stringWithFormat:@"/audio/sidaiyi.wav"];
                            break;
                        case 8://同花顺
                            str=[NSString stringWithFormat:@"./audio/tonghuashun.wav"];
                            break;
                        default:
                            break;
                    }
                    [[SimpleAudioEngine sharedEngine] playEffect:str];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/show_card.wav"];
                    //
                    if (currentPlayer.cardsOnHand.count==2) 
                    {
                        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/baojing2.wav"];
                    }
                    if (currentPlayer.cardsOnHand.count==1)
                    {
                        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/baojing1.wav"];
                    }
                    
                }
            }
            else
            {
                NSLog(@"%d",showCards.count);
                [currentPlayer playerFollowCards:showCards];//跟牌
                int numA=rand()%4+1;//随机分配音效
                if (currentPlayer.selectCards.count!=0)//跟牌音效
                {
/////////////////////////////////报牌声音//////跟牌
                    int cardType_temp=[CardType getCardType:currentPlayer.selectCards];
                    Card * cardTemp=[currentPlayer.selectCards objectAtIndex:0];
                    int num=cardTemp.cardNum;
                    NSString * str;
                    switch (cardType_temp)
                    {
                            
                        case 0:
                            break;
                        case 1://单张
                            str=[NSString stringWithFormat:@"./audio/single/%d.wav",num];
                            break;
                        case 2://对
                            str=[NSString stringWithFormat:@"./audio/double/dui%d.wav",num];
                            break;
                        case 3://三张
                            str=[NSString stringWithFormat:@"./audio/sange.wav"];
                            break;
                        case 4://杂顺 
                            str=[NSString stringWithFormat:@"./audio/dani%d.wav",numA];
                            break;
                        case 5://同花
                            str=[NSString stringWithFormat:@"./audio/dani%d.wav",numA];
                       
                            break;
                        case 6://三代二
                            str=[NSString stringWithFormat:@"./audio/sandaiyidui.wav"];
                            break;
                        case 7://四带一
                            str=[NSString stringWithFormat:@"/audio/dani%d.wav"];
                            break;
                        case 8://同花顺
                            str=[NSString stringWithFormat:@"./audio/dani%d.wav",numA];
                            break;
                        default:
                            break;
                    }
                    [[SimpleAudioEngine sharedEngine] playEffect:str];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/show_card.wav"];
                    //
                    if (currentPlayer.cardsOnHand.count==2) 
                    {
                        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/baojing2.wav"];
                    }
                    if (currentPlayer.cardsOnHand.count==1)
                    {
                        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/baojing1.wav"];
                    }
                    
                }
                else//pass音效
                {
                    
                    NSString * str=[NSString stringWithFormat:@"./audio/buyao%d.wav",numA];
                    [[SimpleAudioEngine sharedEngine] playEffect:str];
                    
                }
////////////////////报牌音效结束

            }
            
            if (currentPlayer.selectCards.count != 0) 
            {
                showCards = currentPlayer.selectCards;
                currentPlayer.isLastOne =YES;
                NSLog(@"%d",showCards.count);
                for (int i = 1; i < 4; i++) {
                    Player * _player = [playersList objectAtIndex:((currentPlayer.playerPos+i)%4)];
                    _player.isLastOne = NO;
                }
            }
            
            [currentPlayer showCard:self];
            if(currentPlayer.lastCards.count != 0)
            {
                lastPos = currentPlayer.playerPos;
                NSLog(@"最后玩家为%d",lastPos);
            }
            
            if(currentPlayer.playerPos == 1)
            {
                passlabel0.visible=NO;
                if (currentPlayer.selectCards.count==0) 
                {
                    passlabel1.visible=YES;
                }
                int cardNum = currentPlayer.cardsOnHand.count;
                NSLog(@"%d",cardNum);
                [player1CardNum setString:[NSString stringWithFormat:@"%d",cardNum]];
            }
            else if(currentPlayer.playerPos == 2)
            {
                passlabel1.visible=NO;
                if (currentPlayer.selectCards.count==0) 
                {
                    passlabel2.visible=YES;
                }

                int cardNum = currentPlayer.cardsOnHand.count;
                NSLog(@"%d",cardNum);
                [player2CardNum setString:[NSString stringWithFormat:@"%d",cardNum]];
            }
            else if(currentPlayer.playerPos == 3)
            {
                passlabel2.visible=NO;
                if (currentPlayer.selectCards.count==0) 
                {
                    passlabel3.visible=YES;
                }

                int cardNum = currentPlayer.cardsOnHand.count;
                NSLog(@"%d",cardNum);
                [player3CardNum setString:[NSString stringWithFormat:@"%d",cardNum]];
//                if ([[[playersList objectAtIndex:0] selectCards] count] != 0) {
//                    [[[playersList objectAtIndex:0] selectCards] removeAllObjects];
//                }
            }
            
            if (currentPlayer.isShowCard == YES) {
                for (int i = 1; i < 4; i++) {
                    Player * _player = [playersList objectAtIndex:(currentPlayer.playerPos+i)%4];
                    _player.isShowCard = NO;
                }
            }
            NSLog(@"%d",currentPlayer.cardsOnHand.count);
            if(![self testEnd])
            {
///////////////////////更改下一玩家为当前玩家
                currentPlayer.playerState = OffTurn;
                currentPlayer = [playersList objectAtIndex:(currentPlayer.playerPos+1)%4];
                currentPlayer.playerState = TakeTurn;
            }else{
                NSNumber * lastWinner1 = [NSNumber numberWithInt:(currentPlayer.playerPos + 1)];
                NSUserDefaults * winner1 = [NSUserDefaults standardUserDefaults];
                [winner1 setObject:lastWinner1 forKey:@"tanke"];
                [self calculateScore];
            }
            
//            if ([[[playersList objectAtIndex:0] selectCards] count] != 0) {
//                [[[playersList objectAtIndex:0] selectCards] removeAllObjects];
//            }
        }
            break;
        case USER:
        {
            showMenu.visible = YES;
            resetMenu.visible=NO;
            passMenu.visible = NO;
            passlabel3.visible=NO;
            if(currentPlayer.lastCards.count != 0)
            {
                for(int i=0; i<currentPlayer.lastCards.count; i++)
                {
                    Card* cardTemp = [currentPlayer.lastCards objectAtIndex:i];
                    cardTemp.visible = NO;
                }
            }
            [currentPlayer.lastCards removeAllObjects];
            
            if (player[(currentPlayer.playerPos + 1)%4].cardsOnHand.count == 1 && selectMaxSwitch == 1)//下家手牌是否为一张,判断是否需要顶大
            {
                currentPlayer.needMaxCard = YES;
            }
            
            if([self testEnd])
            {
                NSNumber * lastWinner1 = [NSNumber numberWithInt:(currentPlayer.playerPos + 1)];
                NSUserDefaults * winner1 = [NSUserDefaults standardUserDefaults];
                [winner1 setObject:lastWinner1 forKey:@"tanke"];
                [self calculateScore];
            }
            [currentPlayer.lastCards removeAllObjects];
            
        }break;
    }
}

-(void)gameEnd
{
    //计算总分数
}

 
-(void)clickHead:(id)sender//点击弹出头像层
{ 
    //    CGSize s = [[CCDirector sharedDirector] winSize];//经常用到 
    //    CGPoint p = ccp(s.width/2, 50);//经常用到
    //    // 创建4个动作
    //    id ac0=[CCScaleTo actionWithDuration:0.7 scale:0.9f];
    //    id ac1=[CCScaleTo actionWithDuration:0.5 scale:0.5f];
    //    id ac2 = [CCJumpTo actionWithDuration:2 position:ccp(150, 50) height:30 jumps:5];
    //    id ac3 = [CCJumpTo actionWithDuration:2 position:ccp(200, 250) height:30 jumps:5];
    //    [headMenu runAction:[CCSequence actions:ac0,ac1,ac2,ac3, nil]];
    
    //通过坐标判断是那个玩家头像被激活
    [_userName setHidden:YES];
    [_goldSum setHidden:YES];
    active_index=[sender tag];//保存激活玩家序号
    active_index=active_index-1;
    //    NSLog(@"wanjiawei :%d",active_index);
    layer_head=[HeadListLayer node];
    [self addChild:layer_head z:3 tag:21];
    //    NSLog(@"wanjiawei :%d",active_index);
     gameState=Pause;
    
}

-(void)updateHead:(NSString *)stringimg   //用于更新被选玩家头像
{
    gameState=Update;
    [_userName setHidden:NO];
    [_goldSum setHidden:NO];
    NSLog(@"%@",stringimg);
    if (stringimg!=NULL)
    {
        Player * pp=[playersList objectAtIndex:active_index];
        [pp  initWithFile:stringimg];
        [pp setScale:0.7f];
        
        [pp setAnchorPoint:CGPointMake(0, 0)];
        //    [pp setScale:0.5f];//小鸟
        //    [[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:active_index] setImage:[UIImage imageNamed:stringimg] forState:UIControlStateNormal];
        
        switch (active_index) {//重新定义坐标
            case 0:
            {
                [pp setPosition:CGPointMake(15.0f, 46.0f)];
                
            }
                break;
                
            case 1:
            {
                [pp setPosition:CGPointMake(422.0f, 180.0f)];
            }
                break;
                
            case 2:
            {
                
                [pp setPosition:CGPointMake(160.0f, 260.0f)];
            }
                break;
                
            case 3:
            {
                [pp setPosition:CGPointMake(16.0f, 180.0f)];
                
            }
                break;
                
                
        }
        
    }
  
    
    
}
 
//重写触摸协议里的方法
//-(void) registerWithTouchDispatcher { [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO]; }

//-(void) registerWithTouchDispatcher { [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES]; }
//触摸选牌
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{   
 
    
    NSLog(@" 主游戏界面触摸");
    //添加手势对象
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger num=[delegate.viewController.view gestureRecognizers].count;
    NSLog(@"shoushi个数为%d",num);
    gestureRecognizer1=[[delegate.viewController.view gestureRecognizers] objectAtIndex:2];
    gestureRecognizer2=[[delegate.viewController.view gestureRecognizers] objectAtIndex:3];
    gestureRecognizer3=[[delegate.viewController.view gestureRecognizers] objectAtIndex:0];
    gestureRecognizer4=[[delegate.viewController.view gestureRecognizers] objectAtIndex:1];
    
    if(gameState == Update)
    {
        CGPoint touchPoint = [touch locationInView:[touch view]];
        NSLog(@"x=%f,y=%f",touchPoint.x,touchPoint.y);
        firstPoint=touchPoint;//设定起点
        NSLog(@"x=%f,y=%f",firstPoint.x,firstPoint.y);
        
        //处理未被选中的牌
        if(touchPoint.y>227.0f && touchPoint.y<310.0f)
        {
            Player* playerTemp = [playersList objectAtIndex:0];

            //处理手牌中从第一张到最后一张
            for(int i=0; i<playerTemp.cardsOnHand.count; i++)
            {
                Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                if(touchPoint.x>(74.0f+i*27.0f) && touchPoint.x<(74.0f+(i+1)*27.0f)&& !cardTemp.isSelect)
                {
                    
                    playerTemp.selectCardsNum++;
                    cardTemp.isSelect = YES;
                    [cardTemp setPosition:CGPointMake(cardTemp.position.x, cardTemp.position.y+15.0f)];
                    [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                                     cardTemp.scale=0.63;
                    [playerTemp.selectCards addObject:cardTemp];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"];
                    //                    gestureRecognizer1.enabled=NO;
                    //                    gestureRecognizer2.enabled=NO;
                    //                    NSLog(@"关闭手势：%@",gestureRecognizer1);
                    return YES;
                }
                if(i == playerTemp.cardsOnHand.count-1)
                {
                    //处理手牌中最后一张
                    if(touchPoint.x>(74.0f+i*27.0f) && touchPoint.x<(74.0f+i*27.0f+70.0f) && !cardTemp.isSelect)
                    {
                        playerTemp.selectCardsNum++;
                        cardTemp.isSelect = YES;
                        [cardTemp setPosition:CGPointMake(cardTemp.position.x, cardTemp.position.y+15.0f)];
                        [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                        [playerTemp.selectCards addObject:cardTemp];
                        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"];
                        //                        gestureRecognizer1.enabled=NO;
                        //                        gestureRecognizer2.enabled=NO;
                        return YES;
                    }
                }
            }
            
        }
        
        //处理被选中的牌
        if(touchPoint.y>212.0f && touchPoint.y<295.0f)
        {
            Player* playerTemp = [playersList objectAtIndex:0];
            
            //处理手牌中从第一张到最后一张
            for(int i=0; i<playerTemp.cardsOnHand.count; i++)
            {
                Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                if(touchPoint.x>(74.0f+i*27.0f) && touchPoint.x<(74.0f+(i+1)*27.0f) && cardTemp.isSelect)
                {
                    
                    playerTemp.selectCardsNum--;
                    cardTemp.isSelect = NO;
                    [cardTemp setPosition:CGPointMake(cardTemp.position.x, cardTemp.position.y-15.0f)];
                    [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                    //                    cardTemp.scale=0.5;
                    [playerTemp.selectCards removeObject:cardTemp];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"]; 
                    //                    gestureRecognizer1.enabled=NO;
                    //                    gestureRecognizer2.enabled=NO;
                    return YES;
                }
                if(i == playerTemp.cardsOnHand.count-1)
                {
                    //处理手牌中最后一张
                    if(touchPoint.x>(74.0f+i*27.0f) && touchPoint.x<(74.0f+i*27.0f+70.0f) && cardTemp.isSelect)
                    {
                        playerTemp.selectCardsNum--;
                        cardTemp.isSelect = NO;
                        [cardTemp setPosition:CGPointMake(cardTemp.position.x, cardTemp.position.y-15.0f)];
                        [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                        [playerTemp.selectCards removeObject:cardTemp];
                        //                        gestureRecognizer1.enabled=NO;
                        //                        gestureRecognizer2.enabled=NO;
                        return YES;
                    }                    
                }
            }
        }
        gestureRecognizer1.enabled=YES;
        gestureRecognizer2.enabled=YES;
        gestureRecognizer3.enabled=YES;
        //        NSLog(@"启用手势：%@",gestureRecognizer1);
        return NO;
    }
    gestureRecognizer1.enabled=YES;
    gestureRecognizer2.enabled=YES;
    gestureRecognizer3.enabled=YES;    
    return NO;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"移动了");
    if (gameState==Update)
    {
        gestureRecognizer1.enabled=NO;
        gestureRecognizer2.enabled=NO;
        gestureRecognizer3.enabled=NO;
        secondPoint=[touch locationInView:[touch view]];
        float temp=secondPoint.x-firstPoint.x;
        if (temp>25.0||temp<-25.0)
        {
            [self ccTouchBegan:touch withEvent:event];
            
        }
    }
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"结束移动");
    if (gameState==Update)
    {
        gestureRecognizer1.enabled=YES;
        gestureRecognizer2.enabled=YES;
        gestureRecognizer3.enabled=YES;
    }    
}

-(void)clickShow:(id)sender//响应出牌按钮
{
    // NSLog(@"游戏状态：%@",gameState);
    Player *p0=[playersList objectAtIndex:0];
    
    if(p0.lastCards.count != 0)//对上次的出牌进行清零
    {
        for(int i=0; i<p0.lastCards.count; i++)
        {
            Card* cardTemp = [p0.lastCards objectAtIndex:i];
            cardTemp.visible = NO;
        }
    }
    [p0.lastCards removeAllObjects];
    
    if(gameState == Update&&p0.playerState==TakeTurn)//针对手势首先判断当前玩家是否为用户
    {
        Player* playerTemp = [playersList objectAtIndex:0];
//        [CardType compareCards:playerTemp.selectCards _tempCard:showCards];
        if(playerTemp.selectCards.count != 0)//需要加多一个判断出的牌合不合理，这是属于逻辑方面的内容
        {
            Boolean isRight,isRight2;
            if (playerTemp.isLastOne == YES)//出牌跟牌阶段判断牌是否合法
            {
                if ([CardType getCardType:playerTemp.selectCards] != INVALID)//出牌阶段判断是否符合牌型
                {
                    isRight = YES;
                }else{
                    isRight = NO;
                }
            }else{
                [CardType sortCards:playerTemp.selectCards];
                isRight = [CardType compareCards:playerTemp.selectCards _tempCard:showCards];//跟牌是否正确
            }
            //            NSLog(@"%d",isRight);
            isRight2 = YES;
            if (playerTemp.selectCards.count == 1 && playerTemp.needMaxCard == YES) //出单张顶大时
            {
                [CardType sortCards:playerTemp.cardsOnHand];
                Card * _card1 = [playerTemp.selectCards objectAtIndex:0];
                Card * _card2 = [playerTemp.cardsOnHand objectAtIndex:(playerTemp.cardsOnHand.count - 1)];
                if ([_card1 isSameCard:_card2]) {
                    isRight2 = YES;
                }else{
                    isRight2 = NO;
                }
            }
            
            if(((playerTemp.selectDiamodsThree && lastPos == -1) || (lastPos != -1)) && isRight == YES && isRight2 == YES)
            {
                [playerTemp.lastCards removeAllObjects];
                
                for(int i=0; i<playerTemp.selectCards.count; i++)
                {
                    Card* cardTemp = [playerTemp.selectCards objectAtIndex:i];
                    //                    cardTemp.scale=0.4;
                    
//                    [playerTemp.lastCards addObject:cardTemp];
                    
                    //用户打出的牌的摆放位置
                    [cardTemp setPosition:CGPointMake(202.0f+i*13.0f, 120.0f)];
                    
                    cardTemp.scale=0.42;
                    [cardTemp runAction:[CCScaleTo actionWithDuration:0.01 scale:0.43f]];
                    [self reorderChild:cardTemp z:1];
//                    [playerTemp.cardsOnHand removeObject:cardTemp];
                    [playerTemp.lastCards addObject:cardTemp];
                }
//////////////////////////报牌声音
                int cardType_temp=[CardType getCardType:playerTemp.selectCards];
                Card * cardTemp=[playerTemp.selectCards objectAtIndex:0];
                int num=cardTemp.cardNum;
                int num_ran=rand()%4+1;//随机数字

                NSString * str;
                switch (cardType_temp)
                {
                    case 0:
                        break;
                    case 1://单张
                        str=[NSString stringWithFormat:@"./audio/single/%d.wav",num];
                        break;
                    case 2://对
                        str=[NSString stringWithFormat:@"./audio/double/dui%d.wav",num];
                        break;
                    case 3://三张
                        str=[NSString stringWithFormat:@"./audio/sange.wav"];
                        break;
                    case 4://杂顺
                    {
                         NSLog(@"%d",showCards.count);
                        if (showCards.count==0)
                        {
                            str=[NSString stringWithFormat:@"./audio/shunzi.wav"];
                            
                        }
                        else
                        {
                            str=[NSString stringWithFormat:@"./audio/dani%d.wav",num_ran];
                        }
                    }
                        break;
                    case 5://同花
                        str=[NSString stringWithFormat:@"./audio/shunzi.wav"]; 
                        break;
                    case 6://三代二
                        str=[NSString stringWithFormat:@"./audio/sandaiyidui.wav"];
                        break;
                    case 7://四带一
                    {
                        NSLog(@"%d",showCards.count);

                        if (lastPos==0) 
                        {
                         str=[NSString stringWithFormat:@"/audio/sidaiyi.wav"];
                        }
                        else
                        {
                         str=[NSString stringWithFormat:@"./audio/dani%d.wav",num_ran];
                        }
                        
                    }
                        break;
                    case 8://同花顺
                    {
                        NSLog(@"%d",showCards.count);
                        if (player[1].selectCards.count==0&&player[2].selectCards.count==0&&player[3].selectCards.count==0)
                        {
                            str=[NSString stringWithFormat:@"./audio/tonghuashun.wav"];
                            
                        }
                        else
                        {
                            str=[NSString stringWithFormat:@"./audio/dani%d.wav",num_ran];
                        }
                    }
                        break;
                    default:
                        break;
                }
                [[SimpleAudioEngine sharedEngine] playEffect:str];
                [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/show_card.wav"];
////////////////////////报牌音效结束

 
                [playerTemp removeCardFromOnHand:playerTemp.cardsOnHand object:playerTemp.lastCards];
                
/////牌数报警,当牌数小于两张时
                if (currentPlayer.cardsOnHand.count==2) 
                {
                    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/baojing2.wav"];
                }
                if (currentPlayer.cardsOnHand.count==1)
                {
                    [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/baojing1.wav"];
                }
//////////
                if (playerTemp.selectCards.count != 0) {
                    [CardType sortCards:playerTemp.selectCards];
                    
                    if (userShowCards == nil) {
                        userShowCards = [[NSMutableArray alloc]init];
                    }
                    [userShowCards removeAllObjects];
                    for (int k = 0; k < playerTemp.selectCards.count; k++) {
                        Card * _card = [[Card alloc]init];
                        _card = [playerTemp.selectCards objectAtIndex:k];
                        [userShowCards addObject:_card];
                        [_card release];
                    }
//                    showCards = playerTemp.selectCards;
                    showCards = userShowCards;
                    playerTemp.isLastOne =YES;
                    NSLog(@"%d",showCards.count);
                    for (int i = 1; i < 4; i++) {
                        Player * _player = [playersList objectAtIndex:((playerTemp.playerPos+i)%4)];
                        _player.isLastOne = NO;
                    }
//                    NSLog(@"%d",showCards.count);
                    for (int i = 1; i < 4; i++) {
                        Player * _player = [playersList objectAtIndex:((playerTemp.playerPos+i)%4)];
                        _player.isLastOne = NO;
                    }
                }
                [playerTemp.selectCards removeAllObjects];
//                playerTemp.selectCardsNum =0;
//                NSLog(@"%d",showCards.count);

                [playerTemp setOnHandCardsNum:playerTemp.cardsOnHand.count];
                
                for(int i=0; i<playerTemp.onHandCardsNum; i++)//调整剩余牌
                {
                    Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                    [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                    [cardTemp setPosition:CGPointMake(74.0f+i*27.0f, 10.0f)];
                }
                
                lastPos = 0;
                
                [player0CardNum setString:[NSString stringWithFormat:@"%d",currentPlayer.cardsOnHand.count]];
                
                if(![self testEnd])
                {
                    currentPlayer = [playersList objectAtIndex:1];
                    playerTemp.playerState = OffTurn;
                    currentPlayer.playerState = TakeTurn;
                }
                else
                {
                    NSNumber * lastWinner1 = [NSNumber numberWithInt:(currentPlayer.playerPos + 1)];
                    NSUserDefaults * winner1 = [NSUserDefaults standardUserDefaults];
                    [winner1 setObject:lastWinner1 forKey:@"tanke"];
                    [self calculateScore];
                }
                
                showMenu.visible = NO;
                resetMenu.visible=NO;
                passMenu.visible = NO;
                
            }
            else
            {
                [playerTemp.selectCards removeAllObjects];
                playerTemp.selectCardsNum =0;
                
                [playerTemp setOnHandCardsNum:playerTemp.cardsOnHand.count];
                for(int i=0; i<playerTemp.onHandCardsNum;i++)
                {
                    Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                    [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                    [cardTemp setPosition:CGPointMake(74.0f+i*27.0f, 10.0f)];
                    [cardTemp setIsSelect:NO];
                }
                [self drawNotice]; 
                
                gameState = Notice;
            }
        }
        else
        {
            [self drawNotice_noCards];
//            gameState=Pause; 
//            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"亲！你未选择任何牌" delegate:self
//                                                cancelButtonTitle:@"ok" otherButtonTitles: nil ];
//            alert.tag=3;
//            [alert show];
//            [alert release];
            return;
        }
    }
    else
    {
        [self drawNotice_notYourturns];
//        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"亲！没轮到你出牌" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
    }
}
-(void)clickReset:(id)sender
{
    if(gameState==Update)
    {
        Player* playerTemp = [playersList objectAtIndex:0];
        if (playerTemp.selectCards.count!=0)
        {
            for(int i=0; i<playerTemp.onHandCardsNum;i++)
            {
                Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                [cardTemp setPosition:CGPointMake(74.0f+i*27.0f, 10.0f)];
                [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                [cardTemp setIsSelect:NO];
                [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"];
                
            }

        }
//        [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/touch_card.wav"];
        
        [playerTemp.selectCards removeAllObjects];
        playerTemp.selectCardsNum =0;
        [playerTemp setOnHandCardsNum:playerTemp.cardsOnHand.count];
    }
    
}


-(void)sortCard//排序 先按花色再按点数
{
    if (gameState==Update)
    { 
        
        Player * playerTemp=[playersList objectAtIndex:0];
        Card * cardTem ;//中间牌
        //首先重置
        if (playerTemp.selectCards.count!=0) 
        {
            [self clickReset:resetMenu];
            
        }
        if (change) //未排序
        {
            
            NSMutableArray *diamand=[[NSMutableArray alloc] init];
            NSMutableArray *club=[[NSMutableArray alloc] init];
            NSMutableArray *heart=[[NSMutableArray alloc] init];
            NSMutableArray *spade=[[NSMutableArray alloc] init];
            
            for (int i=0; i<playerTemp.cardsOnHand.count; i++) //按花色分类
            {
                cardTem=[playerTemp.cardsOnHand objectAtIndex:i];
                
                switch (cardTem.suit)
                {
                    case 1:
                        [diamand addObject:cardTem];
                        break;
                    case 2:
                        [club addObject:cardTem];
                        break;
                    case 3:
                        [heart addObject:cardTem];
                        break;
                    case 4:
                        [spade addObject:cardTem];
                        break;
                }
            }
            
            //清空手中牌
            playerTemp.onHandCardsNum=0;
            [playerTemp.cardsOnHand removeAllObjects];
            
            //依次添加到玩家牌中
            for (int i=0; i<diamand.count; i++)
            {
                [playerTemp.cardsOnHand addObject:[diamand objectAtIndex:i]];
            }
            for (int i=0; i<club.count; i++)
            {
                [playerTemp.cardsOnHand addObject:[club objectAtIndex:i]];
            }
            for (int i=0; i<heart.count; i++)
            {
                [playerTemp.cardsOnHand addObject:[heart objectAtIndex:i]];
            }
            for (int i=0; i<spade.count; i++)
            {
                [playerTemp.cardsOnHand addObject:[spade objectAtIndex:i]];
            }
            
            change=NO;//设置标志位1排序
            
            //            NSLog(@"排序后牌数为%d",playerTemp.cardsOnHand.count);
            
            
            [spade release];
            [heart release];
            [club release];
            [diamand release];
            
        } 
        else
        {//已排序后会直接执行点数排序，两种交替进行
            NSMutableArray *temp_player=[[NSMutableArray alloc] init];//用于第二次排序保存当前玩家手中牌
            //             NSLog(@"第二次牌数为%d",playerTemp.cardsOnHand.count);
            
            for (int i=0; i<playerTemp.cardsOnHand.count; i++) 
            {
                cardTem=[playerTemp.cardsOnHand objectAtIndex:i];
                [temp_player addObject:cardTem];
            }
            
            //清空手中牌
            playerTemp.onHandCardsNum=0;
            [playerTemp.cardsOnHand removeAllObjects];
            
            [self sortCardNum: temp_player player:playerTemp];
            
            change=YES;//设置标志位2排序      
            [temp_player release];
            
        }
        
        //清空手中牌
        
        [playerTemp setOnHandCardsNum:playerTemp.cardsOnHand.count];
        
        for(int i=0; i<playerTemp.onHandCardsNum;i++)//重新显示
        {
            
            cardTem = [playerTemp.cardsOnHand objectAtIndex:i];
            cardTem.visible=YES;
            [cardTem setPosition:CGPointMake(74.0f+i*27.0f, 10.0f)];
            
            [self reorderChild:cardTem z:1];
            [[SimpleAudioEngine sharedEngine] playEffect:@"./audio/show_card.wav"];
            id action1=[CCMoveTo actionWithDuration:0.3 position:CGPointMake(74.0f, 10.0f)];
            id action2=[CCMoveTo actionWithDuration:0.3 position:CGPointMake(74.0+i*27.0, 10.0f)];
            [cardTem runAction:[CCSequence actions:action1,action2, nil]];
            
        }
        //        NSLog(@"成功");
        
    }   
    
    
    
}
-(void)sortCardNum:(NSMutableArray *)array  player:(Player *)Player//按点数排序
{
    
    if (array.count)
    {
        
        NSMutableArray * tempArray=[[NSMutableArray alloc]init ];
        
        Card * card1;
        Card * cardT;//保存最大的牌且为被选中过
        
        int index =0;
        
        for (int i=0; i<array.count&&index>=0; i++)//按点数排序
        {      
            index=-1;
            Boolean  only=YES;
            Boolean   endFind=NO;
            for (int i=0; i<array.count&&(endFind==NO); i++) //寻找首个未被标志的作为参照牌
            {
                if ([[array objectAtIndex:i] isTaked]==NO)
                {
                    cardT=[array objectAtIndex:i];
                    index=i;
                    endFind=YES;
                }
                
            }
            
            for (int j=0; j<array.count&&index>=0; ++j)//比较需找最大牌，放入cardT
            {
                card1=[array objectAtIndex:j];
                if (card1.isTaked==NO)
                {
                    if (!((card1.cardNum==cardT.cardNum)&&(card1.suit==cardT.suit)))//不是同一张牌
                    {
                        
                        if (card1.cardNum>=cardT.cardNum)
                        {
                            if (card1.cardNum==cardT.cardNum&&card1.suit>cardT.suit) 
                            {
                                cardT=[array objectAtIndex:j];
                                index=j;
                            }
                            else
                            {
                                cardT=[array objectAtIndex:j];
                                index=j;
                                
                            }
                            
                            
                        }   
                        only=NO;//找到另一张可比较的牌
                    }
                }
                
            }            
            
            //            NSLog(@"第%d局最大为：%d",i,cardT.cardNum);
            if (index>=0&& only==NO) 
            {
                [[array objectAtIndex:index] setIsTaked:YES];//标志已添加
                [tempArray  addObject:cardT];//添加当前最大牌
            }
            
            
            if (only)//如果只剩一个元素，直接添加，不再比较
            {
                //                NSLog(@"%d",index);
                [[array objectAtIndex:index] setIsTaked:YES];
                [tempArray addObject:cardT];
                index=-1;//循环查找结束
            }
            
        }//排序结束
        
        
        for (int i=tempArray.count-1; i>=0; i--) //依次添加到玩家手中
        {
            [[tempArray objectAtIndex:i] setIsTaked:NO];
            cardT =[tempArray objectAtIndex:i] ;
            [Player.cardsOnHand addObject:cardT];
            //                NSLog(@"添加成功%d",cardT.cardNum);
            
        }
        
        
        [tempArray release];     
    }
}


-(void)clickPass:(id)sender
{
    if(gameState == Update&&currentPlayer.playerPos==0)
    {
///////pass报牌音效
        int num=rand()%4+1;
        NSString * str=[NSString stringWithFormat:@"./audio/buyao%d.wav",num];
        [[SimpleAudioEngine sharedEngine] playEffect:str];
///////
        Player* playerTemp = [playersList objectAtIndex:0];
        if( (playerTemp.hasDiamodsThree && lastPos == -1) )
        {
            [self drawNotice_neverGiveup];
//            UIAlertView  * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"不能放弃牌局" delegate:self cancelButtonTitle:@"知道" otherButtonTitles:nil ];
//            alert.tag=4;
//            [alert show];
//            [alert release];
        }
        else
        {
            //非第一局
            if(lastPos == 0)
            {
                [playerTemp.selectCards removeAllObjects];
                playerTemp.selectCardsNum =0;
                
                [playerTemp setOnHandCardsNum:playerTemp.cardsOnHand.count];
                for(int i=0; i<playerTemp.onHandCardsNum;i++)
                {
                    Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                    [cardTemp setPosition:CGPointMake(74.0f+i*27.0f, 10.0f)];
                    [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                    [cardTemp setIsSelect:NO];
                }
                passlabel0.visible=NO;
            }
            else
            {
                if (showCards.count == 1 && playerTemp.needMaxCard == YES) //出单张顶大时
                {
                    [CardType sortCards:playerTemp.cardsOnHand];
                    Card * _card1 = [showCards objectAtIndex:0];
                    Card * _card2 = [playerTemp.cardsOnHand objectAtIndex:(playerTemp.cardsOnHand.count - 1)];
                    if ([_card1 compareLess:_card2]) {
                        [self drawNotice_NeedMaxCard]; //单张顶大提示
                    }else{
//                        [playerTemp.lastCards removeAllObjects];
                        if(playerTemp.lastCards.count != 0)
                        {
                            for(int i=0; i<playerTemp.lastCards.count; i++)
                            {
                                Card* cardTemp = [playerTemp.lastCards objectAtIndex:i];
                                cardTemp.visible = NO;
                            }
                        }
                        [playerTemp.lastCards removeAllObjects];
                        [playerTemp.selectCards removeAllObjects];
                        playerTemp.selectCardsNum = 0;
                        
                        for(int i=0; i<playerTemp.onHandCardsNum; i++)
                        {
                            Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                            cardTemp.isSelect = NO;
                            [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                            [cardTemp setPosition:CGPointMake(74.0f+i*27.0f, 10.0f)];
                        }
                        
                        currentPlayer = [playersList objectAtIndex:1];
                        playerTemp.playerState = OffTurn;
                        currentPlayer.playerState = TakeTurn;
                        
                        showMenu.visible = NO;
                        resetMenu.visible=NO;
                        passMenu.visible = NO;
                    }
                }
                else
                {
                    if(playerTemp.lastCards.count != 0)
                    {
                        for(int i=0; i<playerTemp.lastCards.count; i++)
                        {
                            Card* cardTemp = [playerTemp.lastCards objectAtIndex:i];
                            cardTemp.visible = NO;
                        }
                    }
                    [playerTemp.lastCards removeAllObjects];

                    [playerTemp.selectCards removeAllObjects];
                    playerTemp.selectCardsNum = 0;
                    
                    for(int i=0; i<playerTemp.onHandCardsNum; i++)
                    {
                        Card* cardTemp = [playerTemp.cardsOnHand objectAtIndex:i];
                        cardTemp.isSelect = NO;
                        [cardTemp runAction:[CCScaleTo actionWithDuration:0.07 scale:0.63f]];
                        [cardTemp setPosition:CGPointMake(74.0f+i*27.0f, 10.0f)];
                    }
                    
                    currentPlayer = [playersList objectAtIndex:1];
                    playerTemp.playerState = OffTurn;
                    currentPlayer.playerState = TakeTurn;
                    
                    showMenu.visible = NO;
                    resetMenu.visible=NO;
                    passMenu.visible = NO;
                }
                passlabel0.visible=YES;
            }
//            passlabel0.visible=YES;
        }
    }
    
}

-(void)clickPause:(id)sender
{
    _userName.hidden = YES;
    _goldSum.hidden = YES;
    pauseMenu.isTouchEnabled=NO;
    //游戏进入停止状态
    gameState = Menu;    
    //显示菜单图层
    menu_bg.visible  = YES;
    mainMenu.visible = YES;
    menu_bg.position = CGPointMake(400.0f, 160.0f);
    mainMenu.position= CGPointMake(400.0f, 160.0f);
    [menu_bg runAction:[CCMoveTo actionWithDuration:0.1f position:CGPointMake(240.0f, 160.0f)]];
    [mainMenu runAction:[CCMoveTo actionWithDuration:0.1f position:CGPointMake(240.0f, 160.0f)]];
    
    //添加手势对象
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger num = [delegate.viewController.view gestureRecognizers].count;
    NSLog(@"shoushi个数为%d",num);
    gestureRecognizer1 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:2];
    gestureRecognizer2 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:3];
    gestureRecognizer3 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:0];
    gestureRecognizer4 = [[delegate.viewController.view gestureRecognizers] objectAtIndex:1];
     
    gestureRecognizer1.enabled = NO;
    gestureRecognizer2.enabled = NO;
    gestureRecognizer3.enabled = NO;
    gestureRecognizer4.enabled = NO;
    NSLog(@"菜单关闭手势");
    
    //关闭头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4) 
        {
            temphead.enabled=NO;
        }
    }
}

-(void)clickBackGame:(id)sender
{
    pauseMenu.isTouchEnabled=YES;
    mainMenu.visible=NO;
    menu_bg.visible=NO;
    gestureRecognizer1.enabled=YES;
    gestureRecognizer2.enabled=YES;
    gestureRecognizer3.enabled=YES;
    gestureRecognizer4.enabled=YES;
    gameState=Update;
    _userName.hidden = NO;
    _goldSum.hidden = NO;
    
    //开启头像接受事件能力
    int a=(int)[[[CCDirector sharedDirector] openGLView].subviews count];
    NSLog(@"a=%d",a);
    UIButton *temphead;
    for (int i=0; i<a; i++)
    {
        temphead=[[[CCDirector sharedDirector] openGLView].subviews objectAtIndex:i];
        NSLog(@"ccc===%@",temphead);
        if (temphead.tag==1||temphead.tag==2||temphead.tag==3||temphead.tag==4) 
        {
            temphead.enabled=YES;
        }
    }
}

-(void)clickNewGame:(id)sender
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"亲！你确定要逃跑吗？逃跑将会扣除100个金币哦！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    alert.tag=1;
    [alert show];
    [alert release];
}

-(void)escapeScore  //逃跑扣分
{
    NSUserDefaults * gameEnd1 = [NSUserDefaults standardUserDefaults];
    [gameEnd1 removeObjectForKey:@"allScore"];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInB  transitionWithDuration:0.1f scene:[ GameMainViewContorller scene]] ];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1) {// 逃跑
        if(buttonIndex==0)
        {
            [_userName setHidden:YES];
//            [_userName release];
            [_goldSum setHidden:YES];
//            [_userName release];
            gameState=Escape;
            [self escapeScore];
        }
    }
    if (alertView.tag==2) {//验证牌型
        if(buttonIndex==0)
        {
            gameState=Update;
        }
    }
    if (alertView.tag==3) {//未选牌提示
        
        if(buttonIndex==0)
        {
            gameState=Update;
        }
    }
    if (alertView.tag==4) {//不能放弃牌局
        
        if(buttonIndex==0)
        {
            gameState=Update;
        }
    }    
}

-(void)clickSetVoice:(id)sender
{
//    mainMenu.isTouchEnabled=NO;
    if (added==NO)
    {
        layer =[SetAudioLayer node];
        [self addChild:layer z:3 tag:20];
        added=YES;
    }
    else
    {
        layer.visible=YES;
        layer.view.hidden=NO;
        [layer onEnter];
    }
}

-(void)clickRegular:(id)sender
{
    regular=[Regular node];
    [self addChild:regular z:3];

}

-(void)clickRank
{
     if (added_rank==NO)
    {
        layerRanking=[RankingList node];
        [self addChild:layerRanking z:3];
        added_rank=YES;
    }
    else
    {
        layerRanking.visible=YES;
        [layerRanking.scrollViewRanking setHidden:NO];
    }
}
//-(void)changeMainMetouch
//{
//    mainMenu.isTouchEnabled=YES;
//
//}

//注册事件
- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:2 swallowsTouches:NO];
	[super onEnter];
}

//注销事件
- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

- (void) dealloc
{  
	// don't forget to call "super dealloc"
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *gestureArray=[delegate.viewController.view gestureRecognizers];
    NSInteger num=gestureArray.count;
    //    NSLog(@"shoushi个数为%d",num);
    if (gameState!=Continue)
    {
        for (int i=0; i<num; i++)
        {
            UISwipeGestureRecognizer *ges=[gestureArray objectAtIndex:i];
            [delegate.viewController.view removeGestureRecognizer:ges]; 
            //            NSLog(@"ges:wei%@",ges);
        }
    }
    if (gameState==Continue)
    {
        for (int i=0; i<4; i++)
        {
            UISwipeGestureRecognizer *ges=[gestureArray objectAtIndex:i];
            [delegate.viewController.view removeGestureRecognizer:ges];  
//            NSLog(@"ges:wei%@",ges);
        }
    }
//    NSInteger a=[[[CCDirector sharedDirector] openGLView].subviews count];
//    NSLog(@"a=%d",a);
  
    NSLog(@"手势内存释放了");
    [super dealloc];
    
    
}
@end
