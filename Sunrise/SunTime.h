//
//  SunTime.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/8/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: This project use libnova library to compute the sun time.
//                    This is the driver.

#import <Foundation/Foundation.h>
#import "julian_day.h"
#import "solar.h"
#import "rise_set.h"
#import "transform.h"

@interface SunTime : NSObject

@property (strong, nonatomic) NSArray* sunTime;

// Return sunrise & sunset time in NSDate 
- (NSArray*)sunTimeAtLatitude:(NSString*)theLatitude
                 andLongitude:(NSString*)theLongitude;


@end
