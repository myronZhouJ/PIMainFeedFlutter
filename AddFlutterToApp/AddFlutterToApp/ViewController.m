//
//  ViewController.m
//  AddFlutterToApp
//
//  Created by Myron on 2020/11/11.
//

#import "ViewController.h"
#import "AppDelegate.h"
@import Flutter;

@interface ViewController () <FlutterStreamHandler>
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@property (nonatomic,strong) FlutterMethodChannel* methodChannel;
//单项管道，有可能使用多次
@property (nonatomic, copy) FlutterEventSink eventSink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
//      // Runs the default Dart entrypoint with a default Flutter route.
//    [self.flutterEngine run];
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //[self clickStore:0];
}

-(IBAction)clickInit:(id)sender{
    if (!self.flutterEngine) {
//        self.flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
//          // Runs the default Dart entrypoint with a default Flutter route.
//        [self.flutterEngine run];
    }
}

-(IBAction)clickDeinit:(id)sender{
    [self.flutterEngine destroyContext];
    self.flutterEngine = nil;
}

-(IBAction)clickA:(id)sender{
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithProject:nil initialRoute:@"PIFlutterPA" nibName:nil bundle:nil];
    [self presentViewController:flutterViewController animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1000 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.methodChannel invokeMethod:@"flutter_display_user_info" arguments:@{@"json": @"{\"name\":\"ZhouJing\",\"avatar\":\"www.pikicast.com\"}"} result:^(id  _Nullable result) {
                
            }];
        });
    }];
    
    //MethodChannel
    self.methodChannel = [FlutterMethodChannel
                                              methodChannelWithName:@"com.pikicast.pikicast/API"
                                              binaryMessenger:flutterViewController.binaryMessenger];
     __weak typeof(self) weakSelf = self;
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      if ([@"batteryLevel" isEqualToString:call.method]) {
        int batteryLevel = [weakSelf getBatteryLevel];
        if (batteryLevel == -1) {
          result([FlutterError errorWithCode:@"UNAVAILABLE"
                                     message:@"Battery info unavailable"
                                     details:nil]);
        } else {
          result(@(batteryLevel));
        }
      }else if ([@"signIn" isEqualToString:call.method]) {
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              weakSelf.eventSink(@"{\"name\":\"ZhouJing\",\"token\":\"123ade45345dsf\"}");
          });
      }else {
        result(FlutterMethodNotImplemented);
      }
    }];
    
    //EventChannel
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"example.eventChannel" binaryMessenger:flutterViewController.binaryMessenger];
    [eventChannel setStreamHandler:self];
    
    
    //BasicMessageChannel
    FlutterBasicMessageChannel *basicMessageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"example.basicMessageChannel" binaryMessenger:flutterViewController.binaryMessenger codec:FlutterStringCodec.new];
    [basicMessageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        NSLog(@"Received from Flutter: %@", message);
        NSInteger value = [message intValue] + 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            callback([NSString stringWithFormat:@"Hello %ld", value]);
        });
    }];
    
    
    __block void (^sendBlock)(NSString *message) = ^(NSString *message){
        [basicMessageChannel sendMessage:message reply:^(id  _Nullable reply) {
            NSLog(@"Received from Flutter: %@", reply);
            NSString *prefix = @"Hello-";
            NSInteger value = [[reply substringFromIndex:prefix.length] intValue] + 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                sendBlock([NSString stringWithFormat:@"%@%ld", prefix, value]);
            });
        }];
    };
//    sendBlock(@"Hello-0");
}

-(IBAction)clickStore:(id)sender{
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithProject:nil initialRoute:@"/" nibName:nil bundle:nil];
    
    self.methodChannel = [FlutterMethodChannel
                                              methodChannelWithName:@"com.pikicast.pikicast/API"
                                              binaryMessenger:flutterViewController.binaryMessenger];

    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([call.arguments isKindOfClass:[NSDictionary class]]) {
            
            NSLog(@"%@-%@", call.method, call.arguments);
            
            NSDictionary *arguments = call.arguments;
            NSString * method = arguments[@"METHOD"];
            NSDictionary * PARAMETERS = arguments[@"PARAMETERS"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (1) {
                    result(@"{\"data\":{\
                                        \"liveEditorList\":[{\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":1},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":1},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhouingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0},\
                           {\"identifier\":12345,\"name\":\"zhoujingM\",\"avatar\":\"/A00/2019/09/05/A00_26957104_1567669736.png\",\"isLive\":0}]}}");
                }else{
                    result(@"{\"error\":{\"code\":\"ES11\",\"message\":\"I am error\"}}");
                }
            });
        }}];
    
    [self presentViewController:flutterViewController animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(180 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

// 原生中获取电池电量的方法
- (int)getBatteryLevel {
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}


#pragma --mark FlutterStreamHandler代理
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    if (events) {
        self.eventSink  = events;
    }
    return nil;
}

// 不再需要向Flutter传递消息
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}
@end
