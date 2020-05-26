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
#ifndef TTLocalized
#define TTLocalized(key)  NSLocalizedString((key), nil)
#endif

/******************************   图片   ******************************/
#define TTGetImage(s) [UIImage imageNamed:(s)]

/******************************   Xib   ******************************/
#define kLoadXibViewWithNibName(n) [[[NSBundle mainBundle] loadNibNamed:(n) owner:nil options:nil] firstObject]

/******************************   Font   ******************************/
#define Font(f)         [UIFont systemFontOfSize:f]
#define FontM(f)        [UIFont fontWithName:@"PingFangSC-Medium" size: f]
#define FontR(f)        [UIFont fontWithName:@"PingFangSC-Regular" size: f]
#define FontS(f)        [UIFont fontWithName:@"PingFangSC-Semibold" size: f]

#define TTFontLight(f)   [UIFont systemFontOfSize:f weight:UIFontWeightLight]
#define TTFontRegular(f) [UIFont systemFontOfSize:f weight:UIFontWeightRegular]
#define TTFontBold(f) [UIFont systemFontOfSize:f weight:UIFontWeightBold]
#define TTFontSemibold(f) [UIFont systemFontOfSize:f weight:UIFontWeightSemibold]
#define TTFontMedium(f) [UIFont systemFontOfSize:f weight:UIFontWeightMedium]

/****************************** iPhone X 系列 ******************************/
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P  (IS_IPHONE && kScreenHeight == 736.0)
#define iPhoneX                ([UIScreen instancesRespondToSelector:@selector(currentMode)]\
                               ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR               ([UIScreen instancesRespondToSelector:@selector(currentMode)]\
                               ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS_Max           ([UIScreen instancesRespondToSelector:@selector(currentMode)] \
                               ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX_All                              [[UIApplication sharedApplication] statusBarFrame].size.height==44.0f
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


/******************************   WeakSelf StrongSelf   ******************************/
#define WS(s)           __weak typeof(self)s =self;
#define WeakSelf(ws)   __weak typeof(self) ws = self;
#define StrongSelf(ss) __strong typeof(ws) ss = ws;

// @weakify(self)
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

// @strongify(self)
#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#endif /* MacroHeader_h */
