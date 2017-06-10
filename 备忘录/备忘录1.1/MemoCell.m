//
//  MemoCell.m
//  备忘录1.1
//
//  Created by yinquan on 16/11/8.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import "MemoCell.h"
#import "MemoModel.h"
@interface MemoCell ()

@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, weak) UILabel *parCont;

@end

@implementation MemoCell

#pragma mark - 重写单元格的initWithStyle:方法
+ (instancetype)memoWithTableView:(UITableView *)tableView {
    static NSString *ID = @"memo_cell";
    MemoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MemoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建3个子控件
        // 标题
        UILabel *title = [[UILabel alloc] init];
        [self.contentView addSubview:title];
        self.title = title;
        
        // 时间
        UILabel *time = [[UILabel alloc] init];
        [self.contentView addSubview:time];
        self.time = time;
        
        // 内容
        UILabel *partCont = [[UILabel alloc] init];
        [self.contentView addSubview:partCont];
        self.parCont = partCont;
    }
    return self;
}
#pragma mark - 重写weibo属性的set方法
- (void)setMemo:(MemoModel *)memo {
    _memo = memo;
    
    // 设置数据
    MemoModel *model = self.memo;
    self.title.text = model.title;
    self.time.text = model.time;
    self.parCont.text = model.partCont;
    
    // 设置frame
    self.title.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width - 30, 22);
    
    self.time.frame = CGRectMake(15, 28, 50, 22);
    // 设置字体和字号
    [self.time setFont:[UIFont systemFontOfSize:14]];
    // 设置字体颜色
    [self.time setTextColor:[UIColor darkGrayColor]];
    
    self.parCont.frame = CGRectMake(80, 28, [UIScreen mainScreen].bounds.size.width - 95, 22);
    [self.parCont setFont:[UIFont systemFontOfSize:14]];
    [self.parCont setTextColor:[UIColor lightGrayColor]];
    
}

@end
