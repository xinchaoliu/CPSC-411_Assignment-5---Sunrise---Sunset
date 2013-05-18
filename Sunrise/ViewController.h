//
//  ViewController.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: The entry view, show two button for two different way to
//                    check the sun time.

#import <UIKit/UIKit.h>
#import "CityDatabase.h"
#import "StateTableViewController.h"

@interface ViewController : UIViewController

// Array of all states
@property (strong, nonatomic) NSArray* states;

@end
