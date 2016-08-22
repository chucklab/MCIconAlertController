//
//  MCIconAlertControllerManager.h
//  MCIconAlertControllerExample
//
//  Created by Chao Ma on 08/22/2016.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCIconAlertControllerManager : NSObject

@property (nonatomic, strong) NSMutableArray *iconAlertControllerWindows;

#pragma mark - Singleton
+ (instancetype)sharedInstance;

@end
