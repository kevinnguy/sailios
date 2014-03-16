//
//  SLAPIManager.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLAPIManager.h"


#import <AFNetworking/AFNetworking.h>

@implementation SLAPIManager

+ (instancetype)sharedManager
{
    static SLAPIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (void)getUserProfileWithURL:(NSURL *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    __weak SLAPIManager *weakSelf = self;
    [manager GET:url.absoluteString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonDictionary = responseObject;
        SLUser *user = [[SLUser alloc] initWithJSONDictionary:jsonDictionary[@"user"]];
        [weakSelf.delegate didGetUserProfile:user];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)getUserBinsWithURL:(NSURL *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    __weak SLAPIManager *weakSelf = self;
    [manager GET:url.absoluteString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonDictionary = responseObject;
        NSArray *binsJSONArray = jsonDictionary[@"bins"];
        NSMutableArray *binsArray = [NSMutableArray new];
        
        for (NSDictionary *binDictionary in binsJSONArray) {
            SLBin *bin = [[SLBin alloc] initWithJSONDictionary:binDictionary];
            [binsArray addObject:bin];
        }
        
        [weakSelf.delegate didGetUserBins:[binsArray copy]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
