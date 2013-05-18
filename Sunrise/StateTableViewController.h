//
//  StateTableViewController.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: Use the state list from entry view to show a tableview
//                    for user to choose a state.

#import <UIKit/UIKit.h>
#import "CityDBData.h"
#import "CityTableViewController.h"

@interface StateTableViewController : UITableViewController

// Array of all states
@property (strong, nonatomic) NSArray* states;

@end
