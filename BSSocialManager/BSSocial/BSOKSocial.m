//
//  BSOKSocial.m
//
//  Created by Beniamin Sarkisyan on 27.06.15.
//  Copyright (c) 2015 CleverPumpkin. All rights reserved.
//

#import "BSOKSocial.h"

#import <OK-ios-sdk/Odnoklassniki.h>

static NSString *const kBSOKPlistKey            = @"OK";
static NSString *const kBSOKPlistAppIDKey       = @"OKAppID";
static NSString *const kBSOKPlistAppSecretKey   = @"OKAppSecret";
static NSString *const kBSOKPlistAppKeyKey      = @"OKAppKey";

static NSString *const kBSOKPlistPermissionsKey = @"OKPermissions";

@interface BSOKSocial () <OKSessionDelegate>
{
    BSRequestSuccess okRequestSuccess;
    BSRequestFailure okRequestFailure;
    
    NSArray *OKPermissions;
    
    Odnoklassniki *OKSDKInstance;
}

- (void)p_loginToOKWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

@end

@implementation BSOKSocial

#pragma mark - Public methods -

#pragma mark Initialize
+ (BSOKSocial *)setup
{
    return [[self alloc] init];
}

- (id)init
{
    if ( self = [super init] )
    {
        NSDictionary *infoPlistSocialSettings = [BSSocialManagerHelper infoPlistSocialSettingsDictionary];
        
        // Setup app ID and SecretKey and Key
        NSString *OKAppID = [infoPlistSocialSettings[kBSOKPlistKey][kBSOKPlistAppIDKey] copy];
        NSString *OKAppSecret = [infoPlistSocialSettings[kBSOKPlistKey][kBSOKPlistAppSecretKey] copy];
        NSString *OKAppKey = [infoPlistSocialSettings[kBSOKPlistKey][kBSOKPlistAppKeyKey] copy];
        
        // Setup permissions
        OKPermissions = [infoPlistSocialSettings[kBSOKPlistKey][kBSOKPlistPermissionsKey] copy];
        
        // Init
        OKSDKInstance = [[Odnoklassniki alloc] initWithAppId:OKAppID
                                                   appSecret:OKAppSecret
                                                      appKey:OKAppKey
                                                    delegate:self];
    }
    
    return self;
}

#pragma mark Authorization methods
- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    [self p_loginToOKWithSuccess:success failure:failure];
}

#pragma mark Getters
- (BOOL)isAuthorized
{
    return OKSDKInstance.session.accessToken;
}

#pragma mark - Private methods -

#pragma mark Authorization methods
- (void)p_loginToOKWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    if ( self.isAuthorized )
    {
        if ( success )
        {
            success(OKSDKInstance.session.accessToken);
        }
        
        return;
    }
    
    okRequestSuccess = success;
    okRequestFailure = failure;
    
    [OKSDKInstance authorizeWithPermissions:OKPermissions];
}

#pragma mark OKSessionDelegate
- (void)okShouldPresentAuthorizeController:(UIViewController *)viewController
{
	[[BSSocialManagerHelper loginContainer] presentViewController:viewController animated:YES completion:nil];
}

- (void)okDidLogin
{
	if ( okRequestSuccess )
    {
        okRequestSuccess(OKSDKInstance.session.accessToken);
    }
}

- (void)okDidNotLoginWithError:(NSError *)error
{
    if ( okRequestFailure )
    {
        okRequestFailure(error);
    }
}

- (void)okDidExtendToken:(NSString *)accessToken
{
    if ( okRequestSuccess )
    {
        okRequestSuccess(accessToken);
    }
}

#pragma mark URL scheme handle
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[OKSession activeSession] handleOpenURL:url];
}

@end
