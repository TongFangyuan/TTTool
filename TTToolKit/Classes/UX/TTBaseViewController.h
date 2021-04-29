//
//  TTBaseViewController.h
//  CVoice2
//
//  Created by Tong on 2020/4/26.
//  Copyright © 2020 CChip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TTUIThemeDefalut, // 默认,白色主题
    TTUIThemeLight,   // 白色
    TTUIThemeDark     // 黑色
} TTUITheme;

@interface TTBaseViewController : UIViewController<TTNavbarAppearance>

#pragma mark - < StatusBar Config >
@property (nonatomic,assign) TTUITheme statusBarTheme DEPRECATED_MSG_ATTRIBUTE("废弃");
@property (nonatomic,assign) BOOL      hiddenStatusBar DEPRECATED_MSG_ATTRIBUTE("废弃");

#pragma mark - < Mask Config>
@property (nonatomic,assign) BOOL showMask;
@property (nonatomic,assign) BOOL enableGestureUnderMask;

#pragma mark - < NavigationBar Config >

/// 标题字体
@property (nonatomic,strong) UIFont   *navBarTitleFont;

/// 标题颜色
@property (nonatomic,copy)   NSString *navBarTitle;

/// 返回按钮图标
@property (nonatomic,strong) UIImage  *navBarBackImage;

/// navBar 背景色
@property (nonatomic,strong) UIColor  *navBarTintColor;

/// 标题颜色
@property (nonatomic,strong) UIColor *navTitleColor;

/// ⚠️⚠️ 控制导航栏的隐藏请直接设置属性值就好，不然会有bug：滑动返回顶部出现黑块
/// 设置是否隐藏导航栏
@property (nonatomic,assign) BOOL      hiddenNavBar;

/// 点击导航栏返回按钮事件
- (void)backButtonEvent:(id)sender;

@end

NS_ASSUME_NONNULL_END
