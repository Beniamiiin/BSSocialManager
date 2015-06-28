//
//  BSSocialManagerHelper.h
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const BSSocialErrorDomain;

@interface BSSocialManagerHelper : NSObject

+ (NSError *)createErrorWithTitle:(NSString *)title
                          message:(NSString *)message
                             code:(NSInteger)code;

+ (UIViewController *)loginContainer;

+ (NSDictionary *)infoPlistSocialSettingsDictionary;

@end
