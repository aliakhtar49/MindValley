//
//  APIService.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "APIService.h"
#import "NetworkHandler.h"
#import "PinBoardModel.h"

@interface APIService (){
    
    int totalCount ;
    
}
@end


@implementation APIService

- (int) getTotalCount {
    
    return totalCount;
}

- (void)loadJsonData:(NSString*)urlString withCurrentCount:(int)currentCount withMaxpageCount:(int)pageCount andSucess:(void (^)(NSArray *))success AndFailure:(void (^)(NSError *))failure {
    
    
    NetworkHandler* networkHandler = [[NetworkHandler alloc] init];
    [networkHandler loadAsync:urlString andSucess:^(NSData *responseData) {
        
        NSError *localError = nil;
        
        
        NSMutableArray* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                               options:kNilOptions
                                                                 error:&localError];
        int initial ;
        int condition ;
        
        totalCount = (int)json.count ;
        
        if (currentCount + pageCount <= totalCount - 1 ) {
            initial = currentCount + 1 ;
            condition = pageCount ;
        }
        else if(currentCount + pageCount > totalCount - 1 && currentCount < totalCount - 1 ){
            initial = currentCount + 1 ;
            condition = totalCount - initial ;
        }
        else{
            success(nil);
        }
       
        NSMutableArray* binBoardArray = [[NSMutableArray alloc] init];
        for(int i = initial;i<initial+condition;i++) {
            NSString* userId =   [[json objectAtIndex:i] valueForKey:@"id"];
            NSString* userName =   [[[json objectAtIndex:i] valueForKey:@"user"] valueForKey:@"name"];
            NSString* imageUrl = [[[json objectAtIndex:i] valueForKey:@"urls"] valueForKey:@"thumb"];
            
            PinBoardModel* pinBoardModel = [[PinBoardModel alloc]initWithName:userName withUserId:userId withUserImageUrl:imageUrl];
            [binBoardArray addObject:pinBoardModel];
            
        }
        
        success(binBoardArray);
        
        
    } AndFailure:^(NSError *error) {
        
        failure(error);
    }];
    
}



@end
