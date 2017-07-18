//
//  MCIconAlertController.m
//  MCIconAlertControllerExample
//
//  Created by Chao Ma on 08/19/2016.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//


#import "MCIconAlertController.h"
#import "Masonry.h"
#import "MCIconAlertControllerManager.h"

// Colors
#define UIColorFromRGB(rgbValue) \
        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                        green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                         blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                        alpha:1.0]

//Main Screen Size.
#define MainScreenWidth             ([[UIScreen mainScreen] bounds].size.width)
#define MainScreenHeight            ([[UIScreen mainScreen] bounds].size.height)

//Adapter Utils.
#define Scale2X                     (MainScreenWidth/320.0)
#define Scale2X_4_7_Inch            (MainScreenWidth/375.0)

// Fonts
static UIFont *font(CGFloat size) {
    return [UIFont fontWithName:@"Helvetica" size:size];
}

// Colors
static UIColor *buttonTitleColor() {
    return UIColorFromRGB(0x337af0);
}

static const CGFloat MinBackgroundAlpha = 0.01;
static const CGFloat MaxBackgroundAlpha = 0.25;

static const CGFloat MinContentAlpha = 0.01;
static const CGFloat MaxContentAlpha = 1.0;

static const CGFloat MaxBlurAlpha = 0.5;

typedef void (^MCPageDidClosedBlock)();

@interface MCIconAlertController ()

#pragma mark - Subviews.
@property (nonatomic, strong) UIView      *alphaBackground;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UITextView  *messageTextView;
@property (nonatomic, strong) UIButton    *leftButton;
@property (nonatomic, strong) UIButton    *rightButton;

@property (nonatomic, copy) MCPageDidClosedBlock pageDidClosedBlock;

@end

@implementation MCIconAlertController

- (id)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.statusBarStyle = UIStatusBarStyleDefault;
    
    return self;
}

- (void)dealloc {
    //NSLog(@"[MEM] MCIconAlertController --> dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    // Setup subviews
    [self alphaBackground].hidden = YES;
    if (self.customView == nil) {
        [self contentView].hidden = YES;
        [self icon];
        [self titleLabel];
        [self messageTextView];
        [self leftButton];
        [self rightButton];
    } else {
        _contentView.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // Pop out animation
    dispatch_async(dispatch_get_main_queue(), ^{
        [self alphaBackground].hidden = NO;
        if (self.customView == nil) {
            [self contentView].hidden = NO;
        } else {
            _contentView.hidden = NO;
        }
        [self popOutAnimation];
    });
}

#pragma mark - Setters
- (void)setCustomView:(UIView *)customView {
    if (_customView == customView) {
        return;
    }
    
    if (_customView.superview) {
        [_customView removeFromSuperview];
    }
    
    _customView = customView;
    
    if (customView == nil) {
        return;
    }
    
    if (_contentView.superview) {
        [_contentView removeFromSuperview];
    }
    self.contentView = customView;
    
    
    // Add subview for custom view
    [self.view addSubview: customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(customView.superview);
    }];
}

#pragma mark - Subviews.
- (UIView *)alphaBackground {
    if (_alphaBackground) {
        return _alphaBackground;
    }
    
    UIView *alphaBackground = [[UIView alloc]init];
    _alphaBackground = alphaBackground;
    [self.view addSubview:alphaBackground];
    [alphaBackground mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(alphaBackground.superview);
    }];
    alphaBackground.backgroundColor = UIColorFromRGB(0x000000);
    alphaBackground.alpha = MinBackgroundAlpha;
    
    return _alphaBackground;
}

- (UIView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    
    UIView *contentView = [[UIView alloc]init];
    _contentView = contentView;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(contentView.superview);
        make.width.mas_equalTo(564 / 2.f * Scale2X);
        make.top.mas_greaterThanOrEqualTo(contentView.superview).offset(20);
        make.bottom.mas_lessThanOrEqualTo(contentView.superview).offset(-20);
    }];
    contentView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    contentView.layer.cornerRadius = 8.f;
    contentView.clipsToBounds = YES;
    
    return _contentView;
}

- (UIImageView *)icon {
    if (_icon) {
        return _icon;
    }
    
    UIImageView *icon = [[UIImageView alloc]init];
    _icon = icon;
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(icon.superview).offset(35 / 2.f * Scale2X);
        make.centerX.equalTo(icon.superview);
        make.size.mas_equalTo(CGSizeMake(154 / 2.f * Scale2X, 154 / 2.f * Scale2X));
    }];
    icon.backgroundColor = [UIColor clearColor];
    icon.image = self.iconImage;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    
    return _icon;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = font(18);
    titleLabel.text = self.title;
    
    return _titleLabel;
}

- (UITextView *)messageTextView {
    if (_messageTextView) {
        return _messageTextView;
    }
    
    UITextView *messageTextView = [[UITextView alloc] init];
    _messageTextView = messageTextView;
    [self.contentView addSubview:messageTextView];
    messageTextView.backgroundColor = [UIColor clearColor];
    messageTextView.textColor = [UIColor blackColor];
    messageTextView.font = font(14);
    messageTextView.editable = NO;
    messageTextView.text = self.message;
    
    return _messageTextView;
}

- (UIButton *)leftButton {
    if (_leftButton) {
        return _leftButton;
    }
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton = leftButton;
    [self.contentView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.messageTextView.mas_bottom).offset(24 / 2.f * Scale2X);
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(564 / 2.f * Scale2X / 2.f);
        make.height.mas_equalTo(90 / 2.f * Scale2X);
    }];
    [leftButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
    [leftButton setTitleColor:buttonTitleColor() forState:UIControlStateNormal];
    [leftButton setTitleColor:[buttonTitleColor() colorWithAlphaComponent:.5] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return _leftButton;
}

- (UIButton *)rightButton {
    if (_rightButton) {
        return _rightButton;
    }
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton = rightButton;
    [self.contentView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.messageTextView.mas_bottom).offset(24 / 2.f * Scale2X);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(564 / 2.f * Scale2X / 2.f);
        make.height.mas_equalTo(90 / 2.f * Scale2X);
    }];
    [rightButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
    [rightButton setTitleColor:buttonTitleColor() forState:UIControlStateNormal];
    [rightButton setTitleColor:[buttonTitleColor() colorWithAlphaComponent:.5] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Setup line views
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_rightButton);
        make.left.equalTo(lineView.superview);
        make.right.equalTo(lineView.superview);
        make.height.mas_equalTo(1.f);
    }];
    lineView.backgroundColor = UIColorFromRGB(0xa9a9a9);

    lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_rightButton);
        make.left.equalTo(_rightButton);
        make.bottom.equalTo(_rightButton);
        make.width.mas_equalTo(1.f);
    }];
    lineView.backgroundColor = UIColorFromRGB(0xa9a9a9);
    
    return _rightButton;
}

- (void)viewDidLayoutSubviews {
    if (self.customView == nil) {
        [self.titleLabel sizeToFit];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.icon.mas_bottom).offset(40 / 2.f * Scale2X);
            make.centerX.equalTo(self.icon);
            make.height.mas_equalTo(self.titleLabel.frame.size.height);
        }];
        
        [self.messageTextView mas_remakeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.titleLabel.mas_bottom).offset(28 / 2.f * Scale2X);
            make.centerX.equalTo(self.titleLabel);
            make.left.equalTo(self.messageTextView.superview).offset(10);
            make.right.equalTo(self.messageTextView.superview).offset(-10);
            make.height.mas_equalTo(self.messageTextView.contentSize.height);
        }];
    }
}

#pragma mark - Actions.
- (void)leftButtonTapped:(UIButton *)button {
    __weak typeof(self) weakSelf = self;
    [self dismissAnimationWithCompletion:^(){
        if (weakSelf.leftButtonTappedBlock) {
            weakSelf.leftButtonTappedBlock();
        }
    }];
}

- (void)rightButtonTapped:(UIButton *)button {
    __weak typeof(self) weakSelf = self;
    [self dismissAnimationWithCompletion:^(){
        if (weakSelf.rightButtonTappedBlock) {
            weakSelf.rightButtonTappedBlock();
        }
    }];
}

#pragma mark - Animations.
- (void)popOutAnimation {
    self.alphaBackground.alpha = MinBackgroundAlpha;
    if (self.customView == nil) {
        self.contentView.alpha = MinContentAlpha;
        self.contentView.transform = CGAffineTransformMakeScale(.5, .5);
    } else {
        _contentView.alpha = MinContentAlpha;
        _contentView.transform = CGAffineTransformMakeScale(.5, .5);
    }
    [UIView animateWithDuration:.4
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.alphaBackground.alpha = MaxBackgroundAlpha;
                     }completion:^(BOOL finished){
                     }];
        [UIView animateWithDuration:.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if (self.customView == nil) {
                                 self.contentView.alpha = MaxContentAlpha;
                                 self.contentView.transform = CGAffineTransformMakeScale(1, 1);
                             } else {
                                 _contentView.alpha = MaxContentAlpha;
                                 _contentView.transform = CGAffineTransformMakeScale(1, 1);
                             }
                         } completion:^(BOOL finished){
                         }];
}

#pragma mark - For custom view
- (void)registLeftButton:(UIButton *) button {
    [button addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registRightButton:(UIButton *) button {
    [button addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Publics
- (void)show {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    self.effectView = effectView;
    [[UIApplication sharedApplication].keyWindow addSubview: effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(effectView.superview);
    }];
    effectView.alpha = 0;
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         effectView.alpha = MaxBlurAlpha;
                     } completion: nil];
    
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    __weak typeof(window) weakWindow = window;
    window.rootViewController = self;
    [window makeKeyAndVisible];
    [[MCIconAlertControllerManager sharedInstance].iconAlertControllerWindows addObject:window];
    
    self.pageDidClosedBlock = ^{
        weakWindow.hidden = YES;
        [[MCIconAlertControllerManager sharedInstance].iconAlertControllerWindows removeObject:weakWindow];
    };
}

- (void)dismissAnimationWithCompletion:(void (^)())completion {
    self.alphaBackground.alpha = MaxBackgroundAlpha;
    if (self.customView == nil) {
        self.contentView.alpha = MaxContentAlpha;
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    } else {
        _contentView.alpha = MaxContentAlpha;
        _contentView.transform = CGAffineTransformMakeScale(1, 1);
    }
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.alphaBackground.alpha = MinBackgroundAlpha;
                         if (self.customView == nil) {
                             self.contentView.alpha = MinContentAlpha;
                             self.contentView.transform = CGAffineTransformMakeScale(.5, .5);
                         } else {
                             _contentView.alpha = MinContentAlpha;
                             _contentView.transform = CGAffineTransformMakeScale(.5, .5);
                         }
                     }completion:^(BOOL finished){
                         self.alphaBackground.hidden = YES;
                         if (self.customView == nil) {
                             self.contentView.hidden = YES;
                         } else {
                             _contentView.hidden = YES;
                         }
                         
                         [self dismissViewControllerAnimated:NO completion:nil];
                         
                         if (self.pageDidClosedBlock) {
                             self.pageDidClosedBlock();
                         }
                         
                         if (completion) {
                             completion();
                         }
                     }];
    
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         self.effectView.alpha = 0.0;
                     } completion: ^(BOOL finished){
                         if (self.effectView.superview) {
                             [self.effectView removeFromSuperview];
                         }
                     }];
}

#pragma mark - UIViewController
- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusBarStyle;
}

@end
