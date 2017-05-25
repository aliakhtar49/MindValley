//
//  PinBoardModel.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheManager.h"
#import <UIKit/UIKit.h>

@interface PinBoardModel : NSObject

@property (nonatomic) int userId;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userProfileImageUrl;
@property (nonatomic,assign) enum ImageRecordState imageRecordState;
@property (nonatomic,strong)  UIImage* image;



- (instancetype)initWithName:(NSString*)name withUserId:(NSString*)userId withUserImageUrl:(NSString*)imageUrl;

@end



@interface ImageDownloader : NSOperation {
    
    
}
@property(nonatomic,strong) PinBoardModel* photoRecord ;
@property(nonatomic,strong) CacheManager* cacheManager ;

-(instancetype)initWith:(PinBoardModel*)imageRecord with:(CacheManager*)cacheManger ;

@end
