//
//  ViewController.m
//  MCIconAlertControllerExample
//
//  Created by Chao Ma on 2016-08-21.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <Masonry.h>

#import "ViewController.h"
#import "MCIconAlertController.h"
#import "AlertsTableView.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MCIconAlertController";
    
    AlertsTableView *tableView = [[AlertsTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.cellTappedBlock = ^(NSIndexPath *indexPath, NSString *cellData){
        switch (indexPath.row) {
            case 0: { // Normal
                [self normal];
            } break;
                
            case 1: { // Multi lines
                [self multiLines];
            } break;
                
            case 2: { // Long single line
                [self longSingleLine];
            } break;
                
            case 3: { // Very long text
                [self veryLongText];
            } break;
                
            case 4: { // No message
                [self noMessage];
            } break;
                
            case 5: { // Custom view
                [self customView];
            } break;
                
            default: {
                [self normal];
            } break;
        }
    };
    tableView.dataArray = @[
                            @"Normal",
                            @"Multi lines",
                            @"Long single line",
                            @"Very long text",
                            @"No message",
                            @"Custom view",
                            ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Examples
- (void)normal {
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
}

- (void)multiLines {
    MCIconAlertController *iconAlertController = [[MCIconAlertController alloc] init];
    iconAlertController.iconImage = [UIImage imageNamed:@"dog.jpg"];
    iconAlertController.title = @"Title";
    iconAlertController.message = @"This is a message\nand this is a new line\nand this is a new line\nand this is a new line\nand this is a new line.";
    iconAlertController.leftButtonTitle = @"Left";
    iconAlertController.rightButtonTitle = @"Right";
    iconAlertController.leftButtonTappedBlock = ^(){
        NSLog(@"leftButtonTappedBlock");
    };
    iconAlertController.rightButtonTappedBlock = ^(){
        NSLog(@"rightButtonTappedBlock");
    };
    [iconAlertController show];
}

- (void)longSingleLine {
    MCIconAlertController *iconAlertController = [[MCIconAlertController alloc] init];
    iconAlertController.iconImage = [UIImage imageNamed:@"dog.jpg"];
    iconAlertController.title = @"Title";
    iconAlertController.message =
    @"This is a single line 🐶. This is a single line 🐶. This is a single line 🐶. This is a single line 🐶. This is a single line 🐶. This is a single line 🐶. This is a single line 🐶. This is a single line 🐶. This is a single line 🐶. ";
    iconAlertController.leftButtonTitle = @"Left";
    iconAlertController.rightButtonTitle = @"Right";
    iconAlertController.leftButtonTappedBlock = ^(){
        NSLog(@"leftButtonTappedBlock");
    };
    iconAlertController.rightButtonTappedBlock = ^(){
        NSLog(@"rightButtonTappedBlock");
    };
    [iconAlertController show];
}

- (void)veryLongText {
    MCIconAlertController *iconAlertController = [[MCIconAlertController alloc] init];
    iconAlertController.iconImage = [UIImage imageNamed:@"dog.jpg"];
    iconAlertController.title = @"Title";
    iconAlertController.message =
    @"Tom and Jerry is an American animated series of short films created in 1940, by William Hanna and Joseph Barbera. It centers on a rivalry between its two title characters, Tom and Jerry, and many recurring characters, based around slapstick comedy. In its original run, Hanna and Barbera produced 114 Tom and Jerry shorts for Metro-Goldwyn-Mayer from 1940 to 1958. During this time, they won seven Academy Awards for Animated Short Film, tying for first place with Walt Disney's Silly Symphonies with the most awards in the category. After the MGM cartoon studio closed in 1958, MGM revived the series with Gene Deitch directing an additional 13 Tom and Jerry shorts for Rembrandt Films from 1961 to 1962. Tom and Jerry then became the highest-grossing animated short film series of that time, overtaking Looney Tunes. Chuck Jones then produced another 34 shorts with Sib-Tower 12 Productions between 1963 and 1967. Three more shorts were produced, The Mansion Cat in 2001, The Karate Guard in 2005, and \"A Fundraising Adventure\" in 2014, making a total of 164 shorts. Various shorts have been released for home media since the 1990s. A number of spin-offs have been made, including the television series The Tom and Jerry Show (1975), The Tom and Jerry Comedy Show (1980–82), Tom and Jerry Kids (1990–93), Tom and Jerry Tales (2006–08), and The Tom and Jerry Show (2014–present). The first feature-length film based on the series, Tom and Jerry: The Movie, was released in 1992, and 12 direct-to-video films have been produced since 2002. Numerous Tom and Jerry shorts have been subject to controversy, mainly over racial stereotypes which involves the portrayal of the recurring black character Mammy Two Shoes and characters appearing in blackface. Other controversial themes include cannibalism and the glamorization of smoking.";
    iconAlertController.leftButtonTitle = @"Left";
    iconAlertController.rightButtonTitle = @"Right";
    iconAlertController.leftButtonTappedBlock = ^(){
        NSLog(@"leftButtonTappedBlock");
    };
    iconAlertController.rightButtonTappedBlock = ^(){
        NSLog(@"rightButtonTappedBlock");
    };
    [iconAlertController show];
}

- (void)noMessage {
    MCIconAlertController *iconAlertController = [[MCIconAlertController alloc] init];
    iconAlertController.iconImage = [UIImage imageNamed:@"dog.jpg"];
    iconAlertController.title = @"Title";
    iconAlertController.message = nil;
    iconAlertController.leftButtonTitle = @"Left";
    iconAlertController.rightButtonTitle = @"Right";
    iconAlertController.leftButtonTappedBlock = ^(){
        NSLog(@"leftButtonTappedBlock");
    };
    iconAlertController.rightButtonTappedBlock = ^(){
        NSLog(@"rightButtonTappedBlock");
    };
    [iconAlertController show];
}

- (void)customView {
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor whiteColor];
    customView.layer.cornerRadius = 10;
    customView.clipsToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [customView addSubview: imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(customView).offset(83);
        make.centerX.equalTo(customView);
    }];
    imageView.image = [UIImage imageNamed: @"img_dog_small"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [customView addSubview: titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(imageView.mas_bottom).offset(31);
        make.left.equalTo(customView).offset(38);
        make.right.equalTo(customView).offset(-38);
        make.width.equalTo(@170);
    }];
    titleLabel.text = @"Need your location";
    titleLabel.numberOfLines = 0;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [customView addSubview: contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(titleLabel.mas_bottom).offset(12);
        make.left.right.width.equalTo(titleLabel);
    }];
    contentLabel.text = @"We need to know where you are in order to scan nearby centers";
    contentLabel.numberOfLines = 0;
    
    UIButton *cancelButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [customView addSubview: cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.equalTo(customView);
        make.width.equalTo(customView).multipliedBy(0.5);
        make.height.equalTo(@45);
        make.top.equalTo(contentLabel.mas_bottom).offset(72);
    }];
    [cancelButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [cancelButton setBackgroundColor: [UIColor redColor]];
    [cancelButton setTitle: @"Cancel" forState: UIControlStateNormal];

    UIButton *okButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [customView addSubview: okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.bottom.equalTo(customView);
        make.top.width.height.equalTo(cancelButton);
    }];
    [okButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [okButton setBackgroundColor: [UIColor greenColor]];
    [okButton setTitle: @"OK" forState: UIControlStateNormal];

    MCIconAlertController *iconAlertController = [[MCIconAlertController alloc] init];
    iconAlertController.customView = customView;
    [iconAlertController registLeftButton: cancelButton];
    [iconAlertController registRightButton: okButton];
    iconAlertController.leftButtonTappedBlock = ^{
        NSLog(@"leftButtonTappedBlock");
    };
    iconAlertController.rightButtonTappedBlock = ^{
        NSLog(@"rightButtonTappedBlock");
    };
    [iconAlertController show];
}

@end
