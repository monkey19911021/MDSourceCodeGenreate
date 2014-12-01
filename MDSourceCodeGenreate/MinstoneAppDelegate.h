//
//  MinstoneAppDelegate.h
//  MDSourceCodeGenreate
//
//  Created by Liujh on 14-12-1.
//  Copyright (c) 2014年 cn.com.minstone. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MinstoneAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;


//项目根目录
@property (strong, nonatomic) NSString *path;

//源代码生成目录
@property (strong, nonatomic) NSString *targetPath;

@end
