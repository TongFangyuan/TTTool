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

/// 状态栏主题
@property (nonatomic,assign) TTUITheme statusBarTheme;
/// 隐藏状态栏
@property (nonatomic,assign) BOOL      hiddenStatusBar;
/// 导航栏主题
@property (nonatomic,assign) TTUITheme navBarTheme;
/// 返回按钮图标（白色主题）
@property (nonatomic,strong) UIImage  *navBarBackImage;
/// 返回按钮图标（黑色主题）
@property (nonatomic,strong) UIImage  *navBarBackImageForDark;
/// 导航栏标题
@property (nonatomic,copy)   NSString *navBarTitle;
/// 标题颜色（白色主题）
@property (nonatomic,strong) UIColor *navTitleColor;
/// 标题颜色（黑色主题）
@property (nonatomic,strong) UIColor *navTitleColorForDark;
/// 导航栏标题字体
@property (nonatomic,strong) UIFont   *navBarTitleFont;
/// 设置是否隐藏导航栏
@property (nonatomic,assign) BOOL      hiddenNavBar;
/// 蒙版视图显示,默认为NO（带有透明度的灰色遮罩层，不让用户操作）
@property (nonatomic,assign) BOOL showMask;
/// 遮罩层下，接受用户点击，默认为NO
@property (nonatomic,assign) BOOL enableGestureUnderMask;

/// 点击导航栏返回按钮事件
- (void)backButtonEvent:(id)sender;

@end

NS_ASSUME_NONNULL_END
