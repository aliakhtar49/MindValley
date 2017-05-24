//
//  PinBoardHandler.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/23/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "PinBoardHandler.h"
#import "PinboardCollectionViewCell.h"
#import "CacheManager.h"
#import "PinBoardModel.h"
#import <QuartzCore/QuartzCore.h>
#import "NetworkHandler.h"
#import "APIService.h"
#import "ShowMoreCollectionViewCell.h"


#define REST_API_URL @"https://vistajet.000webhostapp.com/sample.json"


#define CACHE_SIZE_LIMIT 29
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH  (SCREEN_BOUNDS.size.width)
#define SCREEN_HEIGHT (SCREEN_BOUNDS.size.height)
#define IMAGE_WIDTH  150.0
#define IMAGE_HEIGHT 150.0
#define PAGE_COUNT 12

@interface PinBoardHandler() {
    
    int currentCount;
    int totalCount ;
    
}
@property(nonatomic,strong) NSMutableArray* pinBoardWallObjects;
@property (nonatomic,strong) CacheManager* cacheManager;
@property (nonatomic,strong) APIService* apiService;
@property(nonatomic) BOOL showLoader;

@end

@implementation PinBoardHandler

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
- (void) resetValue {
    
    currentCount = -1;
    [self.cacheManager removeAllCachedImages];
    
}

- (void) fetchPinBoardDetailsFromServer :(API_TYPE)apiType {
    
  
    //show loader while fetching data from server
    
    [self.delegate showLoader];
    
    
    [self.apiService loadJsonData:REST_API_URL withCurrentCount:currentCount withMaxpageCount:PAGE_COUNT andSucess:^(NSArray *pinboardWallObjectArray) {
        [NSThread sleepForTimeInterval:5.0];
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
    
    PinboardCollectionViewCell* cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PinboardCollectionViewCell class]) forIndexPath:indexPath];
    [cell.pinBoardLabel setText:[(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] userName]];
    
    
    NSString* imageUrl = [(PinBoardModel*)[self.pinBoardWallObjects objectAtIndex:indexPath.row] userProfileImageUrl] ;
    
    if(![self.cacheManager getCachedImageForKey:imageUrl]) {
        
        NetworkHandler* networkHandler = [[NetworkHandler alloc] init];
        [networkHandler loadAsync:imageUrl andSucess:^(NSData *responseData) {
            
            
            UIImage* pinBoardImage = [[UIImage alloc] initWithData:responseData] ;
            
            [self.cacheManager setCacheImage:pinBoardImage forKey:imageUrl];
            [CATransaction begin];
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
            animation.fromValue = [NSNumber numberWithFloat:0 * M_PI / 180];
            animation.toValue = [NSNumber numberWithFloat:180 * M_PI / 180];
            animation.duration = 0.5;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
            
            cell.pinBoardImageView.image = [UIImage imageNamed:@" "];
            
            [CATransaction setCompletionBlock:^{
                cell.pinBoardImageView.image = pinBoardImage;
                
            }];
            
            [cell.pinBoardImageView.layer addAnimation:animation forKey:@"rotationAnimation"];
            
            [CATransaction commit];
            
            
            cell.pinBoardImageView.image = pinBoardImage ;
            
        } AndFailure:^(NSError *error) {
            
        }];
        
    }
    else {
        
        cell.pinBoardImageView.image = [self.cacheManager getCachedImageForKey:imageUrl] ;
        
    }
    
    
    
    return cell;
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
