//
//  UIBarButtonItem+KPLBlocks.m
//  KPLBlocks
//
//  Created by apple on 17/2/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIBarButtonItem+KPLBlocks.h"
#import <objc/runtime.h>

static const void *KPLUIBarButtonItemBlockKey = &KPLUIBarButtonItemBlockKey;

@implementation UIBarButtonItem (KPLBlocks)


- (instancetype)kpl_initWithSystemStyle:(UIBarButtonSystemItem)systemStyle handler:(void (^)(id))action
{
    self = [self initWithBarButtonSystemItem:systemStyle target:self action:@selector(kpl_handleAction:)];
    
    if (!self) return nil;
    
    objc_setAssociatedObject(self, KPLUIBarButtonItemBlockKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}

- (instancetype)kpl_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id))action
{
    self = [self initWithImage:image style:style target:self action:@selector(kpl_handleAction:)];
    
    if (!self) return nil;
    
    objc_setAssociatedObject(self, KPLUIBarButtonItemBlockKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}

- (instancetype)kpl_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void (^)(id))action
{
    self = [self initWithTitle:title style:style target:self action:@selector(kpl_handleAction:)];
    
    if (!self) return nil;
    
    objc_setAssociatedObject(self, KPLUIBarButtonItemBlockKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}

- (instancetype)kpl_initWithImage:(UIImage *)image landscapeImage:(UIImage *)landscapeImage style:(UIBarButtonItemStyle)style handler:(void (^)(id))action
{
    self = [self initWithImage:image landscapeImagePhone:landscapeImage style:style target:self action:@selector(kpl_handleAction:)];
    
    if (!self) {
        return nil;
    }
    
    objc_setAssociatedObject(self, KPLUIBarButtonItemBlockKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}

- (void)kpl_handleAction:(UIBarButtonItem *)sender
{
    void (^block) (id) = objc_getAssociatedObject(self, KPLUIBarButtonItemBlockKey);
    
    if (block) {
        block(sender);
    }
}

@end
