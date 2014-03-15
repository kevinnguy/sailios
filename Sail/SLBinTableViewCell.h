//
//  SLBinTableViewCell.h
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLBin.h"
#import "SLBinCollectionView.h"

#import "LXReorderableCollectionViewFlowLayout.h"

FOUNDATION_EXPORT NSString *const kSLBinTableViewCellIdentifier;
FOUNDATION_EXPORT NSString *const kSLBinCollectionViewIdentifier;

@interface SLBinTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UISwitch *notificationSwitch;
@property (nonatomic, strong) SLBinCollectionView *collectionView;

- (void)setBinCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index;




@end
