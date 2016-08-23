//
//  MCIconAlertControllerTests.m
//  MCIconAlertControllerTests
//
//  Created by Chao Ma on 2016-08-21.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCIconAlertController.h"
#import "MCIconAlertControllerManager.h"

@interface MCIconAlertControllerTests : XCTestCase

@end

@implementation MCIconAlertControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testNormalShow {
    MCIconAlertController *iconAlertController = [[MCIconAlertController alloc] init];
    XCTAssert(iconAlertController != nil);
    iconAlertController.iconImage = [UIImage imageNamed:@"dog.jpg"];
    iconAlertController.title = @"Rigo";
    iconAlertController.message = @"Hello there, how are you!";
    iconAlertController.leftButtonTitle = @"Accept";
    iconAlertController.rightButtonTitle = @"Ignore";
    iconAlertController.leftButtonTappedBlock = ^(){
        NSLog(@"leftButtonTappedBlock");
    };
    iconAlertController.rightButtonTappedBlock = ^(){
        NSLog(@"rightButtonTappedBlock");
    };
    XCTAssert(iconAlertController != nil);
}

- (void)testManager {
    MCIconAlertControllerManager *iconAlertControllerManager = [MCIconAlertControllerManager sharedInstance];
    XCTAssert(iconAlertControllerManager);
    [iconAlertControllerManager.iconAlertControllerWindows addObject:[UIWindow new]];
    XCTAssert(iconAlertControllerManager.iconAlertControllerWindows);
}


@end
