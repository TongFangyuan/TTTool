//
//  TTTabBarController.h
//  CVoice2
//
//  Created by Tong on 2020/4/26.
//  Copyright © 2020 CChip. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TTTabBarStyleDefault,
    TTTabBarStyleOnlyShowImage,
} TTTabBarStyle;

@interface TTBaseTabBarController : UITabBarController

@property (nonatomic, assign) TTTabBarStyle style;

/// 添加子控制器
/// @param childVc 子控制器实例化对象
/// @param title 标题
/// @param image tabbar image
/// @param selectedImage tabbar selectedImage
/// @param cls 是否包含在导航控制器内部，如果包含传入类名，否则传nil
- (void)addChilVC:(UIViewController *)childVc
            title:(NSString *)title
            image:(NSString *)image
    selectedImage:(NSString *)selectedImage
           navCls:(_Nullable Class)cls;

@end

NS_ASSUME_NONNULL_END
