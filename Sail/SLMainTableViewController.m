//
//  SLMainTableViewController.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLMainTableViewController.h"

#import "SLBinTableViewCell.h"

@interface SLMainTableViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
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
    familyAndFriendsBin.emailCount = @15;
    
    SLBin *workBin = [[SLBin alloc] init];
    workBin.name = @"Work";
    workBin.notification = @NO;
    workBin.emailCount = @10;
    
    SLBin *promotionsBin = [[SLBin alloc] init];
    promotionsBin.name = @"Promotions";
    promotionsBin.notification = @NO;
    promotionsBin.emailCount = @29;
    
    self.binsArray = [@[familyAndFriendsBin, workBin, promotionsBin] mutableCopy];
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.binsArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SLBinTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBinCollectionViewDataSourceDelegate:self index:indexPath.row];
    NSInteger index = cell.collectionView.index;
    
    CGFloat horizontalOffset = [self.binsContentOffsetIndexDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLBinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSLBinTableViewCellIdentifier];
    if (!cell) {
        cell = [[SLBinTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSLBinTableViewCellIdentifier];
    }
    
    SLBin *bin = self.binsArray[indexPath.row];
    cell.nameLabel.text = bin.name;
    cell.notificationSwitch.on = [bin.notification boolValue];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1 + 1 + 30 + 15 + 15+ 56; // separator + separator + label + layout + layout + collection view cell
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(SLBinCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SLBin *bin = self.binsArray[collectionView.index];
    return [bin.emailCount integerValue];
}

-(UICollectionViewCell *)collectionView:(SLBinCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSLBinCollectionViewIdentifier forIndexPath:indexPath];
    
    // Random colors!
    CGFloat red = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    CGFloat blue = arc4random() % 255;
    UIColor *backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
    
    cell.backgroundColor = backgroundColor;
    
    return cell;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[SLBinCollectionView class]]) {
        SLBinCollectionView *collectionView = (SLBinCollectionView *)scrollView;
        
        CGFloat horizontalOffset = scrollView.contentOffset.x;
        self.binsContentOffsetIndexDictionary[[@(collectionView.index) stringValue]] = @(horizontalOffset);
    }
}


@end
