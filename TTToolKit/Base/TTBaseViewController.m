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

@interface TTBaseViewController ()
{
    UIStatusBarStyle m_statusBarStyle;
    UIButton *m_backButton;
    UILabel  *m_titleLabel;
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
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[NSBundle tt_blackBackImage] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        backBtn.bounds = CGRectMake(0, 0, 40, 40);
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = @[item];
        m_backButton = backBtn;
    }
    self.navBarTintColor = [UIColor whiteColor];
    self.navTitleColor = [UIColor blackColor];
    
    // 遮罩层
    self.showMask = NO;
    [self.view addSubview:self.grayMask];
    self.enableGestureUnderMask = NO;
    
    // 标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat space = 16.f;
    CGFloat itemSpace = 6.f;
    CGFloat leftItemWidth = self.navigationItem.leftBarButtonItem.customView.frame.size.width;
    CGFloat titleW = (UIScreen.mainScreen.bounds.size.width*0.5f-space-itemSpace-leftItemWidth) * 2.f;
    titleLabel.frame = CGRectMake(0, 0, titleW, 44.f);
    titleLabel.text = self.title;
    m_titleLabel = titleLabel;
    self.navigationItem.titleView = m_titleLabel;
    
    if (self.navigationItem.title) {
        self.navBarTitle = self.navigationItem.title;
    } else if (self.title) {
        self.navBarTitle = self.title;
    }
    
    // config
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.97 alpha:1.00];
    self.hiddenNavBar = NO;
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
    _hiddenNavBar = hiddenNavBar;
}

- (void)setStatusBarTheme:(TTUITheme)style
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

- (void)setNavBarBackImage:(UIImage *)image
{
    if (m_backButton) {
        [m_backButton setImage:image forState:UIControlStateNormal];        
    }
}

- (void)setNavBarTitle:(NSString *)title
{
    _navBarTitle = [title copy];
    m_titleLabel.text = title;
    self.navigationItem.titleView = m_titleLabel;
}

- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar
{
    _hiddenNavBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)setNavBarTintColor:(UIColor *)navBarTintColor{
    _navBarTintColor = navBarTintColor;
    [self.navigationController.navigationBar setBarTintColor:navBarTintColor];
}

- (void)setNavBarTitleFont:(UIFont *)font
{
    _navBarTitleFont = font;
    m_titleLabel.font = font;
    self.navigationItem.titleView = m_titleLabel;
}

- (void)setNavTitleColor:(UIColor *)color
{
    _navTitleColor = color;
    m_titleLabel.textColor = color;
    self.navigationItem.titleView = m_titleLabel;
}

- (void)setShowMask:(BOOL)showMask
{
    _showMask = showMask;
    self.grayMask.hidden = !showMask;
    [self.view bringSubviewToFront:self.grayMask];
}

- (void)setEnableGestureUnderMask:(BOOL)enable
{
    _enableGestureUnderMask = enable;
    self.grayMask.userInteractionEnabled = !enable;
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
