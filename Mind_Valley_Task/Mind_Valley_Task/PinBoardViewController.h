//
//  PinBoardViewController.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardHandler.h"
#import "ShowMoreCollectionViewCell.h"

@interface PinBoardViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PinBoardHandlerDelegate>

@property (nonatomic,strong) BoardHandler* pinBoardHandler;

@end
