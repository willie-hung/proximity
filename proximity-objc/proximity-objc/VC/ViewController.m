//
//  ViewController.m
//  proximity-objc
//
//  Created by 洪崧傑 on 2024/7/17.
//

#import "ViewController.h"

@implementation ViewController

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.discoveredPeripherals = [NSMutableArray array];
    
    // Set up the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // auto layout
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
    
    // Set up the Central manager
    self.centralManager = [[CentralManager alloc] init];
    self.centralManager.delegate = self;
//    [self.centralManager startScanning];
}

#pragma mark - CentralManagerDelegate

- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral {
    if (![self.discoveredPeripherals containsObject:peripheral]) {
        [self.discoveredPeripherals addObject:peripheral];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.discoveredPeripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PeripheralCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    CBPeripheral *peripheral = self.discoveredPeripherals[indexPath.row];
    cell.textLabel.text = peripheral.name ? peripheral.name : @"Unknown Device";
    cell.detailTextLabel.text = peripheral.identifier.UUIDString;
    
    return cell;
}

@end
