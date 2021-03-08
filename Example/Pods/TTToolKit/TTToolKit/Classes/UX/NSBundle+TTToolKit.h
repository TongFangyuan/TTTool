//
//  NSBundle+TTToolKit.h
//  CVoice2
//
//  Created by Tong on 2020/4/26.
//  Copyright © 2020 CChip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (TTToolKit)

+ (instancetype)tt_toolBundle;
+ (UIImage *)tt_blackBackImage;
+ (UIImage *)tt_whiteBackImage;
+ (NSString *)tt_localizedStringForKey:(NSString *)key value:(nullable NSString *)value;
+ (NSString *)tt_localizedStringForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
