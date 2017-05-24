//
//  ShowMoreCollectionViewCell.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "ShowMoreCollectionViewCell.h"

@implementation ShowMoreCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)animateLoader {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.activityIndicator startAnimating];
    });
}
@end
