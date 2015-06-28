//
//  BSFacebookSocial.h
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSSocial.h"

@interface BSFBSocial : BSSocial

@property (nonatomic, readonly, assign, getter = isAuthorized) BOOL authorized;

+ (BSFBSocial *)setup;

- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

+ (void)applicationDidBecomeActive:(UIApplication *)application;
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
