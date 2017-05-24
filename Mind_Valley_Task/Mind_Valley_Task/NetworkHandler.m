//
//  NetworkHandler.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "NetworkHandler.h"

@implementation NetworkHandler

- (void)loadAsync:(NSString*)urlString andSucess:(void (^)(NSData *responseData))success AndFailure:(void (^)(NSError *error))failure
{
   
    NSURL *url = [[NSURL alloc] initWithString:urlString];
  
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                if(data) {
                    success(data);
                }
                else{
                    failure(error);
                }
                
                
            }] resume];
}
@end
