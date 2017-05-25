//
//  OnDemandCollectionViewCell.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "OnDemandCollectionViewCell.h"

@implementation OnDemandCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)hideDownloadAndCancelButton:(int)imageRecordState {
    
    switch (imageRecordState) {
        case New:
            self.cancelButton.hidden = YES;
            self.actionButton.hidden = NO;
            self.activityIndicator.hidden = YES;
            break;
        case Downloaded:
            self.cancelButton.hidden = YES;
            self.actionButton.hidden = YES;
            self.activityIndicator.hidden = YES;
            break;
        case InProgress:
            self.cancelButton.hidden = NO;
            self.actionButton.hidden = YES;
            self.activityIndicator.hidden = NO;
            [self startAnimation];
            break;
            
        default:
            break;
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.delegate cancelButtonTapped:sender];
}

- (IBAction)actionButtonTapped:(id)sender {
    
    [self.delegate actionButtonTapped:sender];
    
}

- (void) startAnimation {
    
    [self.activityIndicator startAnimating];
   
}
- (void) stopAnimation {
    
    [self.activityIndicator stopAnimating];
    
}
@end
