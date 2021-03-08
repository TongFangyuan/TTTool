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
@property (nonatomic,assign) TTUITheme statusBarTheme;
@property (nonatomic,assign) BOOL      hiddenStatusBar;

#pragma mark - < Mask Config>
@property (nonatomic,assign) BOOL showMask;
@property (nonatomic,assign) BOOL enableGestureUnderMask;

#pragma mark - < NavigationBar Config >
@property (nonatomic,strong) UIFont   *navBarTitleFont;
@property (nonatomic,copy)   NSString *navBarTitle;
@property (nonatomic,strong) UIImage  *navBarBackImage;
@property (nonatomic,strong) UIColor  *navBarTintColor;
@property (nonatomic,strong) UIColor *navTitleColor;
/// ⚠️⚠️ 控制导航栏的隐藏请直接设置属性值就好，不然会有bug：滑动返回顶部出现黑块
/// 设置是否隐藏导航栏
@property (nonatomic,assign) BOOL      hiddenNavBar;

/// 点击导航栏返回按钮事件
- (void)backButtonEvent:(id)sender;

@end

NS_ASSUME_NONNULL_END
