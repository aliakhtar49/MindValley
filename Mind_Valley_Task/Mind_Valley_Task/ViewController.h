//
//  ViewController.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinBoardHandler.h"
#import "ShowMoreCollectionViewCell.h"

@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PinBoardHandlerDelegate>


@end

