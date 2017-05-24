//
//  NetworkHandler.h
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkHandlerDelegate;




@interface NetworkHandler : NSObject

@property (weak, nonatomic) id<NetworkHandlerDelegate> delegate;


- (void)loadAsync:(NSString*)urlString andSucess:(void (^)(NSData *responseData))success AndFailure:(void (^)(NSError *error))failure ;

@end



@protocol NetworkHandlerDelegate

- (void)receivedData:(NSData *)data;
- (void)fetchingFailedWithError:(NSError *)error;

@end
