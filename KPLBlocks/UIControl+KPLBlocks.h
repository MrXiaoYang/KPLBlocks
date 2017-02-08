//
//  UIControl+KPLBlocks.h
//  KPLBlocks
//
//  Created by apple on 17/2/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (KPLBlocks)

//  添加事件
- (void)kpl_addEventHandler:(void(^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

//
- (void)kpl_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

- (BOOL)kpl_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end
