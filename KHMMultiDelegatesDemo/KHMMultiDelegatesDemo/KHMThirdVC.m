//
//  KHMThirdVC.m
//  KHMMultiDelegatesDemo
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import "KHMThirdVC.h"
#import "KHMMultiDelegateMgr.h"

@interface KHMThirdVC () <KHMMultiProtocol>

@end

@implementation KHMThirdVC {
    __weak KHMMultiDelegates<KHMMultiProtocol> *multiDelegate;
}

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)p_setupComponents {
    UITapGestureRecognizer *tap = \
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tapEvent:)];
    
    [self.view addGestureRecognizer:tap];
    
    multiDelegate = [[KHMMultiDelegateMgr sharedInstance] multiDelegate];
    [multiDelegate addDelegate:self];
}

#pragma mark - event respond

- (void)tapEvent:(UIGestureRecognizer *)tap {
    if ([multiDelegate respondsToSelector:@selector(notifiedAllDelegatesLogger:)]) {
        [multiDelegate notifiedAllDelegatesLogger:@"我从第三世界来!"];
    }
}

- (IBAction)changedAction:(id)sender {
    if ([multiDelegate respondsToSelector:@selector(notifiedAllDelegatesChangedColor:)]) {
        [multiDelegate notifiedAllDelegatesChangedColor:[UIColor greenColor]];
    }
}

#pragma mark - KHMMultiProtocol

- (void)notifiedAllDelegatesChangedColor:(UIColor *)color {
    self.view.backgroundColor = color;
}


@end
