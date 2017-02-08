//
//  ViewController.m
//  Demo
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "KPLBlocks+UIKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)replaceBtnClickForBlock:(UIButton *)sender {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.center = self.view.center;
    
    [self.view addSubview:btn];
    
    [btn kpl_addEventHandler:^(id sender) {
        NSLog(@"使用block代替了按钮的监听，增强了易读性");
    } forControlEvents:UIControlEventTouchUpInside];
    
}


@end
