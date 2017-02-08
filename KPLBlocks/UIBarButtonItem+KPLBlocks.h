//
//  UIBarButtonItem+KPLBlocks.h
//  KPLBlocks
//
//  Created by apple on 17/2/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KPLBlocks)

- (instancetype)kpl_initWithSystemStyle:(UIBarButtonSystemItem)systemStyle handler:(void(^)(id sender))action NS_REPLACES_RECEIVER;

- (instancetype)kpl_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void(^)(id sender))action NS_REPLACES_RECEIVER;

- (instancetype)kpl_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void(^)(id sender))action NS_REPLACES_RECEIVER;

- (instancetype)kpl_initWithImage:(UIImage *)image landscapeImage:(UIImage *)landscapeImage style:(UIBarButtonItemStyle)style handler:(void (^)(id))action NS_REPLACES_RECEIVER;

@end
