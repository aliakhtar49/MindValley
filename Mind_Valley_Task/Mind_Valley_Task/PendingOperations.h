//
//  PendingOperations.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/25/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PendingOperations : NSObject

@property(nonatomic,strong) NSMutableDictionary*  downloadsInProgress;
@property(nonatomic,strong) NSOperationQueue*  downloadQueue;

@end
