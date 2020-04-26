//
//  TTTabBarController.m
//  CVoice2
//
//  Created by Tong on 2020/4/26.
//  Copyright © 2020 CChip. All rights reserved.
//

#import "TTBaseTabBarController.h"

@interface TTBaseTabBarController ()

@end

@implementation TTBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addChilVC:(UIViewController *)childVc
            title:(NSString *)title
            image:(NSString *)image
    selectedImage:(NSString *)selectedImage
              navCls:(Class)cls
{
    childVc.title = title;
    childVc.tabBarItem.title = title;
    
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:74/255.0 green:80/255.0 blue:99/255.0 alpha:1]} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:38/255.0 green:188/255.0 blue:114/255.0 alpha:1]} forState:UIControlStateSelected];
    
    if (cls) {
        UINavigationController *nav = [(UINavigationController *)[cls alloc] initWithRootViewController:childVc];
        [self addChildViewController:nav];
    } else {
        [self addChildViewController:childVc];
    }
}

#pragma mark - ---- Propeties ----
- (void)setStyle:(TTTabBarStyle)style
{
    if (_style != style) {
        _style = style;
        
        if (style==TTTabBarStyleOnlyShowImage)
        {
            for (UIViewController *childVc in self.childViewControllers) {
                childVc.tabBarItem.title = nil;
                CGFloat offset = 5.0;
                childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
            }
        }
    }
}

#pragma mark - ---- Status Bar ----
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.selectedViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.selectedViewController.prefersStatusBarHidden;
}

@end
