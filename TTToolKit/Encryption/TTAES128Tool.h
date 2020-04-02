//
//  TTAES128Tool.h
//  TTToolDemo
//
//  Created by Tong on 2020/4/2.
//  Copyright © 2020 童方园. All rights reserved.
//
//
//          ---------参数---------
//          |   密码（key）:encrypt123456789
//          |   偏移量（iv）:edecrypt12345678
//          |   加密模式：CBC
//          |   填充：PKCS7Padding
//          |   编码：utf-8
//          ---------加密----------
//          |   输入：手机回收加密测试
//          |   加密：5b73a4ae6ab2a698b6a22ccc449fc24dfc08baf9754cc40b4cc2d8d9e18afab2
//          ----------------------

#import <Foundation/Foundation.h>
#import "NSData+AES128TL.h"

/// 加密
NSString *TTAES128Encrypt(NSString *string, NSString *key, NSString *iv);

/// 解密
NSString *TTAES128Decrypt(NSString *string, NSString *key, NSString *iv);


NS_ASSUME_NONNULL_BEGIN
@interface TTAES128Tool : NSObject

+ (NSString *)encrypt:(NSString *)string
                  key:(NSString *)key
                   iv:(NSString *)iv;

+ (NSString *)decrypt:(NSString *)string
                  key:(NSString *)key
                   iv:(NSString *)iv;

@end

NS_ASSUME_NONNULL_END
