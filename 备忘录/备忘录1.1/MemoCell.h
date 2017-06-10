//
//  MemoCell.h
//  备忘录1.1
//
//  Created by yinquan on 16/11/8.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemoModel;

@interface MemoCell : UITableViewCell
@property (nonatomic, strong)MemoModel *memo;
// 自定义cell
+ (instancetype)memoWithTableView:(UITableView *)tableView;

@end
