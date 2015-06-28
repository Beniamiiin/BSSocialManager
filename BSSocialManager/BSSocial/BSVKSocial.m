//
//  BSVKSocial.m
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSVKSocial.h"

#import <VK-ios-sdk/VKSdk.h>

static NSString *const kBSVKPlistKey            = @"VK";
static NSString *const kBSVKPlistAppIDKey       = @"VKAppID";
static NSString *const kBSVKPlistPermissionsKey = @"VKPermissions";

@interface BSVKSocial () <VKSdkDelegate>
{
    BSRequestSuccess vkRequestSuccess;
    BSRequestFailure vkRequestFailure;
    
    NSArray *VKPermissions;
}

- (void)p_loginToVKWithPermissions:(NSArray *)permissions success:(BSRequestSuccess)successfailure:(BSRequestFailure)failure;

@end

@implementation BSVKSocial

#pragma mark - Public methods -

#pragma mark Initialize
+ (BSVKSocial *)setup
{
    return [[self alloc] init];
}

- (id)init
{
    if ( self = [super init] )
    {
        NSDictionary *infoPlistSocialSettings = [BSSocialManagerHelper infoPlistSocialSettingsDictionary];
        
        // Setup permissions
        VKPermissions = [infoPlistSocialSettings[kBSVKPlistKey][kBSVKPlistPermissionsKey] copy];
        
        // Setup app ID
        NSString *VKAppID = [infoPlistSocialSettings[kBSVKPlistKey][kBSVKPlistAppIDKey] copy];
        
        // Init
        [VKSdk initializeWithDelegate:self andAppId:VKAppID];
    }
    
    return self;
}

#pragma mark Authorization methods
- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    [self p_loginToVKWithPermissions:VKPermissions success:success failure:failure];
}

#pragma mark Getters
- (BOOL)isAuthorized
{
    return [VKSdk wakeUpSession];
}

#pragma mark - Private methods -

#pragma mark Authorization methods
- (void)p_loginToVKWithSimplePermissionsWithSuccess:(BSRequestSuccess)success
                                            failure:(BSRequestFailure)failure
{
    [self p_loginToVKWithPermissions:VKPermissions success:success failure:failure];
}

- (void)p_loginToVKWithPermissions:(NSArray *)permissions success:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    if ( self.isAuthorized )
    {
        if ( success )
        {
            success([VKSdk getAccessToken].accessToken);
        }
        
        return;
    }
    
    vkRequestSuccess = success;
    vkRequestFailure = failure;
    
    [VKSdk authorize:VKPermissions revokeAccess:YES forceOAuth:YES inApp:YES display:VK_DISPLAY_IOS];
}

#pragma mark VKSDKDelegate
- (void)vkSdkReceivedNewToken:(VKAccessToken*)newToken
{
    if ( vkRequestSuccess )
    {
        vkRequestSuccess(newToken.accessToken);
    }
}

- (void)vkSdkAcceptedUserToken:(VKAccessToken *)token
{
    if ( vkRequestSuccess )
    {
        vkRequestSuccess(token.accessToken);
    }
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller
{
    [[BSSocialManagerHelper loginContainer] presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:[BSSocialManagerHelper loginContainer]];
}

- (void)vkSdkUserDeniedAccess:(VKError*)authorizationError
{
    NSError *error = authorizationError.httpError;
    
    if ( authorizationError.errorCode == VK_API_ERROR )
    {
        error = [BSSocialManagerHelper createErrorWithTitle:nil
                                                    message:authorizationError.errorMessage
                                                       code:BSVKApiError];
    }
    
    if ( vkRequestFailure )
    {
        vkRequestFailure(error);
    }
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken
{
    if ( vkRequestFailure )
    {
        vkRequestFailure(nil);
    }
}

- (void)vkSdkRenewedToken:(VKAccessToken *)newToken
{
    if ( vkRequestSuccess )
    {
        vkRequestSuccess(newToken.accessToken);
    }
}

#pragma mark URL scheme handle
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

@end
