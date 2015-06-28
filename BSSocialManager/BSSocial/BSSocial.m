//
//  BSSocial.m
//
//  Created by Beniamin on 09.06.14.
//  Copyright (c) 2014 Oysterlabs. All rights reserved.
//

#import "BSSocial.h"

@implementation BSSocial

#pragma mark Initialize
+ (BSSocial *)setup
{
    return [self new];
}

#pragma mark - Authorization methods
- (void)authorizeWithSuccess:(BSRequestSuccess)success failure:(BSRequestFailure)failure
{

}

#pragma mark - Getters
- (BOOL)isAuthorized
{
    return NO;
}

@end
