//
//  UIViewController+TTCategory.h
//  CVoice2
//
//  Created by Tong on 2020/4/13.
//  Copyright © 2020 CChip. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TTCategory)

/// 获取tabbarController
- (__kindof  UITabBarController * _Nullable)tt_tabbarController;

- (__kindof UIViewController *)tt_getTopViewController;

@end

NS_ASSUME_NONNULL_END
