//
//  SLBinTableViewCell.h
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLBinCollectionView.h"

FOUNDATION_EXPORT NSString *const kSLBinCollectionViewIdentifier;

@interface SLBinTableViewCell : UITableViewCell

@property (nonatomic, strong) SLBinCollectionView *collectionView;





@end