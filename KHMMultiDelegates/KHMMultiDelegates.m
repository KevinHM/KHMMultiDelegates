//
//  KHMMultiDelegates.m
//
//  Created by KevinHM on 15/8/14.
//  Copyright (c) 2015年 KevinHM. All rights reserved.
//

#import "KHMMultiDelegates.h"

@implementation NSInvocation (ReturnType)

- (BOOL)khm_methodReturnTypeIsVoid {
    return ( [self.methodSignature methodReturnLength] == 0 );
}

@end


@interface KHMMultiDelegates ()
@property (nonatomic, strong) NSPointerArray *mutableDelegates;

@end

@implementation KHMMultiDelegates

- (instancetype)initWithDelegates:(NSArray *)delegates {
    _mutableDelegates = [NSPointerArray weakObjectsPointerArray];
    [delegates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_mutableDelegates addPointer:(void *)obj];
    }];
    
    return self;
}

#pragma mark - Public interface

- (NSArray *)delegates {
    return [self.mutableDelegates allObjects];
}

- (void)addDelegate:(id)aDelegate {
    NSParameterAssert(aDelegate);
    [self.mutableDelegates addPointer:(void *)aDelegate];
}

- (void)removeDelegate:(id)aDelegate {
    NSParameterAssert(aDelegate);
    
    NSUInteger index = 0;
    for (id delegate in self.mutableDelegates) {
        if (delegate == aDelegate) {
            [self.mutableDelegates removePointerAtIndex:index];
            break;
        }
        index ++;
    }
}

#pragma mark - NSProxy

- (void)forwardInvocation:(NSInvocation *)invocation {
    //如果方法返回 void 我可以安全地调用所有的 delegate，
    //否则我仅仅会调用第一个 delegate 去响应给定的 selector
    if ([invocation khm_methodReturnTypeIsVoid]) {
        for (id delegate in self.mutableDelegates) {
            if ([delegate respondsToSelector:invocation.selector]) {
                [invocation invokeWithTarget:delegate];
            }
        }
    }
    else {
        id firstResponder = [self p_firstResponderToSelector:invocation.selector];
        [invocation invokeWithTarget:firstResponder];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    id firstResponder = [self p_firstResponderToSelector:sel];
    if (firstResponder) {
        return [firstResponder methodSignatureForSelector:sel];
    }
    return nil;
}

#pragma mark - NSObject protocol method

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    id firstConformer = [self p_firstConformedToProtocol:aProtocol];
    
    return (firstConformer ? YES : NO);
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    id firstResponder = [self p_firstResponderToSelector:aSelector];
    
    return (firstResponder ? YES : NO);
}

#pragma mark - private method

- (id)p_firstResponderToSelector:(SEL)aSelector {
    for (id delegate in self.mutableDelegates) {
        if ([delegate respondsToSelector:aSelector]) {
            return delegate;
        }
    }
    
    return nil;
}

- (id)p_firstConformedToProtocol:(Protocol *)aProtocol {
    for (id delegate in self.mutableDelegates) {
        if ([delegate conformsToProtocol:aProtocol]) {
            return delegate;
        }
    }
    
    return nil;
}

@end
