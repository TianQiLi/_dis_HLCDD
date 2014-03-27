//
//  PlayGameView.h
//  CDDGame
//
//  Created by  on 12-8-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CD2Database.h"
#import "Player.h"
#import "Card.h"
#import "RememberCard.h"
#import "Enumeration.h"
#import "HeadListLayer.h"
#import "SetAudioLayer.h"
#import "Regular.h"
#import "RankingList.h"
#import "PositionGetter.h"

@interface PlayGameView : CCLayer<UIAlertViewDelegate,CCTargetedTouchDelegate,UIGestureRecognizerDelegate,EXParentDelegate,HeadParentDelegate> {
    
    //定位器
    PositionGetter * positionGetter;
    
    //读取数据库信息
    NSString * userName;
    CD2Database * dataBase;
    int pointOrTurns;  //按分数或局数
    int square3Select;       //是否方块3先出
    int selectMaxSwitch;     //是否顶大
    
    
    //记录分数
    long int score;
    long int displayScore;
    
    //记录每个玩家没轮次的总分
    int sumScore0;
    int sumScore1;
    int sumScore2;
    int sumScore3;
    
    //显示游戏时间
    ccTime time;
    CCLabelTTF*   labletime;
    CCSprite * guideIndex;
    
    Player  *     currentPlayer;
    GameState       gameState;
    NSMutableArray* playersList;
    NSMutableArray * cardsList;
    
    
    int   lastPos;
    
    int scoreCard0,scoreCard1,scoreCard2,scoreCard3;//玩家当局分数
    int  totalScore0;
    int  totalScore1;
    int  totalScore2;
    int  totalScore3;
    
    ///剩余牌数显示
    CCLabelTTF*   player0CardNum;
    CCLabelTTF*   player1CardNum;
    
    CCLabelTTF*   player2CardNum;
    CCLabelTTF*   player3CardNum;
    CCLabelTTF*   player0TotalScore;
    //触摸
    UISwipeGestureRecognizer*  gestureRecognizer1;
    UISwipeGestureRecognizer* gestureRecognizer2;
    UISwipeGestureRecognizer*  gestureRecognizer3;
    UISwipeGestureRecognizer* gestureRecognizer4;
    
    GestureDir gestureDir;
    CGPoint firstPoint;
    CGPoint secondPoint;
    
    CCMenu *      pauseMenu ;
    CCMenu *      noticeMenu;
    CCMenu*       showMenu;
    CCMenu*       resetMenu;
    CCMenu*       passMenu;
    CCMenu *      scoreMenu;
    BOOL change;//判读是否已经排序
    
    //结束界面
    UIAlertView * endAlert;
    UIScrollView * scrollView;//添加滚动试图
    UIScrollView * scrollView2;
    
    //菜单界面
    CCMenu * mainMenu  ;
    CCMenuItemImage * menu_bg;
    
    CCMenu *cardRemember;
    CCMenuItemImage *cardRememberBackgroud;
    
    
    //提示
    CCMenu * alert_menu;            //不合符规则
    CCMenu * alert_menu_needMaxCard;//需要顶大
    CCMenu * alert_menu_noCards;    //未选择任何牌
    CCMenu * alert_menu_notYourturn;//为轮到出牌
    CCMenu * alert_menu_neverGiveup;//不能放弃牌局
    
 
    //头像选择功能
    int active_index;//保存激活玩家序号
    UIButton *headbutton ;//头像点击按钮
    HeadListLayer   * layer_head;
    //音乐设置
    SetAudioLayer * layer;
    BOOL  added;//标记层是否已经添加,初始化为no
    //玩家pass 标签显示
    CCLabelTTF * passlabel0;
    CCLabelTTF * passlabel1;
    CCLabelTTF * passlabel2;
    CCLabelTTF * passlabel3;
    //管理所出的牌
    NSMutableArray * showCards;
    NSMutableArray *rememberCards;
    NSMutableArray *cards2;
    NSMutableArray *tempRemember;
    NSMutableArray *rememberCards2;
    
    //管理玩家
    Player * player[4];
    
    //记录庄家
    NSNumber * lastWinner;
    NSUserDefaults * winner;
    NSMutableArray * userShowCards;
    
    //记录分数的列表
    NSMutableArray * scoreList;
    
 
    NSMutableArray * scoreShow;
    
    //查看规则
    Regular *regular;
    
    //积分表
    RankingList *  layerRanking;
    BOOL  added_rank;//标记规则层是否已经添加,初始化为no
    
    //显示姓名和总金币数
    UILabel * _userName;
    UILabel * _goldSum;
    UIButton *buttonRememberCard;
    CCSprite *rememberCard1;
    RememberCard *tempRememberCard2;
    CCSprite *tempcard;
    
    NSMutableArray * spritedelRememberCard;
    
    CCMenuItemImage* back ;
    CCMenuItemImage* new1 ;
    CCMenuItemImage* set ;
    CCMenuItemImage* regularBtn ;
    CCMenuItemImage* rank;
    NSArray * imageArray;
    CGPoint centerPosition;
    CGPoint centerPosition1;
    NSString * typeDe;
}



@property(retain) NSMutableArray* playersList;
@property(retain) NSMutableArray * cardsList;
@property(assign) UISwipeGestureRecognizer*  gestureRecognizer1;
@property(assign) UISwipeGestureRecognizer*  gestureRecognizer2;
@property(assign) UISwipeGestureRecognizer*  gestureRecognizer3;
@property(retain) UISwipeGestureRecognizer*  gestureRecognizer4;
@property(retain) NSMutableArray * showCards;
@property(retain) NSMutableArray *rememberCards;
@property (retain)CCMenu * mainMenu;
+(CCScene*)scene;
-(void)initCardsList;
-(void)distributeCards;
-(void)initBackCardsList;
-(void)initPlayersList;
-(void)playerTakeTurn;
-(Boolean)testEnd;
-(void)calculateScore;
-(void)drawPassLabel;
-(void)gameUpdate;
-(void)drawNotice;
-(void)drawPause;
//-(void)drawUpdate;//出牌/pass/重置按钮
-(void)drawMenu;
-(void)drawScore;
-(void)clickContinueGame:(id)sender;
-(void)gameEnd;

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
-(void)clickShow:(id)sender;
-(void)clickReset:(id)sender;
-(void)clickPass:(id)sender;
-(void)escapeScore;//逃跑扣分
-(void)sortCard;
-(void)sortCardNum:(NSMutableArray *)array   player:(Player *)Player;
-(void)clickPause:(id)sender;
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
//头像选择功能实现
-(void)drawHeadBtn;
-(void)clickHead:(id)sender;
-(void)updateHead:(NSString *)stringimg ;
- (void) determineMaxCards;
- (int) calculate:(NSMutableArray *)scoreTemp index:(int)n;
 

-(void)resetCards:(Player *)playerTemp;
-(void)freeGestureR;//释放手势
-(void)setMainMenu;
-(void)playEffect;
-(void)closeGestureAndHeadEnable;
-(void)showSpot;//广告
-(CGPoint)switchCGPoint:(CGPoint)point;

- (void) scoreShow;//当局结束后分数小计显示//积分显示
@end