//
//  NSBundle+TTToolKit.m
//  CVoice2
//
//  Created by Tong on 2020/4/26.
//  Copyright © 2020 CChip. All rights reserved.
//

#import "NSBundle+TTToolKit.h"

@implementation NSBundle (TTToolKit)

+ (instancetype)tt_toolBundle
{
    static NSBundle *toolBundle = nil;
    if (toolBundle == nil) {
        toolBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:NSClassFromString(@"TTBaseViewController")] pathForResource:@"TTToolKit" ofType:@"bundle"]];
    }
    return toolBundle;
}

+ (UIImage *)tt_blackBackImage
{
    static UIImage *blackBackImage = nil;
    if (blackBackImage == nil) {
        blackBackImage = [[UIImage imageWithContentsOfFile:[[self tt_toolBundle] pathForResource:@"nav_back_black@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return blackBackImage;
}

+ (UIImage *)tt_whiteBackImage
{
    static UIImage *whiteBackImage = nil;
    if (whiteBackImage == nil) {
        whiteBackImage = [[UIImage imageWithContentsOfFile:[[self tt_toolBundle] pathForResource:@"nav_back_white@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return whiteBackImage;
}

+ (NSString *)tt_localizedStringForKey:(NSString *)key value:(nullable NSString *)value
{
    // 暂未实现
    return key;
}

+ (NSString *)tt_localizedStringForKey:(NSString *)key
{
    return [self tt_localizedStringForKey:key value:nil];
}

@end
