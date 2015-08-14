//
//  ViewController.m
//  KHMMultiDelegatesDemo
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import "ViewController.h"
#import "KHMMultiDelegateMgr.h"

@interface UIButton (KHMMultiProtocol) <KHMMultiProtocol>

@end

@implementation UIButton (KHMMultiProtocol)

#pragma mark - KHMMultiProtocol

- (void)notifiedAllDelegatesChangedColor:(UIColor *)color {
    self.backgroundColor = color;
}

@end


@interface ViewController () <KHMMultiProtocol>

@end

@implementation ViewController {
    __weak KHMMultiDelegates<KHMMultiProtocol> *multiDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    
    for (UIButton *btn in self.btnSets) {
        [multiDelegate addDelegate:btn];
    }
}

#pragma mark - action method

- (IBAction)changedAction:(id)sender {
    if ([multiDelegate respondsToSelector:@selector(notifiedAllDelegatesChangedColor:)]) {
        [multiDelegate notifiedAllDelegatesChangedColor:[UIColor blueColor]];
    }
}

#pragma mark - KHMMultiProtocol

- (void)notifiedAllDelegatesLogger:(NSString *)log {
    NSLog(@"viewController :%@",log);
}

@end
