//
//  SLUser.h
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLUser : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *emailAddress;
@property (nonatomic, strong) NSURL *profileImageURL;

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary;
- (instancetype)initWithName:(NSString *)name emailAddress:(NSString *)emailAddress profileImageURL:(NSURL *)profileImageURL;

@end
