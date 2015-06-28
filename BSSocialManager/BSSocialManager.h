//
//  BSSocialManager.h
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSFBSocial.h"
#import "BSVKSocial.h"
#import "BSOKSocial.h"

#define SocialManager [BSSocialManager sharedInstance]

@interface BSSocialManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly, assign) BOOL vkIsAuthorized;
@property (nonatomic, readonly, assign) BOOL fbIsAuthorized;
@property (nonatomic, readonly, assign) BOOL twIsAuthorized;
@property (nonatomic, readonly, assign) BOOL okIsAuthorized;

- (void)loginToVKWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;
- (void)loginToFBWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;
- (void)loginToTWWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;
- (void)loginToOKWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

@end