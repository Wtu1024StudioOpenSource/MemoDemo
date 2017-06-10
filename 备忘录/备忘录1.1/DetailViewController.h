//
//  DetailViewController.h
//  备忘录1.1
//
//  Created by yinquan on 16/11/8.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoModel.h"
@class MemoModel;
// 代理
@protocol DetailViewControllerDelegate <NSObject>
// 完成编辑备忘录之后的回调函数
- (void)didFinishEditMemo:(MemoModel *)edit;
@end
@interface DetailViewController : UIViewController
@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;
@end
