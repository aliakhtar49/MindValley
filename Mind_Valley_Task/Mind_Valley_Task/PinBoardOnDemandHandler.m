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
#import "PendingOperations.h"
#import "ShowMoreCollectionViewCell.h"

#define CANCEL_STATE 1
#define DOWNLOAD_STATE 0

@interface PinBoardOnDemandHandler (){
    
}

@property(nonatomic,strong) PendingOperations* pendingOperations;

@end

@implementation PinBoardOnDemandHandler


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pendingOperations = [[PendingOperations alloc] init];
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
    /*Show load more view cell*/
    if (self.showLoader) {
        
        return (int)self.pinBoardWallObjects.count + 1 ;
    }
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
       
        [cell animateLoader];
        
        return cell;
    }
    
    else {
        
        OnDemandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OnDemandCollectionViewCell class]) forIndexPath:indexPath];
        [cell.pinBoardLabel setText:[(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] userName]];
        cell.delegate = self ;
        
        
        NSString* imageUrl = [(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] userProfileImageUrl] ;
        
       [cell hideDownloadAndCancelButton:[(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] imageRecordState]];
        

        if(![self.cacheManager getCachedImageForKey:imageUrl]) {
            
            cell.pinBoardImageView.image = nil;
            
            
        }
        else {
            
            
            cell.pinBoardImageView.image = [self.cacheManager getCachedImageForKey:imageUrl]  ;
            
            
          
            
        }
        
         return cell;
    }
    
  
   
}


- (void)cancelButtonTapped:(id)sender {
    
    UIButton *button = (UIButton *) sender;
    
    OnDemandCollectionViewCell *cell = (OnDemandCollectionViewCell *)[[button superview] superview];
    
    NSIndexPath *indexPath = [[self.delegate getUICollectionView] indexPathForCell:cell];
    
    ImageDownloader* pendingDownload = [self.pendingOperations.downloadsInProgress objectForKey:indexPath];
    [pendingDownload cancel];
    
}
-(void)actionButtonTapped:(id)sender {
    
    UIButton *button = (UIButton *) sender;
    
    OnDemandCollectionViewCell *cell = (OnDemandCollectionViewCell *)[[button superview] superview];
    
    
    
    
    
    NSIndexPath *indexPath = [[self.delegate getUICollectionView] indexPathForCell:cell];
    
    
   
    PinBoardModel* pinBoardModel =    (PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row];
    
    
    //1
    if([[self.pendingOperations.downloadsInProgress allKeys] containsObject:indexPath]){
        return;
    }
    
    pinBoardModel.imageRecordState = InProgress ;
    
    [cell hideDownloadAndCancelButton:[(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] imageRecordState]];
    //2
    ImageDownloader* downloader = [[ImageDownloader alloc] initWith:pinBoardModel with:self.cacheManager];
    
    
    __weak ImageDownloader *downloaderObject = downloader;
    [downloader setCompletionBlock:^{
        
        if(downloaderObject.isCancelled)  {
            [self.pendingOperations.downloadsInProgress removeObjectForKey:indexPath];
            pinBoardModel.imageRecordState = New;
            [cell hideDownloadAndCancelButton:[(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] imageRecordState]];
            
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pendingOperations.downloadsInProgress removeObjectForKey:indexPath];
            
            pinBoardModel.imageRecordState = DOWNLOAD_STATE;
            [[self.delegate getUICollectionView] reloadData];
            
        });
        
    }] ;
    
    //4
    [self.pendingOperations.downloadsInProgress setObject:downloader forKey:indexPath];
    
    //5
    [self.pendingOperations.downloadQueue addOperation:downloader];
    //[downloader cancel];


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
