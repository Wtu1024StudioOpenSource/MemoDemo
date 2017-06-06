//
//  MemoModel.h
//  MemoDemo
//
//  Created by Gin on 16/6/28.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoModel : NSObject

/**内容*/
@property (nonatomic, strong) NSString *content;
/**标题*/
@property (nonatomic, strong) NSString *title;
/**创建/最后修改时间*/
@property (nonatomic, strong) NSString *time;
/**唯一不变标识，区别不同的备忘录数据*/
@property (nonatomic, strong) NSString *identifier;

/**更改备忘录中的内容*/
- (void)changeContentWithContent:(NSString *)content;

@end
