//
//  MCIconAlertController.h
//  MCIconAlertControllerExample
//
//  Created by Chao Ma on 08/19/2016.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

typedef void (^MCLeftButtonTappedBlock)();
typedef void (^MCRightButtonTappedBlock)();

#import <UIKit/UIKit.h>

@interface MCIconAlertController : UIViewController

@property (nonatomic, copy) MCLeftButtonTappedBlock leftButtonTappedBlock;
@property (nonatomic, copy) MCRightButtonTappedBlock rightButtonTappedBlock;

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *leftButtonTitle;
@property (nonatomic, copy) NSString *rightButtonTitle;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

#pragma mark - For custom view
- (void)registLeftButton:(UIButton *) button;
- (void)registRightButton:(UIButton *) button;

#pragma mark - Publics
- (void)show;
- (void)dismissAnimationWithCompletion:(void (^)())completion;

@end
