//
//  ShowMoreCollectionViewCell.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMoreCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)animateLoader ;

 
@end
