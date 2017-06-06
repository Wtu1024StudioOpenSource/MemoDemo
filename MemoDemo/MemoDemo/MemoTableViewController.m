//
//  MemoTableViewController.m
//  MemoDemo
//
//  Created by Gin on 16/6/28.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import "MemoTableViewController.h"
#import "DetailViewController.h"
#import "MemoModel.h"

@interface MemoTableViewController () <DetailViewControllerDelegate>

/**没有数据提示的label*/
@property (weak, nonatomic) UILabel *noDataHintLb;
/**存放备忘录*/
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation MemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"备忘录";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(createBtnClick)];
    
    UILabel *nodataHintLb = [[UILabel alloc] init];
    nodataHintLb.font = [UIFont systemFontOfSize:25.0f];
    nodataHintLb.textColor = [UIColor darkGrayColor];
    nodataHintLb.text = @"您还未创建备忘录";
    // 根据内容自适应尺寸
    [nodataHintLb sizeToFit];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat lbW = nodataHintLb.frame.size.width;
    CGFloat lbH = nodataHintLb.frame.size.height;
    CGFloat lbX = (screenWidth - lbW) / 2;
    CGFloat lbY = (screenHeight - lbH) / 2;
    
    nodataHintLb.frame = CGRectMake(lbX, lbY - 64, lbW, lbH);
    _noDataHintLb = nodataHintLb;
    [self.view addSubview:_noDataHintLb];
    
    _dataArr = [NSMutableArray array];
    
    // 去除tableView多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (_dataArr.count == 0) {
        self.tableView.scrollEnabled = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _noDataHintLb.hidden = NO;
    } else {
        self.tableView.scrollEnabled = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _noDataHintLb.hidden = YES;
    }
}

- (void)createBtnClick {
    
    DetailViewController *detailViewCtrl = [[DetailViewController alloc] init];
    detailViewCtrl.delegate = (id)self;
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 重用Cell
    static NSString *reuseId = @"MemoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    MemoModel *memo = [_dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = memo.title;
    cell.detailTextLabel.text = memo.time;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 删除行
    [_dataArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 一点击cell，立马取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailViewCtrl = [[DetailViewController alloc] init];
    detailViewCtrl.delegate = (id)self;
    // 使用KVC，在跳转到detailViewController之前，设置memo的值
    MemoModel *memo = [_dataArr objectAtIndex:indexPath.row];
    [detailViewCtrl setValue:memo forKey:@"memo"];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

#pragma mark - DetailViewControllerDelegate
- (void)didFinishEditMemo:(MemoModel *)memo {
    
    for (MemoModel *temp in _dataArr) {
        // 查找数组中是否存在旧的memo，存在删除旧的，再重新添加到数组中。
        if ([temp.identifier isEqualToString:memo.identifier]) {
            [_dataArr removeObject:temp];
            break;
        }
    }
    [_dataArr insertObject:memo atIndex:0];
    [self.tableView reloadData];
}

@end
