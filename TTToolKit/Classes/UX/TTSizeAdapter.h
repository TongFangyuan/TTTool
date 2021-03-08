//
//  TTViewSizeAdapter.h
//  TTToolSamples
//
//  Created by Tong on 2019/8/6.
//  Copyright © 2019 tongfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CGWS(f) [TTSizeAdapter.share scaleWidth:f] //宽度缩放
#define CGSS(s) [TTSizeAdapter.share scaleSize:s]  // size 缩放
#define CGHS(f) [TTSizeAdapter.share scaleHegiht:f] // 高度缩放
#define CGCP(pt, s)  [[TTSizeAdapter share] convertPt:pt scale:s]
#define CGCS(sz, s)  [[TTSizeAdapter share] convertSize:sz scale:s]

#define TTSH(f) [[TTSizeAdapter share] scaleHegiht:f]
#define TTSW(f) [[TTSizeAdapter share] scaleWidth:f]

// 是否为刘海屏系列手机
#define TTIsiPhoneXAll TTSizeAdapter.share.isiPhoneXAll

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TTiPhone55S      = 0,            // 320x568  iPhone 5/5S/5C/SE
    TTiPhone678      = 1 << 0,       // 375x667  iPhone 6/6S/7/8
    TTiPhone678Plus  = 1 << 1,       // 414x736  iPhone 6/6S/7/8 Plus
    TTiPhoneXXS      = 1 << 2,       // 375x812  iPhone X/XS/11 Pro/12 mini
    TTiPhoneXRXSMAX  = 1 << 3,       // 414x896  iPhone XR/11/XS Max/11 Pro Max
    TTiPhone12       = 1 << 4,       // 390x844  iPhone 12/12 Pro
    TTiPhone12ProMax = 1 << 5,       // 428x926  iPhone 12 Pro Max
    TTiPhoneXAll     = TTiPhoneXXS|TTiPhoneXRXSMAX|TTiPhone12|TTiPhone12ProMax, // 所有刘海屏机型
} TTiPhone;

/**
 * 尺寸适配器,主要是宽度适配
 */
@interface TTSizeAdapter : NSObject

/**
 ⚠️ 标注图中的机型，必选在Appdelegate中设置
 */
@property (nonatomic, assign) TTiPhone markIPhone;

/**
 当前机型，内部自动设置
 */
@property (nonatomic, assign, readonly) TTiPhone currentIPhone;

@property (nonatomic, assign, readonly) BOOL isiPhoneXAll;

+ (nonnull instancetype)share;

/**
 适配宽度

 @param width 标注图上的宽度
 */
- (CGFloat)scaleWidth:(CGFloat)width;

/**
 适配高度

 @param height 标注图上的高度
 */
- (CGFloat)scaleHegiht:(CGFloat)height;


/// size适配，根据机型和标注图宽度比进行缩放
/// @param size size description
- (CGSize)scaleSize:(CGSize)size;

/// pt缩放
- (CGFloat)convertPt:(CGFloat)pt scale:(CGFloat)scale;
/// size缩放
- (CGSize)convertSize:(CGSize)size scale:(CGFloat)scale;


@end

@interface TTAdapterItem : NSObject

/// 根据传入数组取值，赋值顺序依次为TTiPhone678、TTiPhone678Plus、TTiPhoneXXS、TTiPhoneXRXSMAX、TTiPhone55S、iPhone 12/12 Pro、iPhone 12 Pro Max
/// @param floats 数组
+ (instancetype)itemWithFloats:(NSArray<NSNumber *> *)floats;

/// 赋值不同机型的值
/// @param dict 字典配置，如下：
/// @{
///    @(TTiPhone678):@(20),
///    @(TTiPhone678Plus):@(30)
/// }
+ (instancetype)itemWithDict:(NSDictionary *)dict;

/// 默认取iPhone6机型的值
- (CGFloat)fittingFloat;

@end


NS_ASSUME_NONNULL_END
