//
//  SecondViewController.m
//  iOS Boiler Plate
//
//  Created by tunlin on 12/18/14.
//  Copyright (c) 2014 Bixels. All rights reserved.
//

#import "SecondViewController.h"
#import <Parse/Parse.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PFQuery *query = [PFQuery queryWithClassName:@"Result"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSLog(@"Object count : %d", [objects count]);
        } else {
            NSLog(@"error : %@", [error description]);
        }
    }];
}
@end
