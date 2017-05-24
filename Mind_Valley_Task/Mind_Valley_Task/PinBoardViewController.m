//
//  PinBoardViewController.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/24/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "PinBoardViewController.h"

#import "MBProgressHUD.h"
#import "PinBoardDefaultHandler.h"
#import "PinBoardOnDemandHandler.h"
#import "OnDemandCollectionViewCell.h"

@interface PinBoardViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@property (nonatomic,strong) UIRefreshControl* refreshControl;
@property (nonatomic,strong) UIRefreshControl* bottomRefreshControl;


@end

@implementation PinBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.pinBoardHandler.apiType = DEFAULT ;
    self.pinBoardHandler.delegate = self ;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShowMoreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ShowMoreCollectionViewCell class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"OnDemandCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([OnDemandCollectionViewCell class])];
    
    
    
    /*Fetch pinboard data from server */
    [self.pinBoardHandler fetchPinBoardDetailsFromServer:self.pinBoardHandler.apiType];
    
    
    /*Pull to refresh*/
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view.
}

-(void) pullToRefresh{
    
    self.pinBoardHandler.apiType = PULL_TO_REFRESH;
    [self.pinBoardHandler resetValue];
    [self.pinBoardHandler fetchPinBoardDetailsFromServer:self.pinBoardHandler.apiType];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return [self.pinBoardHandler numberOfSectionsInCollectionView:collectionView];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.pinBoardHandler collectionView:collectionView numberOfItemsInSection:section];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [self.pinBoardHandler collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
}
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    [self.pinBoardHandler collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.pinBoardHandler collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return [self.pinBoardHandler collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    
    
}



#pragma mark PinBoardHandlerDelegate



- (void)showLoader {
    
    if(self.pinBoardHandler.apiType == DEFAULT){
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

- (void)reloadCollectionView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
}
- (void)hideLoader {
    
    if(self.refreshControl.refreshing){
        [self.refreshControl endRefreshing];
    }
    else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
}
- (UICollectionView *)getUICollectionView {
    return  _collectionView ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
