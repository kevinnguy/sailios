//
//  SLMainTableViewController.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLMainTableViewController.h"

#import "SLBin.h"

@interface SLMainTableViewController ()
@property (nonatomic, strong) NSMutableArray *binsArray;
@property (nonatomic, strong) NSMutableDictionary *binsContentOffsetIndexDictionary; // Used to remember the offset of content in a bin when scrolling
@end

@implementation SLMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBins];
    self.binsContentOffsetIndexDictionary = [NSMutableDictionary new];
}

- (void)setupBins
{
    // Create demo bins
    SLBin *familyAndFriendsBin = [[SLBin alloc] init];
    familyAndFriendsBin.name = @"Family and Friends";
    familyAndFriendsBin.notification = @YES;
    
    SLBin *workBin = [[SLBin alloc] init];
    workBin.name = @"Work";
    workBin.notification = @NO;
    
    SLBin *promotionsBin = [[SLBin alloc] init];
    promotionsBin.name = @"Promotions";
    promotionsBin.notification = @NO;
    
    self.binsArray = [@[familyAndFriendsBin, workBin, promotionsBin] mutableCopy];
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.binsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    
    return cell;
}


@end
