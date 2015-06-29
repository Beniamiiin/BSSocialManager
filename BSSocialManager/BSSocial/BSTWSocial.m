//
//  BSTwitterSocial.m
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSTWSocial.h"

#import <FHSTwitterEngine.h>

static NSString *const kBSTWPlistKey          = @"TW";
static NSString *const kBSTWPlistAppIDKey     = @"TWAppID";
static NSString *const kBSTWPlistAppSecretKey = @"TWAppSecret";

@interface BSLoginContainer : UIViewController

@end

@implementation BSLoginContainer

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

@end

@interface BSTWSocial ()

- (void)p_loginToTWWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

@end

@implementation BSTWSocial

#pragma mark - Public methods -

#pragma mark Initialize
+ (BSTWSocial *)setup
{
    return [[self alloc] init];
}

- (id)init
{
    if ( self = [super init] )
    {
        NSDictionary *infoPlistSocialSettings = [BSSocialManagerHelper infoPlistSocialSettingsDictionary];
        
        // Setup app ID and SecretKey
        NSString *TWAppID = [infoPlistSocialSettings[kBSTWPlistKey][kBSTWPlistAppIDKey] copy];
        NSString *TWAppSecret = [infoPlistSocialSettings[kBSTWPlistKey][kBSTWPlistAppSecretKey] copy];
        
        // Init
        [[FHSTwitterEngine sharedEngine] permanentlySetConsumerKey:TWAppID andSecret:TWAppSecret];
        [[FHSTwitterEngine sharedEngine] loadAccessToken];
    }
    
    return self;
}

#pragma mark Authorization methods
- (void)authorizeWithSuccess:(BSRequestSuccess)success
                     failure:(BSRequestFailure)failure
{
    [self p_loginToTWWithSuccess:success failure:failure];
}

#pragma mark Getters
- (BOOL)isAuthorized
{
    return [[FHSTwitterEngine sharedEngine] isAuthorized];
}

#pragma mark - Private methods -

#pragma mark Authorization methods
- (void)p_loginToTWWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{
    if ( self.isAuthorized )
    {
        if ( success )
        {
            success([FHSTwitterEngine sharedEngine].accessToken.key);
        }
        
        return;
    }
    
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine] loginControllerWithCompletionHandler:^(BOOL loginSuccess) {
        if ( loginSuccess )
        {
            if ( success )
            {
                success([FHSTwitterEngine sharedEngine].accessToken.key);
            }
        }
        else
        {
            NSError *error = [BSSocialManagerHelper createErrorWithTitle:@"Some went wrong"
                                                                 message:@"Twitter login fail"
                                                                    code:BSTwitterLoginError];
            if ( failure )
            {
                failure(nil);
            }
        }
    }];
	
	BSLoginContainer *loginContainerViewController = [BSLoginContainer new];
	
	[loginContainerViewController.view addSubview:loginController.view];
	[loginContainerViewController addChildViewController:loginController];
	[loginController didMoveToParentViewController:loginContainerViewController];
	
    [[BSSocialManagerHelper loginContainer] presentViewController:loginContainerViewController animated:YES completion:nil];
}

@end
