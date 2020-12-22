//
//  NSString+TTRegularExpression.m
//  TTToolSamples
//
//  Created by Tong on 2019/6/24.
//  Copyright © 2019 tongfy. All rights reserved.
//

#import "NSString+TTRegularExpression.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TTRegularExpression)

- (nullable NSString *)tt_deleteCharactersWithPattern:(NSString *)pattern {
    if (self.length==0 || !self) return nil;
    NSError *error = nil;
    NSRegularExpression *regularExpress = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *string = [regularExpress stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
    return string;
}

@end

#pragma mark - ---- MD5 ----
@implementation NSString (TTMD5)

/// SourceCode:
/// https://stackoverflow.com/questions/27400983/how-to-generate-md5-from-string-in-ios/27402127
- (NSString *)tt_md5 {
    const char * pointer = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [string appendFormat:@"%02x",md5Buffer[i]];
    return string;
}

@end

