//
//  KHMMultiDelegates.h
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (ReturnType)

- (BOOL)khm_methodReturnTypeIsVoid;

@end


@interface KHMMultiDelegates : NSProxy

@property (nonatomic, readonly, strong) NSArray *delegates; /**< a set of delegates*/

- (instancetype)initWithDelegates:(NSArray *)delegates;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end
