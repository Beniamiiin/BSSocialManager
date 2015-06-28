//
//  BSOKSocial.h
//
//  Created by Beniamin Sarkisyan on 27.06.15.
//  Copyright (c) 2015 CleverPumpkin. All rights reserved.
//

#import "BSSocial.h"

@interface BSOKSocial : BSSocial

@property (nonatomic, readonly, assign, getter = isAuthorized) BOOL authorized;

+ (BSOKSocial *)setup;

- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
