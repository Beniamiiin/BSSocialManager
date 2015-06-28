//
//  BSSocial.h
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSSocialManagerHelper.h"

typedef void(^BSRequestSuccess)(NSString *token);
typedef void(^BSRequestFailure)(NSError *error);

@interface BSSocial : NSObject

@property (nonatomic, readonly, assign, getter = isAuthorized) BOOL authorized;

+ (BSSocial *)setup;

- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure;

@end
