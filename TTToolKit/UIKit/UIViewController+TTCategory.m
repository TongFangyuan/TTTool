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

@end
