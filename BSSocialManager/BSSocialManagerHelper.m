//
//  BSSocialManagerHelper.m
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSSocialManagerHelper.h"

NSString *const BSSocialErrorDomain             = @"BSSocialErrorDomain";

static NSString *const BSSocialSettingsPlistKey = @"Social Settings";

@implementation BSSocialManagerHelper

+ (NSError *)createErrorWithTitle:(NSString *)title
                          message:(NSString *)message
                             code:(NSInteger)code
{
    NSString *description = title;
    NSString *reason = message;
    NSArray *objArray = @[NSLocalizedString(description, @""), NSLocalizedString(reason, @"")];
    NSArray *keyArray = @[NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
    NSError *error = [NSError errorWithDomain:BSSocialErrorDomain code:code userInfo:userInfo];
    
    return error;
}

+ (UIViewController *)loginContainer
{
    static UIWindow *window;
    
    if ( window )
    {
        return window.rootViewController;
    }
    
    window = [UIApplication sharedApplication].keyWindow;
    
    if ( window.windowLevel != UIWindowLevelNormal )
    {
        for (window in [UIApplication sharedApplication].windows)
        {
            if ( window.windowLevel == UIWindowLevelNormal )
            {
                break;
            }
        }
    }
    
    return window.rootViewController;
}

+ (NSDictionary *)infoPlistSocialSettingsDictionary
{
	NSDictionary *infoPlistSocialSettings = [[NSBundle mainBundle] objectForInfoDictionaryKey:BSSocialSettingsPlistKey];
    return infoPlistSocialSettings;
}

@end
