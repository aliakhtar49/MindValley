//
//  APIService.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIService : NSObject


- (int) getTotalCount ;

- (void)loadJsonData:(NSString*)urlString withCurrentCount:(int)currentCount withMaxpageCount:(int)pageCount andSucess:(void (^)(NSArray *))success AndFailure:(void (^)(NSError *))failure;

@end
