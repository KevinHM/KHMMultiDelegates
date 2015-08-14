//
//  SecondaryViewController.m
//  KHMMultiDelegatesDemo
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import "SecondaryViewController.h"
#import "KHMMultiDelegateMgr.h"

@interface SecondaryViewController () <KHMMultiProtocol>

@end

@implementation SecondaryViewController {
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
    multiDelegate = [[KHMMultiDelegateMgr sharedInstance] multiDelegate];
    [multiDelegate addDelegate:self];
}

#pragma mark - action method

- (IBAction)changedAction:(id)sender {
    if ([multiDelegate respondsToSelector:@selector(notifiedAllDelegatesChangedColor:)]) {
        [multiDelegate notifiedAllDelegatesChangedColor:[UIColor redColor]];
    }
}

#pragma mark - KHMMultiProtocol

- (void)notifiedAllDelegatesLogger:(NSString *)log {
    NSLog(@"secondaryViewController :%@",log);
}

- (void)notifiedAllDelegatesChangedColor:(UIColor *)color {
    self.view.backgroundColor = color;
}

@end
