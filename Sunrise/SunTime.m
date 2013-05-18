//
//  SunTime.m
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
//                    This is the driver. Send coordinte info to libnova, the
//                    sunrise & sunset time will be returned.

#import "SunTime.h"

@implementation SunTime

@synthesize sunTime;

- (NSArray*)sunTimeAtLatitude:(NSString*)theLatitude
                 andLongitude:(NSString*)theLongitude
{
    struct ln_lnlat_posn observer;
    struct ln_rst_time rst;
    struct ln_zonedate rise, set;
    
    // Observers location, used to calc rst
    observer.lat = [theLatitude doubleValue];
    observer.lng = [theLongitude doubleValue];
    
    // Get Julian day from local time
    double jd = ln_get_julian_from_sys();
    
    // Calculate rise&set time
    if (ln_get_solar_rst(jd, &observer, &rst) == 1) {
        return sunTime;
    } else {
        ln_get_local_date(rst.rise,&rise);
        ln_get_local_date(rst.set,&set);
    }
    
    // Use NSDateFormatter format the two time, and return in a NSArray
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSDate* sunrise = [dateFormatter dateFromString:
                       [NSString stringWithFormat:
                        @"%i:%i:%i",rise.hours,rise.minutes,(int)rise.seconds]];
    NSDate* sunset = [dateFormatter dateFromString:
                      [NSString stringWithFormat:
                       @"%i:%i:%i",set.hours,set.minutes,(int)set.seconds]];
    
    // Store two time into array
    sunTime = [NSArray arrayWithObjects:sunrise, sunset, nil];
    
    return sunTime;
}

@end
