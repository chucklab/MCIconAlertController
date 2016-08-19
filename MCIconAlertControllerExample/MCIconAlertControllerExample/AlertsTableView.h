//
//  AlertsTableView.h
//  MCIconAlertControllerExample
//
//  Created by Chao Ma on 08/19/2016.
//  Copyright © 2016 iMegatron's Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CellTappedBlock)(NSIndexPath *indexPath, NSString *cellData);

@interface AlertsTableView : UITableView

@property (nonatomic, copy) CellTappedBlock cellTappedBlock;
@property (nonatomic, strong) NSArray *dataArray;

@end
