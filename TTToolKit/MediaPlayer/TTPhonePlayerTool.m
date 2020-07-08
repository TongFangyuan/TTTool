//
//  TTPhonePlayerTool.m
//  MobileAir
//
//  Created by Tong on 2019/8/26.
//  Copyright © 2019 芯中芯. All rights reserved.
//

#import "TTPhonePlayerTool.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TTPhonePlayerTool ()<TTMusicPlayerStatusDelegate>

@property (nonatomic, strong, readwrite) id<TTMusicPlayerObject> player;
@property (nonatomic, strong) dispatch_semaphore_t lock;

/**
 播放器类型管理
 */
@property (nonatomic,strong) NSMutableDictionary *clsManager;
@property (nonatomic,strong) NSMutableArray<id <TTPhonePlayToolObserver>> *observers;

@end


@implementation TTPhonePlayerTool

#pragma mark - 单例
static id _shareInstance;

+ (instancetype)shareTool {
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
        self.clsManager = [NSMutableDictionary dictionary];
        self.localControl = kLocalPlaySpeechTypePlay;
        self.observers = [NSMutableArray array];
    }
    return self;
}

#pragma mark - ------------- PhonePlayToolObject ------------------
- (void)playMusic:(NSString *)url source:(nonnull TTMediaSourceName)source {
    [self stop];
    self.player = [self playerWithSource:source];
    self.player.delegate = self;
    self.player.playMode = self.playMode;
    [self.player play:url];
}

- (void)playMusicWithAlbum:(nonnull id<TTAlbumTrackProtocol>)album source:(nonnull TTMediaSourceName)source {
    [self stop];
    self.player = [self playerWithSource:source];
    self.player.delegate = self;
    self.player.playMode = self.playMode;
    [self.player playAlbum:album];
}

- (void)playMusics:(nonnull NSArray<id<TTAlbumTrackProtocol>> *)albums
             index:(NSInteger)index
            source:(nonnull TTMediaSourceName)source
{
    [self stop];
    
    id<TTMusicPlayerObject> player = [self playerWithSource:source];
    player.delegate = self;
    self.player = player;
    self.player.playMode = self.playMode;
    
    id<TTAlbumTrackProtocol> album = albums[index];
    self.currentTrackIndex = index;
    self.albumTracks = albums.copy;
    self.albumTrack = album;
    self.needContinue = YES;
    
    [player play:albums index:index];
}

- (void)allStop {
    [self stopMusicPlayer];
    [self stopTTSPlayer];
}

- (void)continuePlay {
    
    [self.player continuePlay];
    
    self.needContinue = YES;
    self.manualPause = NO;
}

- (void)interruptPause {
    
    [self pauseMusicPlayer];
    
    if (self.manualPause) {
        self.needContinue = NO;
    } else {
        self.needContinue = YES;
    }
}

- (void)operate {
    [self setLockScreenNowPlayingInfo:self.albumTrack];
}

- (void)pause {
    
    [self stopTTSPlayer];
    [self pauseMusicPlayer];
    
    if (self.manualPause) {
        self.needContinue = NO;
    } else {
        self.needContinue = YES;
    }
}


- (void)playControl:(LocalPlaySpeechType)control {
    //Fix: 爱音乐无法恢复播放的问题
    //    if (!self.albumTrack) {
    //        NSLog(@"没有专辑信息，不接着走");
    //        return;
    //    }
    
    switch (control) {
        case kLocalPlaySpeechTypePlay:
        {
            if (self.manualPause)
            {
                NSLog(@"手动暂停，不继续播放");
                return;
            }
            [self continuePlay];
            break;
        }
        case kLocalPlaySpeechTypePause:
        {
            [self pause];
            break;
        }
        case kLocalPlaySpeechTypePrev:
        {
            [self playPrevious];
            break;
        }
        case kLocalPlaySpeechTypeNext:
        {
            [self playNext];
            break;
        }
        case kLocalPlaySpeechTypeStop:
        {
            [self stop];
            break;
        }
        default:
            break;
    }
}

- (void)playNext {
    [self.player next];
    [self playNextSongToMatchInfo];
}

- (void)playPrevious {
    [self.player previous];
    [self playNextSongToMatchInfo];
}

- (void)setLockScreenNowPlayingInfo:(id<TTAlbumTrackProtocol>)music {
    if (!music||[music isKindOfClass:[NSNull class]]) return;
    
    if ([AVAudioSession sharedInstance].categoryOptions == AVAudioSessionCategoryOptionDuckOthers) {
        return;
    }
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    // 专辑
    //info[MPMediaItemPropertyAlbumTitle] = music.nickname;
    // 标题(音乐名称)
    info[MPMediaItemPropertyTitle] = music.songName;
    // 作者
    info[MPMediaItemPropertyArtist] = music.singer;
    // 显示播放时间和剩余时间及进度
    
    // 图片
    if (music.lockImage) {
        info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:music.lockImage];
    } else if (music.imageUrl && [music.imageUrl isEqualToString:@""] == NO) {
    }
    info[MPMediaItemPropertyPlaybackDuration] = @(self.duration);
    info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(self.currentTime);
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:info];
}

- (void)stop {
    [self stopMusicPlayer];
}

- (void)playNextSongToMatchInfo {
    
    self.isMediaPlaying = YES;
    self.manualPause = NO;
    self.currentTrackIndex = self.player.currentTrackIndex;
    self.albumTrack = (id<TTAlbumTrackProtocol>)self.player.albumTrack;
}

- (float)position
{
    return self.player.position;
}

- (void)setPosition:(float)position
{
    [self.player seekToPosition:position];
}

- (float)loadedPostion {
    return self.player.loadedPostion;
}

- (NSString *)currentTimeText
{
    return self.player.currentTimeText;
}

- (NSString *)durationText
{
    return self.player.durationText;
}

- (float)currentTime
{
    return self.player.currentTime;
}

- (float)duration
{
    return self.player.duration;
}

- (BOOL)isMediaPlaying {
    return self.player.isPlaying;
}

- (void)setPlayMode:(TTPhonePlayMode)playMode {
    self.player.playMode = playMode;
    NSLog(@"🔋 播放模式：%@", [TTBaseMusicPlayer TTMusicPlayerModeDesc:playMode]);
    _playMode = playMode;
}

- (NSString *)mediaSource {
    return [self mediaSourceForPlayer:self.player];
}

- (dispatch_semaphore_t)lock {
    if (!_lock) {
        _lock = dispatch_semaphore_create(1);
    }
    return _lock;
}

#pragma mark - ------------- 播放器状态 ------------------
- (void)playerWillStart:(id<TTMusicPlayerObject>)player {
//    NSLog(@"🔥 playerWillStart");
    
    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        
        if ([obj respondsToSelector:@selector(musicPlayer:changeState:)]) {
            [obj musicPlayer:player changeState:TTPlayerStateLoading];
        }
    
    if (player.albumTrack) {
            if ([obj respondsToSelector:@selector(musicPlayer:updateAlbumTrack:)]) {
                [obj musicPlayer:player updateAlbumTrack:player.albumTrack];
            }
            }
        }
    
    if (player.albumTrack) {
        self.currentTrackIndex = player.currentTrackIndex;
        self.albumTrack = player.albumTrack;
    }
}
- (void)playerDidStart:(id<TTMusicPlayerObject>)player{
//    NSLog(@"🔥 playerDidStart");
    
    self.isMediaPlaying = player.isPlaying;
    [[TTPhonePlayerTool shareTool] operate];
    if (player.albumTrack) {
        self.currentTrackIndex = player.currentTrackIndex;
        self.albumTrack = player.albumTrack;
    }
    
    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayingStateChange:)]) {
            [obj didPlayingStateChange:self.isMediaPlaying];
        }
        
        if ([obj respondsToSelector:@selector(musicPlayer:changeState:)]) {
            [obj musicPlayer:player changeState:TTPlayerStateStarted];
        }
    }
    
}

- (void)playerDidPaused:(id<TTMusicPlayerObject>)player{
//    NSLog(@"🔥 playerDidPaused");

    
    self.isMediaPlaying = player.isPlaying;
    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayingStateChange:)]) {
            [obj didPlayingStateChange:self.isMediaPlaying];
        }
        
        if ([obj respondsToSelector:@selector(musicPlayer:changeState:)]) {
            [obj musicPlayer:player changeState:TTPlayerStatePaused];
        }
    }
}
- (void)playerDidFinished:(id<TTMusicPlayerObject>)player{
//    NSLog(@"🔥 playerDidFinished");

    self.isMediaPlaying = player.isPlaying;
    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayingStateChange:)]) {
            [obj didPlayingStateChange:self.isMediaPlaying];
        }
        
        if ([obj respondsToSelector:@selector(musicPlayer:changeState:)]) {
            [obj musicPlayer:player changeState:TTPlayerStateFinshed];
        }
    }
}
- (void)playerDidContiuPlay:(id<TTMusicPlayerObject>)player{
//    NSLog(@"🔥 playerDidContiuPlay");

    self.isMediaPlaying = player.isPlaying;
    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayingStateChange:)]) {
            [obj didPlayingStateChange:self.isMediaPlaying];
        }
        if ([obj respondsToSelector:@selector(musicPlayer:changeState:)]) {
            [obj musicPlayer:player changeState:TTPlayerStateResume];
        }
    }
}
- (void)player:(id<TTMusicPlayerObject>)player playError:(NSError *)error{
//    NSLog(@"🔥 playError: %@",error);

    self.isMediaPlaying = player.isPlaying;
    [self playNext];
    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayingStateChange:)]) {
            [obj didPlayingStateChange:self.isMediaPlaying];
        }
    }
}
- (void)playerBufferFull:(id<TTMusicPlayerObject>)player{
//    NSLog(@"🔥 playerBufferFull");

    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayerBufferFull)]) {
            [obj didPlayerBufferFull];
        }
    }
}
- (void)playerBufferEmpty:(id<TTMusicPlayerObject>)player{
//    NSLog(@"🔥 playerBufferEmpty");

    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayerBufferEmpty)]) {
            [obj didPlayerBufferEmpty];
        }
    }
}
- (void)player:(id<TTMusicPlayerObject>)player didSeekToPostion:(CGFloat)postion{
//    NSLog(@"🔥 didSeekToPostion");

    self.isMediaPlaying = player.isPlaying;
    for (id<TTPhonePlayToolObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(didPlayingStateChange:)]) {
            [obj didPlayingStateChange:self.isMediaPlaying];
        }
        if ([obj respondsToSelector:@selector(didSeekToPosition:)]) {
            [obj didSeekToPosition:postion];
        }
    }
}
- (void)player:(id<TTMusicPlayerObject>)player playToPostion:(CGFloat)postion{
//    NSLog(@"🔥 playToPostion");

    for (id<TTPhonePlayToolObserver> obj in self.observers) {
       if ([obj respondsToSelector:@selector(didPlayToPosition:)]) {
            [obj didPlayToPosition:postion];
        }
    }
}
- (void)player:(id<TTMusicPlayerObject>)player cacheToPostion:(CGFloat)postion {
//    NSLog(@"🔥 cacheToPostion");

    for (id<TTPhonePlayToolObserver> obj in self.observers) {
       if ([obj respondsToSelector:@selector(didCacheToPostion:)]) {
           [obj didCacheToPostion:postion];
       }
    }
}

#pragma mark - ---- Application 事件处理 ----
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [TTPhonePlayerTool shareTool].isForeground = NO;
    [[TTPhonePlayerTool shareTool] operate];
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    [TTPhonePlayerTool shareTool].isForeground = YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
        {
            [[TTPhonePlayerTool shareTool] continuePlay];
        }
            break;
        case UIEventSubtypeRemoteControlTogglePlayPause:
        case UIEventSubtypeRemoteControlPause:
        {
            [TTPhonePlayerTool shareTool].manualPause = YES;
            [[TTPhonePlayerTool shareTool] pause];
        }
            break;
        case UIEventSubtypeRemoteControlNextTrack:
        {
            [[TTPhonePlayerTool shareTool] playNext];
        }
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
        {
            [[TTPhonePlayerTool shareTool] playPrevious];
        }
            break;
        default:
            break;
    }
}

@end



#pragma mark - ------------- 播放器注册分类  ------------------
@implementation TTPhonePlayerTool (PlayerRegister)

- (void)registerSource:(TTMediaSourceName)source playerClass:(Class)cls {
    [self.clsManager setObject:cls forKey:source];
}

- (nullable Class)playerClassForSource:(TTMediaSourceName)source {
    return self.clsManager[source];
}

- (nullable id<TTMusicPlayerObject>)playerWithSource:(TTMediaSourceName)source {
    Class cls = [self playerClassForSource:source];
    if (cls) {
        return  (id<TTMusicPlayerObject>)[cls new];
    }
    NSAssert(0, @"⚠️ 未注册播放器");
    return nil;
}

- (nullable NSString *)mediaSourceForPlayer:(id)player {
    for (NSString *source in self.clsManager) {
        Class class = [self.clsManager objectForKey:source];
        if ([player isKindOfClass:class]) {
            return source;
        }
    }
    return nil;
}

@end

#pragma mark - ------------- TTS播放器控制分类 ------------------
@implementation TTPhonePlayerTool (TTSPlayer)

- (void)playTTSUrls:(NSArray<NSString *> *)urls
             source:(TTMediaSourceName)source {
    [self playTTSUrls:urls source:source callback:nil];
}
- (void)playTTSUrls:(NSArray<NSString *> *)urls
             source:(TTMediaSourceName)source
           callback:(nullable void(^)(void))callback {
    //MARK: 解决语音切换上下首，TTS和音乐同时播放的问题
    //延时一段时间暂停音乐播放器
    [self performSelector:@selector(pauseMusicPlayer) withObject:nil afterDelay:0.5];
    [self stopTTSPlayer];
    
    id<TTTTSPlayerProtocol> player = (id<TTTTSPlayerProtocol>)[self playerWithSource:source];
    [player play:urls callback:callback];
    self.ttsPLayer = player;
}

- (void)playTTSDatas:(NSArray<NSData *> *)datas source:(TTMediaSourceName)source {
    [self playTTSDatas:datas source:source callback:nil];
}

- (void)playTTSDatas:(NSArray<NSData *> *)datas source:(TTMediaSourceName)source  callback:(nullable void(^)(void))callback {
    NSLog(@"未实现的功能");
}

- (void)stopTTSPlayer {
    if (self.ttsPLayer.isPlaying) {
        [self.ttsPLayer pause];
        [self.ttsPLayer stop];
        [self.ttsPLayer resetPlayer];
        NSLog(@"🦆 停掉之前的TTS");
    }
}
@end

#pragma mark - ------------- 音乐播放器控制分类 ------------------
@implementation TTPhonePlayerTool (MusicPlayer)

- (void)pauseMusicPlayer {
    [self.player pause];
}

- (void)stopMusicPlayer {
    [self.player stop];
}

- (void)manualPauseMusic {
    self.manualPause = YES;
    [self.player pause];
}

- (void)manualPlayMusic {
    self.manualPause = NO;
    [self.player continuePlay];
}

- (void)seekMusicToPosition:(CGFloat)position {
    [self.player seekToPosition:position];
}

- (void)addObserver:(id<TTPhonePlayToolObserver>)observer {
    if (![self.observers containsObject:observer]) {
        TT_LOCK(self.lock);
        [self.observers addObject:observer];
        TT_UNLOCK(self.lock);
    }
}

- (void)removeObserver:(id<TTPhonePlayToolObserver>)observer {
    if ([self.observers containsObject:observer]) {
        TT_LOCK(self.lock);
        [self.observers removeObject:observer];
        TT_UNLOCK(self.lock);
    }
}

@end


#pragma mark - ------------- 辅助方法 ------------------
extern BOOL TTPhonePlayerToolIsIMusicPlayer(void) {
    id player = [TTPhonePlayerTool shareTool].player;
    if (!player) return NO;
    TTMediaSourceName source = [[TTPhonePlayerTool shareTool] mediaSourceForPlayer:player];
    return [source isEqualToString:TTMediaSourceIMusic];
}

extern BOOL TTPhonePlayerToolIsRadioStationPlayer(void) {
    id player = [TTPhonePlayerTool shareTool].player;
    if (!player) return NO;
    TTMediaSourceName source = [[TTPhonePlayerTool shareTool] mediaSourceForPlayer:player];
    return [source isEqualToString:TTMediaSourceRadioStation];
}

extern BOOL TTPhonePlayerToolIsSelfPlayTTS(void) {
    id player = [TTPhonePlayerTool shareTool].player;
    if (!player) return NO;
    TTMediaSourceName source = [[TTPhonePlayerTool shareTool] mediaSourceForPlayer:player];
    return [source isEqualToString:TTMediaSourceRadioStation] || [source isEqualToString:TTMediaSourceIMusic];
}
