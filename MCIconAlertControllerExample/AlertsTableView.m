//
//  AlertsTableView.m
//  MCIconAlertControllerExample
//
//  Created by Chao Ma on 08/19/2016.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import "AlertsTableView.h"
#import "AlertTableViewCell.h"

static NSString * const kAlertsTableViewCellIdentifier = @"AlertsTableViewCellIdentifier";

@interface AlertsTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation AlertsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self == nil) {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    self.estimatedRowHeight = 44;
    self.rowHeight = UITableViewAutomaticDimension;
    self.sectionFooterHeight = 0.0;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[AlertTableViewCell class] forCellReuseIdentifier:kAlertsTableViewCellIdentifier];
    
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAlertsTableViewCellIdentifier];
    if (cell == nil)
        cell = [[AlertTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAlertsTableViewCellIdentifier];
    
    cell.cellData = self.dataArray[indexPath.row];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    titleLabel.text = @"Examples";
    
    return titleLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellTappedBlock) {
        self.cellTappedBlock(indexPath, self.dataArray[indexPath.row]);
    }
}

@end
