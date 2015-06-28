//
//  BSTwitterSocial.h
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSSocial.h"

enum
{
    BSTwitterLoginError = 1014,
};

@interface BSTWSocial : BSSocial

@property (nonatomic, readonly, assign, getter = isAuthorized) BOOL authorized;

+ (BSTWSocial *)setup;

- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

@end
