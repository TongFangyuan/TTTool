//
//  TTBaseViewController.m
//  CVoice2
//
//  Created by Tong on 2020/4/26.
//  Copyright © 2020 CChip. All rights reserved.
//

#import "TTBaseViewController.h"
#import "NSBundle+TTToolKit.h"

#define kBlackColor [UIColor blackColor]
#define kWhiteColor [UIColor whiteColor]

@interface TTNavButton : UIButton

@property (nonatomic,assign) TTUITheme theme;
@property (nonatomic,strong) UIImage *lightImage;
@property (nonatomic,strong) UIImage *darkImage;

@end

@implementation TTNavButton
- (void)setTheme:(TTUITheme )theme
{
    if (_theme != theme) {
        _theme = theme;
        
        if (theme == TTUIThemeDark) {
            [self setImage:self.darkImage forState:UIControlStateNormal];
        } else {
            [self setImage:self.lightImage forState:UIControlStateNormal];
        }
    }
}
- (UIImage *)lightImage
{
    if (!_lightImage) {
        _lightImage = [self imageForState:UIControlStateNormal];
    }
    return _lightImage;
}
- (UIImage *)darkImage
{
    if (!_darkImage) {
        _darkImage = [self imageForState:UIControlStateNormal];
    }
    return _darkImage;
}
@end

@interface TTNavTitleLabel : UILabel

@property (nonatomic,assign) TTUITheme theme;
@property (nonatomic,strong) UIColor *lightTextColor;
@property (nonatomic,strong) UIColor *darkTextColor;

@end

@implementation TTNavTitleLabel
-(void)setTheme:(TTUITheme)theme {
    if (_theme != theme) {
        _theme = theme;
        
        if (theme == TTUIThemeDark) {
            self.textColor = self.darkTextColor;
        } else {
            self.textColor = self.lightTextColor;
        }
    }
}
- (UIColor *)lightTextColor
{
    if (!_lightTextColor) {
        _lightTextColor = self.textColor;
    }
    return _lightTextColor;
}
- (UIColor *)darkTextColor
{
    if (!_darkTextColor) {
        _darkTextColor = self.textColor;
    }
    return _darkTextColor;
}
@end


@interface TTBaseViewController ()
{
    UIStatusBarStyle m_statusBarStyle;
    TTNavButton *m_backButton;
    TTNavTitleLabel  *m_titleLabel;
}

@property (nonatomic,strong) UIView *grayMask;


@end

@implementation TTBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /// 设置返回按钮
    if (self.navigationController.viewControllers.count!=1)
    {
        TTNavButton *backBtn = [TTNavButton buttonWithType:UIButtonTypeCustom];
        backBtn.lightImage = [NSBundle tt_blackBackImage];
        backBtn.darkImage = [NSBundle tt_whiteBackImage];
        [backBtn setImage:backBtn.lightImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
          backBtn.bounds = CGRectMake(0, 0, 40, 40);
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = @[item];
        m_backButton = backBtn;
    }
    
    // 遮罩层
    self.showMask = NO;
    [self.view addSubview:self.grayMask];
    self.enableGestureUnderMask = NO;
    
    TTNavTitleLabel *titleLabel = [TTNavTitleLabel new];
    titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    titleLabel.lightTextColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.00];
    titleLabel.darkTextColor = kWhiteColor;
    m_titleLabel = titleLabel;
    
    // config
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.97 alpha:1.00];
    self.hiddenNavBar = NO;
    self.navBarTheme = TTUIThemeLight;
    self.statusBarTheme = TTUIThemeDark;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.grayMask.frame = self.view.bounds;
}

#pragma mark - ---- Public ----
- (void)backButtonEvent:(id)sender {
    
    //解决编辑状态黑影问题
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ---- Properties ----
- (void)setHiddenNavBar:(BOOL)hiddenNavBar
{
    if (_hiddenNavBar!=hiddenNavBar)
    {
        _hiddenNavBar = hiddenNavBar;
    }
}

- (void)setStatusBarTheme:(TTUITheme)style
{
    if (_statusBarTheme!=style)
    {
        _statusBarTheme = style;
        
        if (style==TTUIThemeLight)
        {
            m_statusBarStyle = UIStatusBarStyleLightContent;
        }
        else if (style==TTUIThemeDark)
        {
            if (@available(iOS 13.0, *)) {
                m_statusBarStyle = UIStatusBarStyleDarkContent;
            } else {
                m_statusBarStyle = UIStatusBarStyleDefault;
            }
        }

        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)setNavBarBackImage:(UIImage *)image
{
    if (_navBarBackImage != image) {
        _navBarBackImage = image;
        
        m_backButton.lightImage = image;
        [m_backButton setImage:image forState:UIControlStateNormal];
        [m_backButton sizeToFit];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:m_backButton];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)setNavBarBackImageForDark:(UIImage *)image
{
    if (_navBarBackImageForDark != image) {
        _navBarBackImageForDark = image;
        
        m_backButton.darkImage = image;
        [m_backButton setImage:image forState:UIControlStateNormal];
        [m_backButton sizeToFit];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:m_backButton];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)setNavBarTitle:(NSString *)title
{
    if (![_navBarTitle isEqualToString:title])
    {
        _navBarTitle = [title copy];
        
        m_titleLabel.text = title;
        [m_titleLabel sizeToFit];
        self.navigationItem.titleView = m_titleLabel;
    }
}

- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar
{
    if (_hiddenNavBar != hiddenStatusBar)
    {
        _hiddenNavBar = hiddenStatusBar;
        
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)setNavBarTheme:(TTUITheme)theme
{
    if (_navBarTheme != theme)
    {
        _navBarTheme = theme;
        
        m_titleLabel.theme = theme;
        m_backButton.theme = theme;
        
        UIColor *navbarColor = theme==TTUIThemeDark ? kBlackColor : kWhiteColor;
        [self.navigationController.navigationBar setBarTintColor:navbarColor];
    }
}

- (void)setNavBarTitleFont:(UIFont *)font
{
    if (![_navBarTitleFont isEqual:font]) {
        _navBarTitleFont = font;
        
        m_titleLabel.font = font;
        [m_titleLabel sizeToFit];
        self.navigationItem.titleView = m_titleLabel;
    }
}

- (void)setNavTitleColor:(UIColor *)color
{
    if ([_navTitleColor isEqual:color]) {
        _navTitleColor = color;
        
        m_titleLabel.textColor = color;
        m_titleLabel.lightTextColor = color;
        [m_titleLabel sizeToFit];
        self.navigationItem.titleView = m_titleLabel;
    }
}

- (void)setNavTitleColorForDark:(UIColor *)color
{
    if ([_navTitleColorForDark isEqual:color]) {
        _navTitleColorForDark = color;
        
        m_titleLabel.textColor = color;
        m_titleLabel.lightTextColor = color;
        [m_titleLabel sizeToFit];
        self.navigationItem.titleView = m_titleLabel;
    }
}

- (void)setShowMask:(BOOL)showMask
{
    if (_showMask!=showMask) {
        _showMask = showMask;
        
        self.grayMask.hidden = !showMask;
        [self.view bringSubviewToFront:self.grayMask];
    }
}

- (void)setEnableGestureUnderMask:(BOOL)enable
{
    if (_enableGestureUnderMask != enable) {
        _enableGestureUnderMask = enable;
        
        self.grayMask.userInteractionEnabled = !enable;
    }
}

- (UIView *)grayMask {
    if (!_grayMask) {
        _grayMask = [UIView new];
        _grayMask.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7f];
        _grayMask.hidden = YES;
    }
    return _grayMask;
}

#pragma mark - ---- Override ----
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.navBarTitle = title;
}

#pragma mark - ---- Status Bar ----
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return m_statusBarStyle;
}

-(BOOL)prefersStatusBarHidden
{
    return self.hiddenStatusBar;
}

@end
