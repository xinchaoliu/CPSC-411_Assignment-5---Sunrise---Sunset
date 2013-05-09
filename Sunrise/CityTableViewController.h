//
//  CityTableViewController.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityDatabase.h"
#import "CityDBData.h"

@interface CityTableViewController : UITableViewController

// Received state from StateTableView
@property (strong, nonatomic) NSString* theState;

// Array of all citites in the state
@property (strong, nonatomic) NSArray* cities;


@end
