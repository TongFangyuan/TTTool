//
//  UITextField+PlaceHolder.m
//  CVideo2.0
//
//  Created by Tong on 2020/12/31.
//  Copyright © 2020 思芯微. All rights reserved.
//

#import "UITextField+PlaceHolder.h"

@implementation UITextField (PlaceHolder)

- (__kindof UITextField *(^)(UIColor *color))tt_placeHolderColor{
    return ^UITextField *(UIColor *color){
        if (!self.placeholder.length) return self;
        NSMutableAttributedString *attString = self.attributedPlaceholder ? self.attributedPlaceholder.mutableCopy : [[NSMutableAttributedString alloc] initWithString:self.placeholder];
        [attString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.placeholder.length)];
        self.attributedPlaceholder = attString;
        return self;
    };
}
- (__kindof UITextField *(^)(UIFont *font))tt_placeHolderFont{
    return ^UITextField *(UIFont *font){
        if (!self.placeholder.length) return self;
        NSMutableAttributedString *attString = self.attributedPlaceholder ? self.attributedPlaceholder.mutableCopy : [[NSMutableAttributedString alloc] initWithString:self.placeholder];
        [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.placeholder.length)];
        self.attributedPlaceholder = attString;
        return self;
    };
}
@end
