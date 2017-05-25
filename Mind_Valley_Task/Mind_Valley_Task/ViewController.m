//
//  ViewController.m
//  Mind_Valley_Task
//
//  Created by Ali Akhtar on 5/22/17.
//  Copyright © 2017 Ali Akhtar. All rights reserved.
//

#import "ViewController.h"
#import "PinBoardViewController.h"
#import "PinBoardOnDemandHandler.h"
#import "PinBoardDefaultHandler.h"


#define HomeToPinBoardViewController @"HomeToPinBoardViewController"




@interface ViewController (){
    
    
    
}

@property(nonatomic,assign) BOOL isOnDemandPinBoard;




@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isOnDemandPinBoard = NO;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PinBoardViewController* pinBoardViewController = segue.destinationViewController;
    
    if(self.isOnDemandPinBoard) {
    pinBoardViewController.pinBoardHandler = [[PinBoardOnDemandHandler alloc] init];
    }else{
        pinBoardViewController.pinBoardHandler = [[PinBoardDefaultHandler alloc] init];
    }
    
}
- (IBAction)onDemandPinBoardButtonTapped:(id)sender {
    _isOnDemandPinBoard = YES ;
    [self performSegueWithIdentifier:HomeToPinBoardViewController sender:self];
}
- (IBAction)defaultPinBoardButtonTapped:(id)sender {
    [self performSegueWithIdentifier:HomeToPinBoardViewController sender:self];
}

- (void)viewDidLoad {
    

    [super viewDidLoad];
   

    
    
    // Do any additional setup after loading the view, typically from a nib.
}


@end
