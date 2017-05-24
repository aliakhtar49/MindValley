//
//  CacheManager.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/23/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CacheManager : NSObject



- (instancetype)initWithMaxCapacity:(NSInteger)count;

- (UIImage*)getCachedImageForKey:(NSString*)key ;

- (void)setCacheImage:(UIImage*)image forKey:(NSString*)key ;

- (void) removeAllCachedImages ;


@end
