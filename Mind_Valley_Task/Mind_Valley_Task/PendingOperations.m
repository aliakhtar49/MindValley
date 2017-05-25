//
//  PendingOperations.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/25/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "PendingOperations.h"

@implementation PendingOperations

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.downloadsInProgress = [[NSMutableDictionary alloc] init];
        self.downloadQueue = [[NSOperationQueue alloc] init];
        self.downloadQueue.name = @"Download queue";
        self.downloadQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

@end


