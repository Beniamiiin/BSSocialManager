//
//  BSVKSocial.h
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSSocial.h"

enum
{
    BSVKApiError  = 1010,
    BSVKHTTPError = 1011,
};

@interface BSVKSocial : BSSocial

@property (nonatomic, readonly, assign, getter = isAuthorized) BOOL authorized;

+ (BSVKSocial *)setup;

- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
