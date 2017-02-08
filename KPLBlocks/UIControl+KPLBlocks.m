//
//  UIControl+KPLBlocks.m
//  KPLBlocks
//
//  Created by apple on 17/2/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIControl+KPLBlocks.h"
#import <objc/runtime.h>

static const void *KPLControlHandlersKey = &KPLControlHandlersKey;

@interface KPLControlWrapper : NSObject<NSCopying>

@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, strong) void (^handler)(id sender);

- (instancetype)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@end

@implementation KPLControlWrapper

- (instancetype)initWithHandler:(void (^)(id))handler forControlEvents:(UIControlEvents)controlEvents
{
    self = [super init];
    
    if (!self) return nil;
    
    self.handler = handler;
    self.controlEvents = controlEvents;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[KPLControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender
{
    self.handler(sender);
}

@end

@implementation UIControl (KPLBlocks)

- (void)kpl_addEventHandler:(void (^)(id))handler forControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, KPLControlHandlersKey);
    
    if (!events) {
        events = [NSMutableDictionary dictionary];
        
        objc_setAssociatedObject(self, KPLControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    
    KPLControlWrapper *target = [[KPLControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
    
    [handlers addObject:target];
  
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    
}

- (void)kpl_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, KPLControlHandlersKey);
    
    if (!events) {
        events = [NSMutableDictionary dictionary];
        
        objc_setAssociatedObject(self, KPLControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    
    if (!handlers) return;
    
    [handlers enumerateObjectsUsingBlock:^(id sender, BOOL * _Nonnull stop) {
        [self removeTarget:sender action:NULL forControlEvents:controlEvents];
    }];
    
    [events removeObjectForKey:key];
    
}

- (BOOL)kpl_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, KPLControlHandlersKey);
    
    if (!events) {
        events = [NSMutableDictionary dictionary];
        
        objc_setAssociatedObject(self, KPLControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    
    NSSet *handlers = events[key];
    
    if (!handlers) return NO;
    
    return !!handlers.count;
}

@end
