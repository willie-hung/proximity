//
//  CentralManager.h
//  proximity-objc
//
//  Created by 洪崧傑 on 2024/7/18.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CentralManagerDelegate <NSObject>
- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral;
@end

@interface CentralManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) NSMutableArray *discoveredPeripherals;
@property (nonatomic, weak) id<CentralManagerDelegate> delegate;

- (void)startScanning;

@end

//@protocol BluetoothManagerDelegate <NSObject>
//- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral;
//- (void)didConnectToPeripheral:(CBPeripheral *)peripheral;
//- (void)didDiscoverServices:(NSArray<CBService *> *)services forPeripheral:(CBPeripheral *)peripheral;
//- (void)didDiscoverCharacteristics:(NSArray<CBCharacteristic *> *)characteristics forService:(CBService *)service ofPeripheral:(CBPeripheral *)peripheral;
//@end

NS_ASSUME_NONNULL_END
