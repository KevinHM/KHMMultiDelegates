//
//  ViewController.h
//  KHMMultiDelegatesDemo
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *btnSets;
@property (nonatomic, weak) IBOutlet UIButton *changeBtn;

@end

