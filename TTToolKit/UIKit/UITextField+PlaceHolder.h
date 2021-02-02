//
//  UITextField+PlaceHolder.h
//  CVideo2.0
//
//  Created by Tong on 2020/12/31.
//  Copyright © 2020 思芯微. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (PlaceHolder)

- (__kindof UITextField *(^)(UIColor *color))tt_placeHolderColor;
- (__kindof UITextField *(^)(UIFont *font))tt_placeHolderFont;

@end

NS_ASSUME_NONNULL_END
