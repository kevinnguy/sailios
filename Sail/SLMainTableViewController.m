//
//  SLMainTableViewController.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLMainTableViewController.h"

#import "SLAPIManager.h"
#import "SLBinTableViewCell.h"

@interface SLMainTableViewController () <LXReorderableCollectionViewDataSource, LXReorderableCollectionViewDelegateFlowLayout, SLAPIManagerDelegate>

@property (nonatomic, strong) SLUser *user;

@property (nonatomic, strong) NSMutableArray *binsArray;
@property (nonatomic, strong) NSMutableDictionary *binsContentOffsetIndexDictionary; // Used to remember the offset of content in a bin when scrolling

@end

@implementation SLMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];

    self.binsArray = [NSMutableArray new];
    self.binsContentOffsetIndexDictionary = [NSMutableDictionary new];
    
    [[SLAPIManager sharedManager] getUserBinsWithURL:[NSURL URLWithString:@"http://pymailserver.herokuapp.com/users/12/bins"]];
    [[SLAPIManager sharedManager] getUserProfileWithURL:[NSURL URLWithString:@"http://pymailserver.herokuapp.com/users/12/profile"]];
}

- (void)setupNavigationBar
{
    // Left button
    UIBarButtonItem *profileBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStyleBordered target:self action:@selector(profileBarButtonPressed)];
    self.navigationItem.leftBarButtonItem = profileBarButton;
    
    // Right Button
    UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(profileBarButtonPressed)];
    self.navigationItem.rightBarButtonItem = searchBarButton;
    
    // Title view
    UISegmentedControl *readSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Unread", @"All"]];
    [readSegmentedControl addTarget:self action:@selector(readSegmentedControlPressed:) forControlEvents:UIControlEventValueChanged];
    readSegmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = readSegmentedControl;
}

- (void)readSegmentedControlPressed:(UISegmentedControl *)sender
{
    
}

- (void)profileBarButtonPressed
{
    // Do something
}

#pragma mark - UI Stuff

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
    return bin.sendersArray.count;
}

-(UICollectionViewCell *)collectionView:(SLBinCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSLBinCollectionViewIdentifier forIndexPath:indexPath];
    
    // Random colors!
//    CGFloat red = arc4random() % 255;
//    CGFloat green = arc4random() % 255;
//    CGFloat blue = arc4random() % 255;
//    UIColor *backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
//    
//    cell.backgroundColor = backgroundColor;
    

    
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

#pragma mark - LXReorderableCollectionViewDelegateFlowLayout methods

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will end drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did end drag");
}




#pragma mark - Network stuff

#pragma mark - SLAPIManagerDelegate
- (void)didGetUserProfile:(SLUser *)user {
    self.user = user;
}

- (void)didGetUserBins:(NSArray *)binsArray {
    self.binsArray = [binsArray copy];
    [self.tableView reloadData];
}




@end
