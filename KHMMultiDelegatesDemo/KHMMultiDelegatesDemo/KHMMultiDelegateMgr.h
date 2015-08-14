//
//  KHMMultiDelegateMgr.h
//  KHMMultiDelegatesDemo
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "KHMMultiDelegates.h"

/** 这个协议可以按照你的需求来追加方法*/
@protocol KHMMultiProtocol <NSObject>
@optional
- (void)notifiedAllDelegatesLogger:(NSString *)log;
- (void)notifiedAllDelegatesChangedColor:(UIColor *)color;

@end

/** 多重Delegate管理类*/
@interface KHMMultiDelegateMgr : NSObject

@property (nonatomic, readonly, strong) KHMMultiDelegates<KHMMultiProtocol> *multiDelegate;

+ (instancetype)sharedInstance;

@end
