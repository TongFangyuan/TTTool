//
//  NSFileManager+TTFile.m
//  TTToolSamples
//
//  Created by Tong on 2019/6/25.
//  Copyright © 2019 Tongfy. All rights reserved.
//

#import "NSFileManager+TTFile.h"

@implementation NSFileManager (TTFile)

/**
 检测 iCloud 可用性
 这个方法接受一个参数， 就是要获取的容器标识。 所谓容器标识， 大多数应用只会用到一个 iCloud 容器，所以我们这里传入 nil， 就代表默认获取第一个可用的容器。
 
 Returns a file URL for the root of the ubiquity container directory corresponding to the supplied container ID.
 Returns nil if the mobile container does not exist or could not be determined.
 */
+ (NSURL *)tt_URLForICloudContainerIdentifier:(nullable NSString *)identifier {
    return [NSFileManager.defaultManager URLForUbiquityContainerIdentifier:identifier];
}

+ (NSString *)tt_getSystermDirectory:(TTSystermDirectory)directory {
    switch (directory) {
        case TTSystermDirectoryDocuments:
            return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        case TTSystermDirectoryLibrary:
            return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        case TTSystermDirectoryTmp:
            return NSTemporaryDirectory();
        case TTSystermDirectoryHome:
            return NSHomeDirectory();
        default:
            break;
    }
    return nil;
}

+ (NSString *)tt_createDicrectory:(NSString *)dicName inSystermDirectory:(TTSystermDirectory)sysDirectory {
    NSString *fatherDir = [self tt_getSystermDirectory:sysDirectory];
    NSString *dicPath = [fatherDir stringByAppendingPathComponent:dicName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = YES;
    
    BOOL isExist = [fileManager fileExistsAtPath:dicPath isDirectory:&isDir];
    if (!isExist) {
        BOOL isSuccess = [fileManager createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"文件夹创建成功：%d",isSuccess);
    } else {
        NSLog(@"文件夹已经存在，不用创建");
    }
    return dicPath;
}

@end
