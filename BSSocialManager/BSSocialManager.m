//
//  BSSocialManager.m
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSSocialManager.h"

#import "BSTWSocial.h"

@interface BSSocialManager ()
{
    BSVKSocial *vkSocial;
    BSFBSocial *fbSocial;
    BSTWSocial *twSocial;
    BSOKSocial *okSocial;
}

@end

static BSSocialManager *sharedSocialManagerInstance;

@implementation BSSocialManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedSocialManagerInstance = [self new];
    });
    
    return sharedSocialManagerInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        vkSocial = [BSVKSocial setup];
        fbSocial = [BSFBSocial setup];
        twSocial = [BSTWSocial setup];
        okSocial = [BSOKSocial setup];
    }
    
    return self;
}

#pragma mark - Authrization status
- (BOOL)vkIsAuthorized
{
    return vkSocial.isAuthorized;
}

- (BOOL)fbIsAuthorized
{
    return fbSocial.isAuthorized;
}

- (BOOL)twIsAuthorized
{
    return twSocial.isAuthorized;
}

- (BOOL)okIsAuthorized
{
    return okSocial.isAuthorized;
}

#pragma mark - Authrization methods
- (void)loginToVKWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    [vkSocial authorizeWithSuccess:success failure:failure];
}

- (void)loginToFBWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    [fbSocial authorizeWithSuccess:success failure:failure];
}

- (void)loginToTWWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    [twSocial authorizeWithSuccess:success failure:failure];
}

- (void)loginToOKWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    [okSocial authorizeWithSuccess:success failure:failure];
}

@end
