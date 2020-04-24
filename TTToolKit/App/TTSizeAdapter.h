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

typedef enum : NSUInteger {
    TTiPhone678,
    TTiPhone678Plus,
    TTiPhoneXXS,
    TTiPhoneXRXSMAX
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


@end

NS_ASSUME_NONNULL_END
