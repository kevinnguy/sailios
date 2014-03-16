//
//  SLBin.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLBin.h"

#import "SLSender.h"

@implementation SLBin

- (instancetype)init
{
    return [self initWithJSONDictionary:nil];
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    if (self = [super init]) {
        self.name = jsonDictionary[@"title"];
        
        NSMutableArray *sendersArray = [NSMutableArray new];
        for (NSDictionary *senderDictionary in jsonDictionary[@"senders"]) {
            SLSender *sender = [[SLSender alloc] initWithJSONDictionary:senderDictionary];
            [sendersArray addObject:sender];
        }
        self.sendersArray = [sendersArray copy];
    }
    
    return self;
}

@end
