//
//  BoardHandler.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "BoardHandler.h"

@implementation BoardHandler

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
}

- (void) showImage:(UIImage*)pinBoardImage withAnimation:(UIImageView*)pinBoardImageView {
    
    [CATransaction begin];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = [NSNumber numberWithFloat:0 * M_PI / 180];
    animation.toValue = [NSNumber numberWithFloat:180 * M_PI / 180];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    pinBoardImageView.image = [UIImage imageNamed:@" "];
    
    [CATransaction setCompletionBlock:^{
        pinBoardImageView.image = pinBoardImage;
        
    }];
    
    [pinBoardImageView.layer addAnimation:animation forKey:@"rotationAnimation"];
    
    [CATransaction commit];
}

- (void) resetValue {
    
    currentCount = -1;
    [self.cacheManager removeAllCachedImages];
    
}

- (void) fetchPinBoardDetailsFromServer :(API_TYPE)apiType {
    
    
    //show loader while fetching data from server
    
    [self.delegate showLoader];
    
    
    [self.apiService loadJsonData:REST_API_URL withCurrentCount:currentCount withMaxpageCount:PAGE_COUNT andSucess:^(NSArray *pinboardWallObjectArray) {
//       [NSThread sleepForTimeInterval:5.0];
        self.showLoader  = NO ;
        if(pinboardWallObjectArray == nil) return ;
        currentCount = currentCount + (int) pinboardWallObjectArray.count ;
        
        if(self.apiType == PULL_TO_REFRESH) {
            
            [self.pinBoardWallObjects removeAllObjects];
            
        }
        [self.pinBoardWallObjects addObjectsFromArray:pinboardWallObjectArray];
        [self.delegate reloadCollectionView];
        
        //hide loader after fetched data from server
        [self.delegate hideLoader];
        
        
    } AndFailure:^(NSError *error) {
        
        [self.delegate hideLoader];
        self.showLoader  = NO ;
        //hide loader after call is failed for some reason
        
        
    }];
    
}

@end
