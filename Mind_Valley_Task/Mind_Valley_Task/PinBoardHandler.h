//
//  PinBoardHandler.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/23/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PinBoardHandlerDelegate ;

@interface PinBoardHandler : NSObject



@property(nonatomic,weak) id<PinBoardHandlerDelegate> delegate;

@property(nonatomic,assign) enum API_TYPE apiType;

- (void) fetchPinBoardDetailsFromServer :(API_TYPE)apiType ;

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section ;

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath ;

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath ;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section ;

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (void) resetValue  ;

@end



@protocol PinBoardHandlerDelegate <NSObject>

- (void) showLoader ;
- (void) hideLoader ;
- (void) reloadCollectionView ;

@end
