//
//  PinBoardModel.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "PinBoardModel.h"


@implementation PinBoardModel


- (instancetype)initWithName:(NSString*)name withUserId:(NSString*)userId withUserImageUrl:(NSString*)imageUrl
{
    self = [super init];
    if (self) {
        
        self.userName = name;
        self.userId = userId;
        self.imageRecordState = New;
        self.userProfileImageUrl = imageUrl;
        
    }
    return self;
}

- (NSMutableArray*) parsePinBoardJsonObjects:(NSDictionary*)json {
    
    NSMutableArray* user = [json valueForKey:@"user"];
    NSMutableArray* binBoardArray = [[NSMutableArray alloc] init];
    
    
    
    for(int i =0;i<user.count;i++) {
        NSString* userId =   [[user objectAtIndex:i] valueForKey:@"id"];
        NSString* userName =   [[user objectAtIndex:i] valueForKey:@"name"];
        NSString* imageUrl = [[[user objectAtIndex:1] valueForKey:@"profile_image"] valueForKey:@"large"];
        
        PinBoardModel* pinBoardModel = [[PinBoardModel alloc]initWithName:userName withUserId:userId withUserImageUrl:imageUrl];
        [binBoardArray addObject:pinBoardModel];
        
    }
    return binBoardArray;
    
}

@end




@implementation ImageDownloader

-(instancetype)initWith:(PinBoardModel*)imageRecord with:(CacheManager*)cacheManger
{
    self = [super init];
    if (self) {
        self.photoRecord = imageRecord ;
        self.cacheManager = cacheManger ;
    }
    return self;
}
- (void)main {
    
   
  
    
    
    if(self.cancelled) {
        return;
    }
    
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.photoRecord.userProfileImageUrl]] ;
    
    //6
    if (self.isCancelled) {
        
        return ;
        
    }
    
    //7
    if (imageData.length > 0 ){
        
        
       // self.photoRecord.image = [UIImage imageWithData:imageData];
        
        [self.cacheManager setCacheImage:[UIImage imageWithData:imageData] forKey:self.photoRecord.userProfileImageUrl];
        self.photoRecord.imageRecordState = Downloaded ;
    }
    else
    {
        self.photoRecord.imageRecordState = Failed ;
        //self.photoRecord.image = [UIImage imageNamed:@"Failed"];
    }
    
}
@end;
