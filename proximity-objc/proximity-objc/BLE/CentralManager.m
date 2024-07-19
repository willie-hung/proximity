//
//  CentralManager.m
//  proximity-objc
//
//  Created by 洪崧傑 on 2024/7/18.
//

#import "CentralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@implementation CentralManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        _discoveredPeripherals = [NSMutableArray array];
    }
    return self;
}

- (void)startScanning {
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    NSLog(@"Start scanning peripherals...");
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBManagerStatePoweredOn:
            NSLog(@"Bluetooth is powered on.");
            [self startScanning];
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"Bluetooth is powered off.");
            break;
        case CBManagerStateResetting:
            NSLog(@"Bluetooth is resetting.");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"Bluetooth is unauthorized.");
            break;
        case CBManagerStateUnsupported:
            NSLog(@"Bluetooth is unsupported.");
            break;
        case CBManagerStateUnknown:
            NSLog(@"Bluetooth state is unknown.");
        default:
            NSLog(@"Bluetooth state: %ld", (long)central.state);
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);

    if (self.delegate && [self.delegate respondsToSelector:@selector(didDiscoverPeripheral:)]) {
        [self.delegate didDiscoverPeripheral:peripheral];
    }
}


#pragma mark - CBPeripheralDelegate methods

@end
