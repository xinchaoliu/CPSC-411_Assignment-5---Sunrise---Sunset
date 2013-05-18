//
//  CityTableViewController.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: The cityTableView allow user to choose a city from the
//                    state they choosen. There's a search bar at the top to
//                    help user easily find the city they want.

#import <UIKit/UIKit.h>
#import "CityDatabase.h"
#import "CityDBData.h"
#import "MainTableViewController.h"

@interface CityTableViewController : UITableViewController

// Received state from StateTableView
@property (strong, nonatomic) NSString* theState;

// Array of all citites in the state
@property (strong, nonatomic) NSArray* cities;

// Array of all city names
@property (strong, nonatomic) NSMutableArray* cityNames;

// search results
@property (strong, nonatomic) NSArray* searchResults;

@end
