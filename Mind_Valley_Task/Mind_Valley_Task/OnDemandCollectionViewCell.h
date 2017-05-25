//
//  OnDemandCollectionViewCell.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OnDemandCollectionViewCellDelegate ;

@interface OnDemandCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;


@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *pinBoardImageView;
@property (weak, nonatomic) IBOutlet UILabel *pinBoardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *progreeImageView;
@property(nonatomic,weak) id<OnDemandCollectionViewCellDelegate> delegate;
- (IBAction)cancelButtonTapped:(id)sender;

- (IBAction)actionButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButtonTapped;


- (void) stopAnimation ;
- (void) startAnimation ;

- (void)hideDownloadAndCancelButton:(int)imageRecordState;

@end


@protocol OnDemandCollectionViewCellDelegate <NSObject>

- (IBAction)actionButtonTapped:(id)sender ;

- (IBAction)cancelButtonTapped:(id)sender ;



@end
