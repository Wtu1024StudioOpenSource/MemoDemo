//
//  MemoTableViewController.m
//  备忘录1.1
//
//  Created by yinquan on 16/11/7.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import "MemoTableViewController.h"
#import "DetailViewController.h"
#import "MemoModel.h"
#import "MemoCell.h"
@interface MemoTableViewController () <DetailViewControllerDelegate>

// 存放备忘录数据
@property (strong, nonatomic) NSMutableArray *dataArr;
// 备忘录数目
@property (nonatomic, strong) UILabel *totalMemoLb;

@end

@implementation MemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    _dataArr = [NSMutableArray array];
    _totalMemoLb = [[UILabel alloc] init];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.hidden = YES;
    // 添加计数Lb
    UILabel *totalMemoLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 320, 30)];
    totalMemoLb.textColor = [UIColor blackColor];
    totalMemoLb.font = [UIFont systemFontOfSize:12.0f];
    totalMemoLb.text = @"无备忘录";
    totalMemoLb.textAlignment = NSTextAlignmentCenter;
    totalMemoLb.backgroundColor = [UIColor clearColor];
    _totalMemoLb = totalMemoLb;
    [self.navigationController.toolbar addSubview:_totalMemoLb];
}

// 导航栏设置
- (void)setNavigation {
    self.navigationItem.title = @"备忘录";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    // 底部工具栏设置
    self.navigationController.toolbarHidden = NO;
    // 新建备忘录
    UIBarButtonItem *createBtnItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createBtnClick)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.navigationController.toolbar.tintColor = [UIColor orangeColor];
    NSArray *array = [[NSArray alloc]initWithObjects:spaceItem, spaceItem, createBtnItem, nil];
    self.toolbarItems = array;
}

- (void)createBtnClick {
    DetailViewController *memoViewCtrl = [[DetailViewController alloc] init];
    memoViewCtrl.delegate = (id)self;
    [self.navigationController pushViewController:memoViewCtrl animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.toolbarHidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArr.count) {
        _totalMemoLb.text = [NSString stringWithFormat:@"%d个备忘录", (int)_dataArr.count];
        NSLog(@"%@",_totalMemoLb.text);
    } else {
        _totalMemoLb.text = @"无备忘录";
    }
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoModel *model = [_dataArr objectAtIndex:indexPath.row];
    // 自定义cell
    MemoCell *cell = [MemoCell memoWithTableView:tableView];
    cell.memo = model;
    return cell;
}

#pragma mark - UITableViewDelegate
// 监听cell的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 一点击cell，立马取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailViewCtrl = [[DetailViewController alloc] init];
    detailViewCtrl.delegate = (id)self;
    // 使用KVC，在跳转到detailViewController之前，设置memo的值
    MemoModel *edit = [_dataArr objectAtIndex:indexPath.row];
    [detailViewCtrl setValue:edit forKey:@"memo"];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

// 是否可以编辑  默认的时YES
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 选择你要对表进行处理的方式  默认是删除方式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 左滑删除
    [_dataArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

// 设置cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


#pragma mark - DetailViewControllerDelegate
- (void)didFinishEditMemo:(MemoModel *)edit {
    for (MemoModel *temp in _dataArr) {
        // 查找数组中是否存在旧的memo，存在删除旧的，再重新添加到数组中。
        if ([temp.identifier isEqualToString:edit.identifier]) {
            [_dataArr removeObject:temp];
            break;
        }
    }
    [_dataArr insertObject:edit atIndex:0];
    [self.tableView reloadData];
}



@end
