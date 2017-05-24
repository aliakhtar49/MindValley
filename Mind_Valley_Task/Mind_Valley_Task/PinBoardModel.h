//
//  PinBoardModel.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinBoardModel : NSObject

@property (nonatomic) int userId;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userProfileImageUrl;



- (instancetype)initWithName:(NSString*)name withUserId:(NSString*)userId withUserImageUrl:(NSString*)imageUrl;

@end
