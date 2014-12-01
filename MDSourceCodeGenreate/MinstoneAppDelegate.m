//
//  MinstoneAppDelegate.m
//  MDSourceCodeGenreate
//
//  Created by Liujh on 14-12-1.
//  Copyright (c) 2014年 cn.com.minstone. All rights reserved.
//

#import "MinstoneAppDelegate.h"
#import <CoreFoundation/CoreFoundation.h>

@interface MinstoneAppDelegate ()

@end

@implementation MinstoneAppDelegate
{
    NSString *absoluatePath;
    NSString *absoluateTargetPath;
    NSMutableString *content;
    
    NSFileManager *fileManager;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
- (IBAction)GenreateDoc:(id)sender {
    
    NSString *userName;
    fileManager = [NSFileManager defaultManager];
    
    NSString *appName = [[_path componentsSeparatedByString:@"/"] lastObject];
    if([[[_path componentsSeparatedByString:@"/"] firstObject] isEqualToString:@"~"]){
        
        absoluatePath = [NSString stringWithFormat:@"%@/%@.xcodeproj", [_path substringFromIndex:1], appName];
        
        NSArray *pathArray = [fileManager contentsOfDirectoryAtPath:@"/Users" error:nil];
        
        for(int i = 0; i<pathArray.count; i++){
            userName = [pathArray objectAtIndex:i];
            NSString *tempPath = [NSString stringWithFormat:@"/Users/%@%@", userName, absoluatePath];
            
            if([fileManager fileExistsAtPath: tempPath]){
                absoluateTargetPath = [NSString stringWithFormat:@"/Users/%@/Desktop", userName];
                self.targetPath = absoluateTargetPath;
                absoluatePath = [NSString stringWithFormat:@"/Users/%@%@/%@", userName, [_path substringFromIndex:1], appName];
                NSLog(@"成功找到项目文件:%@.xcodeproj\n", appName);
                break;
            }
            
            if(i == (pathArray.count - 1)){
                absoluatePath = nil;
                NSLog(@"找不到项目文件:%@.xcodeproj\n", appName);
            }
        }
    }
    
    content = [[NSMutableString alloc] initWithCapacity:1];

    [self generateCodeWithPath:absoluatePath];
}

-(void)generateCodeWithPath:(NSString *)path
{
    NSLog(@"节点根目录：%@", path);
    for(NSString *subPath in [fileManager contentsOfDirectoryAtPath:path error:nil]){
        NSString *tempPath = [NSString stringWithFormat:@"%@/%@", path, subPath];
        
        BOOL isDir = NO;
        [fileManager fileExistsAtPath:tempPath isDirectory:(&isDir)];
        
        if(isDir){
            NSLog(@"节点目录：%@", tempPath);
            [self generateCodeWithPath:tempPath];
        }else{
            NSLog(@"文件名：%@", tempPath);
            if([tempPath hasSuffix:@".h"] || [tempPath hasSuffix:@".m"] ){
                [content appendString:[NSString stringWithContentsOfFile:tempPath encoding:NSUTF8StringEncoding error:nil]];
                [content writeToFile:[NSString stringWithFormat:@"%@/sourceCode.txt", absoluateTargetPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
        }
        
    }
}

@end
