//
//  KHMMultiDelegateMgr.m
//  KHMMultiDelegatesDemo
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import "KHMMultiDelegateMgr.h"

@implementation KHMMultiDelegateMgr

+ (instancetype)sharedInstance {
    static KHMMultiDelegateMgr *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[KHMMultiDelegateMgr alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _multiDelegate = \
          (KHMMultiDelegates<KHMMultiProtocol> *)[[KHMMultiDelegates alloc] initWithDelegates:nil];
    }
    return self;
}

@end
