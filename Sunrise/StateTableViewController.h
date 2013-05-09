//
//  StateTableViewController.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityDatabase.h"
#import "CityDBData.h"
#import "CityTableViewController.h"

@interface StateTableViewController : UITableViewController

// Array of all states
@property (strong, nonatomic) NSArray* states;

@end
