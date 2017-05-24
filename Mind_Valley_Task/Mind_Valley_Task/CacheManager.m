//
//  CacheManager.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/23/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "CacheManager.h"



@interface CacheManager(){
 
    
    
}

@property (nonatomic, strong) NSCache *imageCache;

@end

@implementation CacheManager

- (instancetype)initWithMaxCapacity:(NSInteger)count
{
    self = [super init];
    if (self) {
        
        /*Initialize Cache */
        self.imageCache = [[NSCache alloc] init];
        [self.imageCache setCountLimit:count];
        
    }
    return self;
}

- (void)setCacheImage:(UIImage*)image forKey:(NSString*)key {
    
    [self.imageCache setObject:image forKey:key];
    
}

- (UIImage*)getCachedImageForKey:(NSString*)key {
    
    return [self.imageCache objectForKey:key];
    
}

- (void) removeAllCachedImages {
    
    [self.imageCache removeAllObjects];
    
}

@end
