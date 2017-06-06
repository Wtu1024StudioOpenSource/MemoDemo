//
//  DetailViewController.h
//  MemoDemo
//
//  Created by Gin on 16/6/28.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemoModel;

// 私有代理
@protocol DetailViewControllerDelegate <NSObject>

// 完成编辑备忘录之后的回调函数
- (void)didFinishEditMemo:(MemoModel *)memo;

@end

@interface DetailViewController : UIViewController

@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;

@end
