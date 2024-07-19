//
//  ViewController.h
//  proximity-objc
//
//  Created by 洪崧傑 on 2024/7/17.
//

#import <UIKit/UIKit.h>
#import "CentralManager.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) CentralManager *centralManager;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<CBPeripheral *> *discoveredPeripherals;

@end

