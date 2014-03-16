//
//  SLSender.h
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLUser.h"

@interface SLSender : SLUser
@property (nonatomic, strong) NSMutableArray *emailsArray;
@property (nonatomic, assign) NSInteger unreadCount;

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
