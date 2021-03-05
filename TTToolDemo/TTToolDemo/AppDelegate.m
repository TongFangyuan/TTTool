//
//  AppDelegate.m
//  TTToolDemo
//
//  Created by 童方园 on 2020/3/28.
//  Copyright © 2020 童方园. All rights reserved.
//

#import "AppDelegate.h"
#import "TTToolKit.h"
#import "TTTestPlayer.h"
#import "ViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSTimer *timer;
@end

#define kMusicSource @"test"
#define kMusirUrl @"http://cvoice.ccsmart.com.cn:8083/files/402882e5715dcf7e01715dcf8b0e0039"
#define KRadioUrl @"http://live.xmcdn.com/live/91/24.m3u8"
#define kNormalUrl @"http://aod.tx.xmcdn.com/group23/M03/EF/21/wKgJNFiGyROzVV_aABNvDBGmegg444.mp3"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupPlayer];
    
    [[TTPhonePlayerTool shareTool] playMusic:kMusirUrl source:kMusicSource];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(progressupdate:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc] init];
    TTBaseNavigationController *nav = [[TTBaseNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    return YES;
}

- (void)setupPlayer {
    
    [[TTPhonePlayerTool shareTool] registerSource:kMusicSource playerClass:[TTTestPlayer class]];
}

- (void)progressupdate:(NSTimer *)timer {
    CGFloat position = [TTPhonePlayerTool shareTool].position;
    CGFloat duration = [TTPhonePlayerTool shareTool].duration;
    CGFloat currentTime = [TTPhonePlayerTool shareTool].currentTime;
    
    TTLog(@"position:%.1f duration:%.1f currentTime:%.1f", position, duration, currentTime);
}

@end
