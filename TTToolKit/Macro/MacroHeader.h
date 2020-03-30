//
//  MacroHeader.h
//  TTToolSamples
//
//  Created by Tong on 2019/6/14.
//  Copyright © 2019 tongfy. All rights reserved.
//

#ifndef MacroHeader_h
#define MacroHeader_h

/******************************   主线程   ******************************/
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

/******************************   语言国际化   ******************************/
#ifndef Localized
#define Localized(key)  NSLocalizedString((key), nil)
#endif

/******************************   自定义Log   ******************************/
#ifdef DEBUG
#define NSLog(fmt,...) NSLog((@"[%s:%d行] " fmt),[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,##__VA_ARGS__)
#else
#define NSLog(...)
#endif

/******************************   图片   ******************************/
#define TTGetImage(s) [UIImage imageNamed:(s)]

/******************************   Xib   ******************************/
#define kLoadXibViewWithNibName(n) [[[NSBundle mainBundle] loadNibNamed:(n) owner:nil options:nil] firstObject]

/******************************   Font   ******************************/
#define Font(f)         [UIFont systemFontOfSize:f]
#define FontM(f)        [UIFont fontWithName:@"PingFangSC-Medium" size: f]
#define FontR(f)        [UIFont fontWithName:@"PingFangSC-Regular" size: f]

/****************************** iPhone X 系列 ******************************/
#define iPhoneX                ([UIScreen instancesRespondToSelector:@selector(currentMode)]\
                               ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR               ([UIScreen instancesRespondToSelector:@selector(currentMode)]\
                               ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS_Max           ([UIScreen instancesRespondToSelector:@selector(currentMode)] \
                               ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX_All                              (iPhoneX || iPhoneXR || iPhoneXS_Max)
#define k_Height_NavContentBar                   44.0f
#define k_Height_StatusBar                       (iPhoneX_All? 44.0 : 20.0)
#define k_Height_NavBar                          (iPhoneX_All ? 88.0 : 64.0)
#define k_Height_TabBar                          (iPhoneX_All ? 83.0 : 49.0)
#define kStringFormat(serverIP,urlString)        [NSString stringWithFormat:@"%@%@", serverIP, urlString]
#define kCustomColor(r, g, b)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight    44.0
#define kTabBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight       (kStatusBarHeight + kNavBarHeight)

#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

#define WS(s)           __weak typeof(self)s =self;

/******************************   Color   ******************************/
#define kSepertorColor    [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00]
#define kButtonTintColor  [UIColor colorWithRed:0.95 green:0.55 blue:0.00 alpha:1.00]
#define kTextWhiteColor   [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1.00]
#define kTextGrayColor    [UIColor colorWithRed:0.56 green:0.55 blue:0.57 alpha:1.00]
#define kBlackGrayColor   [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.00]
#define kBlackColor       [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.00]

#endif /* MacroHeader_h */
