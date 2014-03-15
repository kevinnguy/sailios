//
//  SLBinTableViewCell.m
//  Sail
//
//  Created by Kevin Nguy on 3/15/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "SLBinTableViewCell.h"

NSString *const kSLBinTableViewCellIdentifier = @"SLBinTableViewCellIdentifier";
NSString *const kSLBinCollectionViewIdentifier = @"SLBinCollectionViewIdentifier";

@implementation SLBinTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Setup
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Create layout
        LXReorderableCollectionViewFlowLayout *layout = [[LXReorderableCollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        layout.itemSize = CGSizeMake(60, 60);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // Collection view
        self.collectionView = [[SLBinCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kSLBinCollectionViewIdentifier];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
        
        // Label and slider
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.font = [UIFont systemFontOfSize:20.0f];
        [self.contentView addSubview:self.nameLabel];
        
        self.notificationSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.notificationSwitch];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.frame = CGRectMake(0,
                                      0,
                                      CGRectGetWidth(self.contentView.bounds) - 50,
                                      30);
    
    self.notificationSwitch.frame = CGRectMake(CGRectGetWidth(self.nameLabel.frame),
                                               0,
                                               CGRectGetWidth(self.contentView.bounds) - CGRectGetWidth(self.nameLabel.frame),
                                               CGRectGetHeight(self.nameLabel.frame));
    
    self.collectionView.frame = CGRectMake(0,
                                           CGRectGetHeight(self.nameLabel.frame),
                                           CGRectGetWidth(self.contentView.bounds),
                                           60 + 15 + 15);
}

- (void)setBinCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate index:(NSInteger)index
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.index = index;
    
    [self.collectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
