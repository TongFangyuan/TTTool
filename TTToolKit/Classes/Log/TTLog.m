//
//  TTLog.m
//  TTToolDemo
//
//  Created by Tong on 2020/5/13.
//  Copyright © 2020 童方园. All rights reserved.
//

#import "TTLog.h"

@implementation TTLog
+ (void)load {
    [TTLog performSelector:@selector(share) withObject:nil];
}

#pragma mark - 单例
static id _shareInstance;

+ (instancetype)share {
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
        self.enable = YES;
    }
    return self;
}

+ (void)log:(NSString *)format , ... NS_FORMAT_FUNCTION(1, 2) {
    if (TTLog.share.enable==NO)
    {
        return;
    }
    
    va_list args;
    
    va_start(args, format);
    
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    NSLog(@"%@", str);
}

+ (void)setEnable:(BOOL)enable {
    TTLog.share.enable = enable;
}

+ (BOOL)enable {
    return TTLog.share.enable;
}

@end
