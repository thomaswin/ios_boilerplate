//
//  AppDelegate.m
//  iOS Boiler Plate
//
//  Created by tunlin on 12/18/14.
//  Copyright (c) 2014 Bixels. All rights reserved.
//

#import "AppDelegate.h"

#import <Parse/Parse.h>
#import <ParseCrashReporting/ParseCrashReporting.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


    // [ParseCrashReporting enable];
    [Parse setApplicationId:@"l25R1Oozg0t7ClB3FWE9gw6fJhkkleFbWCN6EXKR"
                  clientKey:@"STbWWnzzfiYzINCZe2RkXJMwFqWW836XfcTgOyq8"];
    [Parse enableLocalDatastore];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self localDatastoreTrial];
    

    return YES;
}


- (void) localDatastoreTrial {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                       
                       PFQuery *query = [PFQuery queryWithClassName:@"Result"];
                       [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                           
                           [PFObject unpinAllInBackground:objects withName:@"scores" block:^(BOOL succeeded, NSError *error) {
                               
                               [PFObject pinAllInBackground:objects withName:@"scores" block:^(BOOL succeeded, NSError *error) {
                                   
                                   if (error == nil) {
                                       
                                       NSLog(@"Pin count : %d", [objects count]);
                                       
                                   } else {
                                       NSLog(@"Pin in background complete ERROR ");
                                   }

                               }];
                               
                           }];
                       }];
                   });
}

- (void) crashTest {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSException raise:NSGenericException format:@"Everything is ok. This is just a test crash."];
    });
}

- (void)crash {
    [NSException raise:NSGenericException format:@"Everything is ok. This is just a test crash."];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
