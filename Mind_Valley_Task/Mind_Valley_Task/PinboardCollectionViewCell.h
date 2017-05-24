//
//  PinboardCollectionViewCell.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinboardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pinBoardImageView;
@property (weak, nonatomic) IBOutlet UILabel *pinBoardLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
