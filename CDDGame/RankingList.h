//
//  RankingList.h
//  CDDGame
//
//  Created by  on 12-8-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CD2Database.h"

@class PlayGameView;
@interface RankingList : CCNode {
    
    CD2Database * database;
    CCSprite * rankinglist_on;
    CCSprite * rankinglist_off;
    //滚动试图
    UIScrollView * scrollViewRanking;
    
    CCMenu * sureButton1;
    //第一名
    CCLabelTTF * _name1;
    CCLabelTTF * _score1;
    CCMenuItemLabel * name1;
    CCMenuItemLabel * userScore1;
    CCMenu * rankingName1;
    CCMenu * rankingScore1;
    //第二名
    CCLabelTTF * _name2;
    CCLabelTTF * _score2;
    CCMenuItemLabel * name2;
    CCMenuItemLabel * userScore2;
    CCMenu * rankingName2;
    CCMenu * rankingScore2;
    //第三名
    CCLabelTTF * _name3;
    CCLabelTTF * _score3;
    CCMenuItemLabel * name3;
    CCMenuItemLabel * userScore3;
    CCMenu * rankingName3;
    CCMenu * rankingScore3;
    //第四名
    CCLabelTTF * _name4;
    CCLabelTTF * _score4;
    CCMenuItemLabel * name4;
    CCMenuItemLabel * userScore4;
    CCMenu * rankingName4;
    CCMenu * rankingScore4;
    //第五名
    CCLabelTTF * _name5;
    CCLabelTTF * _score5;
    CCMenuItemLabel * name5;
    CCMenuItemLabel * userScore5;
    CCMenu * rankingName5;
    CCMenu * rankingScore5;
    //第六名
    CCLabelTTF * _name6;
    CCLabelTTF * _score6;
    CCMenuItemLabel * name6;
    CCMenuItemLabel * userScore6;
    CCMenu * rankingName6;
    CCMenu * rankingScore6;
    //第七名
    CCLabelTTF * _name7;
    CCLabelTTF * _score7;
    CCMenuItemLabel * name7;
    CCMenuItemLabel * userScore7;
    CCMenu * rankingName7;
    CCMenu * rankingScore7;
    //第八名
    CCLabelTTF * _name8;
    CCLabelTTF * _score8;
    CCMenuItemLabel * name8;
    CCMenuItemLabel * userScore8;
    CCMenu * rankingName8;
    CCMenu * rankingScore8;
}

@property (retain)UIScrollView * scrollViewRanking;


@end
