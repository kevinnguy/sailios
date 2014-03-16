//
//  SLBin.h
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLBin : NSObject
@property (nonatomic, copy) NSString *binId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *notification;
@property (nonatomic, strong) NSArray *sendersArray;


- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
