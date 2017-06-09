//
//  MemoModel.m
//  备忘录1.1
//
//  Created by yinquan on 16/11/8.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import "MemoModel.h"

@implementation MemoModel

- (instancetype)init {
    if (self = [super init]) {
        // 初始化的时候，就创建时间和唯一标识
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        self.time = [formatter stringFromDate:[NSDate date]];
        self.identifier = self.time;
    }
    return self;
}


- (void)changeContentWithContent:(NSString *)content {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    // 修改内容，同时也要修改时间
    self.time = [formatter stringFromDate:[NSDate date]];
    self.content = content;
    
    // 标题，截取内容中的前面一段字符串
    self.title = (content.length > 37) ? [content substringToIndex:30]: content;
    
    // 部分文本内容，从第二行开始
    NSRange range = [content rangeOfString:@"\n"];
    self.partCont = (range.location < 40) ? [content substringFromIndex:range.location + 1] : @"无附加文本";
}
@end
