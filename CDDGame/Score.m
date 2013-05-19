//
//  Score.m
//  CDDGame
//
//  Created by  on 12-9-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Score.h"


@implementation Score

- (id)init
{
    if (self = [super init]) {
        scoreShow = [[NSMutableArray alloc]init];
        NSUserDefaults * gameEnd = [NSUserDefaults standardUserDefaults];
        scoreList = [gameEnd objectForKey:@"allScore"];
        NSLog(@"%d",scoreList.count);
        NSString * temp;
        for (int i = 0; i < scoreList.count; i = i+4) {
            int index1 = [[scoreList objectAtIndex:i+0] intValue];
            int index2 = [[scoreList objectAtIndex:i+1] intValue];
            int index3 = [[scoreList objectAtIndex:i+2] intValue];
            int index4 = [[scoreList objectAtIndex:i+3] intValue];
            int j = 0;
            temp = [NSString stringWithFormat:@"%d    %d     %d     %d    %d", j++, index1,index2, index3, index4];
            [scoreShow addObject:temp];
        }
        int count = scoreShow.count;
        NSLog(@"name : %d",count);
        nameTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
        CGAffineTransform rotation = CGAffineTransformMakeRotation(1.57079633);
        [nameTable setTransform:rotation];
        [nameTable setFrame:CGRectMake(30, 60, 230, 380)];
        nameTable.delegate = (id)self;
        nameTable.dataSource = (id)self;
        [nameTable setHidden:NO];
        [nameTable autorelease];
        [[[[CCDirector sharedDirector]openGLView]window]addSubview:nameTable];

    }
    return self;
}

//放回可选项的数目
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return scoreShow.count;
    
}

//设置没项的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
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
@end
