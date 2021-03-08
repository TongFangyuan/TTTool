//
//  TTBaseNavigationController.m
//  CVoice2
//
//  Created by 周金华 on 2020/4/26.
//  Copyright © 2020 周金华. All rights reserved.
//

#import "TTBaseNavigationController.h"
#import "TTBaseViewController.h"
#import "NSBundle+TTToolKit.h"

@interface TTBaseNavigationController ()
<
UIGestureRecognizerDelegate,
UINavigationControllerDelegate
>

@end

@implementation TTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修复左滑失效问题
    self.openPopGestureRecognizer = YES;
    self.hiddenBottomBarWhenPush = YES;
    self.delegate = self;
    
    if(@available(iOS 11.0, *)){
        [[UITableView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }
    
    UINavigationBar *navBar = self.navigationBar;
    if(@available(iOS 11.0, *)){
        navBar.prefersLargeTitles = NO;
        [navBar setLargeTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName:[UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.00]}];
        //        [navBar setBackgroundColor:[UIColor jk_colorWithHexString:@"#2848B1"]];
    }
    
    [navBar setHidden:NO];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setBarTintColor:[UIColor whiteColor]];
    [navBar setTranslucent:NO];
    [navBar setBarStyle:UIBarStyleBlack];
    [navBar setShadowImage:[UIImage new]];
    
    // 设置导航标题字体
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.00]}];
    // 设置导航菜单项
    UIBarButtonItem *barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateDisabled];
    
}


- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (self.childViewControllers.count)
    {
        // 自动隐藏TabBar
        viewController.hidesBottomBarWhenPushed = self.hiddenBottomBarWhenPush;
        
        // 如果不是TTBaseViewController类，统一设置导航UI
        if (![viewController isKindOfClass:[TTBaseViewController class]])
        {
            UIBarButtonItem *leftBackItem  = [[UIBarButtonItem alloc] initWithImage:[NSBundle tt_blackBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
            viewController.navigationItem.leftBarButtonItems = @[leftBackItem];
            // 自动隐藏TabBar
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    // 调用父类push实现方法,可以在对应ViewController再次覆盖leftBarButtonItem默认返回样式
    [super pushViewController:viewController animated:animated];
}

//如果是top控制器不允许左滑
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if (navigationController.childViewControllers.count==1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    id<TTNavbarAppearance> obj = (id<TTNavbarAppearance>)viewController;
    if ([obj respondsToSelector:@selector(hiddenNavBar)]) {
        BOOL hiddenNavbar = obj.hiddenNavBar;
        [navigationController setNavigationBarHidden:hiddenNavbar animated:animated];
    }
}

#pragma mark - ---- Addition ----
- (void)backAction
{
    [self.view endEditing:YES];//解决编辑状态黑影问题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self popViewControllerAnimated:YES];
    });
}

#pragma mark - ---- Properties ----
-(void)setStatusBarBackgroundColor:(UIColor *)color
{
    if ([_statusBarBackgroundColor isEqual:color])
    {
        _statusBarBackgroundColor = color;
        
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
        {
            statusBar.backgroundColor = color;
        }
    }
}

- (void)setOpenPopGestureRecognizer:(BOOL)open
{
    if (_openPopGestureRecognizer != open) {
        _openPopGestureRecognizer = open;
        if (open) {
            self.interactivePopGestureRecognizer.delegate = self;
        }
    }
}

#pragma mark - ---- StatusBar ----
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.topViewController.prefersStatusBarHidden;
}

@end
