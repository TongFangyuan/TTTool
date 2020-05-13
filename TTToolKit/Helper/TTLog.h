//
//  TTLog.h
//  TTToolDemo
//
//  Created by Tong on 2020/5/13.
//  Copyright © 2020 童方园. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef DEBUG
    #define TTLog(fmt,...) NSLog((@"[%s:%d行] " fmt),[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,##__VA_ARGS__)
#else
    #define TTLog(...)
#endif

#ifndef TT_DEBUG
    #define TT_DEBUG 0
#endif

@interface TTLog : NSObject

@end

NS_ASSUME_NONNULL_END
