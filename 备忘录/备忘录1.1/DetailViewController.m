//
//  DetailViewController.m
//  备忘录1.1
//
//  Created by yinquan on 16/11/8.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import "DetailViewController.h"
#import "MemoModel.h"
#import "MemoTableViewController.h"
@interface DetailViewController () <UITextViewDelegate>

@property (weak, nonatomic) UITextView *textView;
@property (nonatomic, strong) MemoModel *memo;

@end
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    textView.font = [UIFont systemFontOfSize:16.0f];
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    textView.delegate = (id)self;
    _textView = textView;
    [self.view addSubview:_textView];
    
    // 判断memo是否存在，如果存在，则是通过行点击进入当前的界面，将memo的内容显示出来。
    if (_memo == nil) {
        _memo = [[MemoModel alloc] init];
    } else {
        _textView.text = _memo.content;
    }
}

- (void)completeBtnClick {
    [_textView resignFirstResponder];
    [_memo changeContentWithContent:_textView.text];
    if ([self.delegate respondsToSelector:@selector(didFinishEditMemo:)]) {
        [self.delegate didFinishEditMemo:_memo];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteBtnClick {
    self.textView.text = nil;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeBtnClick)];
}


@end
