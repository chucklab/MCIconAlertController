# MCIconAlertController
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/imegatron/MCIconAlertController/master/LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](https://img.shields.io/cocoapods/v/MCIconAlertController.svg?style=flat)](https://cocoapods.org/pods/MCIconAlertController)
[![Pod Platform](https://img.shields.io/cocoapods/p/MCIconAlertController.svg?style=flat)](https://cocoapods.org/pods/MCIconAlertController)
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)
[![Build Status](https://img.shields.io/travis/imegatron/MCIconAlertController/master.svg?style=flat)](https://travis-ci.org/imegatron/MCIconAlertController)
[![Coverage Status](https://codecov.io/github/imegatron/MCIconAlertController/coverage.svg?branch=master)](https://codecov.io/github/imegatron/MCIconAlertController?branch=master)
[![Reference Status](https://www.versioneye.com/objective-c/MCIconAlertController/reference_badge.svg?style=flat)](https://www.versioneye.com/objective-c/MCIconAlertController/references)

Alert controller with icon, have fun.

![Screen-Shot-01-w100](Screenshots/Screen-Shot-01.png)
![Screen-Shot-02-w100](Screenshots/Screen-Shot-02.png)
![Screen-Shot-03-w100](Screenshots/Screen-Shot-03.png)
![Screen-Shot-04-w100](Screenshots/Screen-Shot-04.png)
![Screen-Shot-05-w100](Screenshots/Screen-Shot-05.png)

## Installation
### Cocoapods:

1. Add `pod 'MCIconAlertController', '~> 0.0.1'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import \<MCIconAlertController.h\>.

### Carthage:

1. Add `github "imegatron/MCIconAlertController"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
3. Import \<MCIconAlertController/MCIconAlertController.h\>.

## Usage

```objc
MCIconAlertController *iconAlertController = [[MCIconAlertController alloc] init];
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
[iconAlertController show];
```

## Requirements
This library requires a deployment target of iOS 6.0 or greater.

## License
MCIconAlertController is provided under the MIT license. See LICENSE file for details.

