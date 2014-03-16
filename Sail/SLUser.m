//
//  SLUser.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLUser.h"

@implementation SLUser

- (instancetype)init
{
    return [self initWithName:nil emailAddress:nil profileImageURL:nil];
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    if (self = [super init]) {
        self.name = jsonDictionary[@"name"];
        self.emailAddress = jsonDictionary[@"email"];
        self.profileImageURL = jsonDictionary[@"image"];
    }
    
    return self;
}

- (instancetype) initWithName:(NSString *)name emailAddress:(NSString *)emailAddress profileImageURL:(NSURL *)profileImageURL
{
    if (self = [super init]) {
        self.name = name;
        self.emailAddress = emailAddress;
        self.profileImageURL = profileImageURL;
    }
    
    return self;
}

@end
