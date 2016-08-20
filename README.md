# MCIconAlertController
Alert controller with icon, have fun.

![Screen-Shot-01-w100](Screenshots/Screen-Shot-01.png)
![Screen-Shot-02-w100](Screenshots/Screen-Shot-02.png)
![Screen-Shot-03-w100](Screenshots/Screen-Shot-03.png)
![Screen-Shot-04-w100](Screenshots/Screen-Shot-04.png)
![Screen-Shot-05-w100](Screenshots/Screen-Shot-05.png)

## Install
Cocoapods:
```
pod 'MCIconAlertController', '~> 0.0.1'
```

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


