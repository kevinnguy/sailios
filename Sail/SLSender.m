//
//  SLSender.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLSender.h"

@implementation SLSender

- (instancetype)init
{
    return [self initWithJSONDictionary:nil];
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    if (self = [super init]) {
        self.name = jsonDictionary[@"name"];
        self.emailAddress = jsonDictionary[@"emailAddress"];
        self.profileImageURL = jsonDictionary[@"image"];
        self.unreadCount = [jsonDictionary[@"unread"] integerValue];
    }
    
    return self;
}

@end
