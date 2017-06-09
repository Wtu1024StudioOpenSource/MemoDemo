//
//  MemoModel.h
//  备忘录1.1
//
//  Created by yinquan on 16/11/8.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoModel : NSObject

@property (nonatomic, strong) MemoModel *memo;
// 附加文本
@property (nonatomic, strong) NSString *content;
// 标题
@property (nonatomic, strong) NSString *title;
// 创建/最后修改时间
@property (nonatomic, strong) NSString *time;
// 部分文本内容
@property (nonatomic, strong) NSString *partCont;
// 唯一不变标识，区别不同的备忘录数据
@property (nonatomic, strong) NSString *identifier;
// 更改备忘录内容
- (void)changeContentWithContent:(NSString *)content;
@end
