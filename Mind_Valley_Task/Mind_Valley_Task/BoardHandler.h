//
//  BoardHandler.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheManager.h"
#import "APIService.h"

#import <UIKit/UIKit.h>

//#define REST_API_URL @"https://vistajet.000webhostapp.com/sample.json"
#define REST_API_URL @"http://pastebin.com/raw/wgkJgazE"


#define CACHE_SIZE_LIMIT 29
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH  (SCREEN_BOUNDS.size.width)
#define SCREEN_HEIGHT (SCREEN_BOUNDS.size.height)
#define IMAGE_WIDTH  150.0
#define IMAGE_HEIGHT 150.0
#define SHOW_MORE_CELL_HEIGHT 50.0

#define PAGE_COUNT 12

@protocol PinBoardHandlerDelegate ;

@interface BoardHandler : NSObject {
    int currentCount;
    int totalCount ;
}

@property(nonatomic,weak) _Nullable id<PinBoardHandlerDelegate> delegate;


@property(nonatomic,assign) enum API_TYPE apiType;

@property(nonatomic,strong)  NSMutableArray* _Nullable  pinBoardWallObjects;
@property (nonatomic,strong) CacheManager* _Nullable cacheManager;
@property (nonatomic,strong) APIService* _Nullable apiService;
@property(nonatomic) BOOL showLoader;

- (void) fetchPinBoardDetailsFromServer :(API_TYPE)apiType ;

- (NSInteger)numberOfSectionsInCollectionView:( UICollectionView * _Nullable )collectionView;

- (NSInteger)collectionView:(UICollectionView * _Nullable)collectionView numberOfItemsInSection:(NSInteger)section ;

- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nullable)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nullable)indexPath ;

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout * _Nullable)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nullable)indexPath ;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section ;

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (void) showImage:(nullable UIImage*)pinBoardImage withAnimation:(nullable UIImageView*)pinBoardImageView  ;

- (void) resetValue  ;




@end


@protocol PinBoardHandlerDelegate <NSObject>

- (void) showLoader ;
- (void) hideLoader ;
- (void) reloadCollectionView ;
- (nullable UICollectionView*) getUICollectionView ;

@end
