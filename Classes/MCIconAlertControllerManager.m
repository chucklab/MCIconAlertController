//
//  MCIconAlertControllerManager.m
//  MCIconAlertControllerExample
//
//  Created by Chao Ma on 08/22/2016.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "MCIconAlertControllerManager.h"

@implementation MCIconAlertControllerManager

- (NSMutableArray *)iconAlertControllerWindows {
    if (_iconAlertControllerWindows) {
        return _iconAlertControllerWindows;
    }
    
    _iconAlertControllerWindows = [@[] mutableCopy];
    
    return _iconAlertControllerWindows;
}

#pragma mark - Singleton
+ (instancetype)sharedInstance{
    static id sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc]init];
    });
    return sharedSingleton;
}

@end
