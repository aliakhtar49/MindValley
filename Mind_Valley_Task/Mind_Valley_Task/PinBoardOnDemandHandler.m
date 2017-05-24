//
//  PinBoardOnDemandHandler.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "PinBoardOnDemandHandler.h"
#import "PinboardCollectionViewCell.h"
#import "CacheManager.h"
#import "PinBoardModel.h"
#import <QuartzCore/QuartzCore.h>
#import "NetworkHandler.h"
#import "APIService.h"
#import "ShowMoreCollectionViewCell.h"


@implementation PinBoardOnDemandHandler


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cacheManager = [[CacheManager alloc] initWithMaxCapacity:CACHE_SIZE_LIMIT];
        currentCount = -1 ;
        self.pinBoardWallObjects = [[NSMutableArray alloc] init];
        self.apiService = [[ APIService alloc] init];
        
        
    }
    return self;
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.showLoader) {
        return (int)self.pinBoardWallObjects.count + 1 ;}
    else{
        return (int)self.pinBoardWallObjects.count;
    }
}
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    if (self.showLoader == NO && self.pinBoardWallObjects && indexPath.row == (self.pinBoardWallObjects.count - 1) && self.pinBoardWallObjects.count < [self.apiService getTotalCount]) {
        
        self.showLoader = YES;
        
        
        
        [self.delegate reloadCollectionView];
        
        self.apiType = SHOW_MORE ;
        [self fetchPinBoardDetailsFromServer:self.apiType];
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.pinBoardWallObjects.count ) {
        ShowMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShowMoreCollectionViewCell class]) forIndexPath:indexPath];
        // [cell setBackgroundColor:[UIColor greenColor]];
        [cell animateLoader];
        return cell;
    }
    
    
    OnDemandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OnDemandCollectionViewCell class]) forIndexPath:indexPath];
    [cell.pinBoardLabel setText:[(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] userName]];
    cell.delegate = self ;
    
    
    NSString* imageUrl = [(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] userProfileImageUrl] ;
    
    if(![self.cacheManager getCachedImageForKey:imageUrl]) {
        
        cell.pinBoardImageView.image = [UIImage imageNamed:@""];
    }
    else {
        
        [self showImage: [self.cacheManager getCachedImageForKey:imageUrl] withAnimation:cell.pinBoardImageView];
        
    }
    
    
    
    return cell;
}

-(void)actionButtonTapped:(id)sender {
    
    UIButton *button = (UIButton *) sender;
    
    
    OnDemandCollectionViewCell *cell = (OnDemandCollectionViewCell *)[[button superview] superview];
    
    NSIndexPath *indexPath = [[self.delegate getUICollectionView] indexPathForCell:cell];
    
    NSString* imageUrl = [(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] userProfileImageUrl] ;
    
    if(![self.cacheManager getCachedImageForKey:imageUrl]) {
        
        [cell startAnimation];
        NetworkHandler* networkHandler = [[NetworkHandler alloc] init];
        [networkHandler loadAsync:imageUrl andSucess:^(NSData *responseData) {
            
            [cell stopAnimation];
            UIImage* pinBoardImage = [[UIImage alloc] initWithData:responseData] ;
            
            [self.cacheManager setCacheImage:pinBoardImage forKey:imageUrl];
            [self showImage:pinBoardImage withAnimation:cell.pinBoardImageView];
            
            
            
            // cell.pinBoardImageView.image = pinBoardImage ;
            
        } AndFailure:^(NSError *error) {
            
            [cell stopAnimation] ;
            
        }];
        
    }
    else {
        
        [self showImage: [self.cacheManager getCachedImageForKey:imageUrl] withAnimation:cell.pinBoardImageView];
        
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.pinBoardWallObjects.count) {
        return CGSizeMake(SCREEN_WIDTH, 50.0);
    }
    return CGSizeMake(IMAGE_WIDTH, IMAGE_HEIGHT);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}

- (void)dealloc
{
    [self.cacheManager removeAllCachedImages];
}

@end
