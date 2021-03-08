//
//  TTAES128Tool.m
//  TTToolDemo
//
//  Created by Tong on 2020/4/2.
//  Copyright © 2020 童方园. All rights reserved.
//

#import "TTAES128Tool.h"

/// 加密
NSString *TTAES128Encrypt(NSString *string, NSString *key, NSString *iv) {
    return [TTAES128Tool encrypt:string key:key iv:iv];
}

/// 解密
NSString *TTAES128Decrypt(NSString *string, NSString *key, NSString *iv) {
    return [TTAES128Tool decrypt:string key:key iv:iv];
}

@implementation TTAES128Tool

+ (NSString *)encrypt:(NSString *)string
                  key:(NSString *)key
                   iv:(NSString *)iv
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aesData = [data AES128EncryptWithKey:key iv:iv];
    return [self convertDataToHexStr:aesData];
}

+ (NSString *)decrypt:(NSString *)string
                  key:(NSString *)key
                   iv:(NSString *)iv {
    NSData *data  = [self convertHexStrToData:string];
    NSData *aesData = [data AES128DecryptWithKey:key iv:iv];
    return [[NSString alloc] initWithData:aesData encoding:NSUTF8StringEncoding];
}

#pragma mark - private
//16进制转换为NSData
+ (NSData*)convertHexStrToData:(NSString*)str {
    if (!str || [str length] ==0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc]initWithCapacity:[str length]*2];
    NSRange range;
    if ([str length] %2==0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [str length]; i +=2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc]initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc]initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location+= range.length;
        range.length=2;
    }
    //    NSLog(@"hexdata: %@", hexData);
    return hexData;
}

//NSData转换为16进制
+ (NSString*)convertDataToHexStr:(NSData*)data {
    if (!data || [data length] ==0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc]initWithCapacity:[data length]/2];
    
    [data enumerateByteRangesUsingBlock:^(const void*bytes,NSRange byteRange,BOOL*stop) {
        unsigned char *dataBytes = (unsigned  char*)bytes;
        for (NSInteger i =0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] ==2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}


@end
