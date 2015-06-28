//
//  BSFacebookSocial.m
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSFBSocial.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

static NSString *const kBSFBPlistKey            = @"FB";
static NSString *const kBSPlistAppIDKey         = @"FBAppID";
static NSString *const kBSPlistAppNameKey       = @"FBAppName";
static NSString *const kBSFBPlistPermissionsKey = @"FBPermissions";

@interface BSFBSocial ()
{
    NSArray *FBPermissions;
}

@end

@implementation BSFBSocial

#pragma mark - Public methods -

#pragma mark Initialize
+ (BSFBSocial *)setup
{
    return [self new];
}

- (id)init
{
    if ( self = [super init] )
    {
        NSDictionary *infoPlistSocialSettings = [BSSocialManagerHelper infoPlistSocialSettingsDictionary];
        
        // Setup permissions
        FBPermissions = [infoPlistSocialSettings[kBSFBPlistKey][kBSFBPlistPermissionsKey] copy];
        
        // Setup app ID
        NSString *FBAppID = [infoPlistSocialSettings[kBSFBPlistKey][kBSPlistAppIDKey] copy];
        NSString *FBAppName = [infoPlistSocialSettings[kBSFBPlistKey][kBSPlistAppNameKey] copy];
        
        [FBSDKSettings setAppID:FBAppID];
        [FBSDKSettings setDisplayName:FBAppName];
    }
    
    return self;
}

#pragma mark Authorization methods
- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;
{
    [self p_loginToFacebookWithPermissions:FBPermissions
                                   success:success
                                   failure:failure];
}

#pragma mark Getters
- (BOOL)isAuthorized
{
    return [FBSDKAccessToken currentAccessToken];
}

#pragma mark - Private methods -

#pragma mark Authorization methods
- (void)p_loginToFacebookWithPermissions:(NSArray *)permissions
                                 success:(BSRequestSuccess)success
                                 failure:(BSRequestFailure)failure;
{
    if ( self.isAuthorized )
    {
        if ( success )
        {
            success([FBSDKAccessToken currentAccessToken].tokenString);
        }
        
        return;
    }
    
    FBSDKLoginManager *login = [FBSDKLoginManager new];
    login.loginBehavior = FBSDKLoginBehaviorWeb;
    
    [login logInWithReadPermissions:permissions handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if ( error )
        {
            if ( failure )
            {
                failure(error);
            }
        }
        else
        {
            if ( success )
            {
                success([FBSDKAccessToken currentAccessToken].tokenString);
            }
        }
    }];
}

#pragma mark URL scheme handle
+ (void)applicationDidBecomeActive:(UIApplication *)application
{
	[FBSDKAppEvents activateApp];
}

+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
