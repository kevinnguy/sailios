//
//  SLAPIManager.h
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLBin.h"
#import "SLUser.h"

@protocol SLAPIManagerDelegate <NSObject>

- (void)didGetUserProfile:(SLUser *)user;
- (void)didGetUserBins:(NSArray *)binsArray;

@end

@interface SLAPIManager : NSObject
@property (nonatomic, assign) id<SLAPIManagerDelegate> delegate;

+ (instancetype)sharedManager;

- (void)getUserProfileWithURL:(NSURL *)url;
- (void)getUserBinsWithURL:(NSURL *)url;

@end
