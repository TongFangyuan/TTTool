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

typedef enum : NSUInteger {
    TTiPhone678,     // 375x667  (iPhone 6/6S/7/8)
    TTiPhone678Plus, // 414x736  (iPhone 6/6S/7/8 Plus)
    TTiPhoneXXS,     // 375x812  (iPhone X/XS/11 Pro)
    TTiPhoneXRXSMAX, // 414x896  (iPhone XR/11/XS Max/11 Pro Max)
    TTiPhone55S      // 320x568  (iPhone 5/5S/5C/SE)
} TTiPhone;

NS_ASSUME_NONNULL_BEGIN

/**
 * 尺寸适配器,主要是宽度适配
 *
 * <#Discussion#>
 *
 * @note <#note#>
 * @attention <#attention#>
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

+ (nonnull instancetype)share;

/**
 适配宽度

 @param width 标注图上的宽度
 @return <#return value description#>
 */
- (CGFloat)scaleWidth:(CGFloat)width;

/**
 适配高度

 @param height 标注图上的高度
 @return <#return value description#>
 */
- (CGFloat)scaleHegiht:(CGFloat)height;


/// size适配，根据机型和标注图宽度比进行缩放
/// @param size <#size description#>
- (CGSize)scaleSize:(CGSize)size;

/// pt缩放
- (CGFloat)convertPt:(CGFloat)pt scale:(CGFloat)scale;
/// size缩放
- (CGSize)convertSize:(CGSize)size scale:(CGFloat)scale;


@end

NS_ASSUME_NONNULL_END
