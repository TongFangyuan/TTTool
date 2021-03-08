//
//  UIViewController+TTCategory.m
//  CVoice2
//
//  Created by Tong on 2020/4/13.
//  Copyright © 2020 CChip. All rights reserved.
//

#import "UIViewController+TTCategory.h"

@implementation UIViewController (TTCategory)

- (__kindof  UITabBarController * _Nullable)tt_tabbarController {
    
    if (self.tabBarController) {
        return self.tabBarController;
    }
    
    UINavigationController *nav = self.navigationController;
    while (nav) {
        if (nav.tabBarController) {
            return nav.tabBarController;
        }
        nav = nav.navigationController;
    }
    return nil;
    
}

- (UIViewController *)tt_getTopViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self tt_getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)tt_getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self tt_getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self tt_getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end
