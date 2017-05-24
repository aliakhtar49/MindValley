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
