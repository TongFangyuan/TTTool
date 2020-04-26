//
//  TTBaseNavigationController.h
//  CVoice2
//
//  Created by Tong on 2020/4/26.
//  Copyright © 2020 CChip. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseNavigationController : UINavigationController

@property (nonatomic,strong) UIColor *statusBarBackgroundColor;
/// 左滑返回上级页面手势是否开启，默认YES
@property (nonatomic,assign) BOOL openPopGestureRecognizer;
/// push时是否隐藏底部,默认YES
@property (nonatomic,assign) BOOL hiddenBottomBarWhenPush;
 
@end

NS_ASSUME_NONNULL_END
