//
//  TTAudioSessionManager.m
//  MobileAir
//
//  Created by Tong on 2019/9/21.
//  Copyright © 2019 芯中芯. All rights reserved.
//

#import "TTAudioSessionManager.h"

void TTAudioSessionManagerNormalPlayerMode(NSError *error) {
    AVAudioSessionCategory category = AVAudioSessionCategoryPlayback;
    AVAudioSessionCategoryOptions options = AVAudioSessionCategoryOptionAllowBluetoothA2DP | AVAudioSessionCategoryOptionDefaultToSpeaker;
    TTAudioSessionManagerSetCategory(category, options, error);
}

void TTAudioSessionManagerIMusicPlayerMode(NSError * error) {
    AVAudioSessionCategory category = AVAudioSessionCategoryPlayback;
    AVAudioSessionCategoryOptions options = AVAudioSessionCategoryOptionAllowBluetoothA2DP | AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionMixWithOthers;
    TTAudioSessionManagerSetCategory(category, options, error);
}

void TTAudioSessionManagerRecorderMode(NSError* _Nullable error) {
    AVAudioSessionCategory category = AVAudioSessionCategoryPlayAndRecord;
    AVAudioSessionCategoryOptions options = AVAudioSessionCategoryOptionAllowBluetoothA2DP | AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionMixWithOthers;
    TTAudioSessionManagerSetCategory(category, options, error);
}

void TTAudioSessionManagerSetActive(BOOL active, NSError* _Nullable error) {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (session.secondaryAudioShouldBeSilencedHint) {
        [session setActive:active withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
        NSLog(@"🐸 获取音频焦点");
    }
}

void TTAudioSessionManagerSetCategory(AVAudioSessionCategory category, AVAudioSessionCategoryOptions options, NSError* _Nullable error) {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (![session.category isEqualToString:category] || session.categoryOptions!=options) {
        [[AVAudioSession sharedInstance] setCategory:category withOptions:options error:&error];
        NSLog(@"🐸 SessionCategory：%@ options: %ld", category, options);
    }
}

@implementation TTAudioSessionManager

#pragma mark - 单例
static id _shareInstance;

+ (instancetype)shareSession {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _shareInstance = [self new];
    });
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [super allocWithZone:zone];
    });
    return _shareInstance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _shareInstance;
}


- (instancetype)init {
    if (self=[super init]) {
        [self addNotiObserver];
    }
    return self;
}

- (void)dealloc {
    [self removeNotiObserver];
}

#pragma mark - ------------- 通知监听 ------------------
- (void)addNotiObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInterruption:) name:AVAudioSessionInterruptionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionRouteChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionMediaServerKill:) name:AVAudioSessionMediaServicesWereLostNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionMediaRestart:) name:AVAudioSessionMediaServicesWereResetNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionOtherAppAudioStartOrStop:) name:AVAudioSessionSilenceSecondaryAudioHintNotification object:nil];
}

- (void)removeNotiObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
}

#pragma mark - ------------- 事件 ------------------

- (void)sessionInterruption:(NSNotification *)noti {
    NSLog(@"音频被打断:%@",noti);
}

- (void)sessionRouteChange:(NSNotification *)noti {
    NSLog(@"音频路由切换:%@",noti);
}

- (void)sessionMediaServerKill:(NSNotification *)noti {
    NSLog(@"Mediakill:%@",noti);
}

- (void)sessionMediaRestart:(NSNotification *)noti {
    NSLog(@"MediaRestart:%@",noti);
}

- (void)sessionOtherAppAudioStartOrStop:(NSNotification *)noti {
    int value = [noti.userInfo[@"AVAudioSessionSilenceSecondaryAudioHintTypeKey"] intValue];
    NSLog(@"其他App播放状态:%d",value);
}

@end
