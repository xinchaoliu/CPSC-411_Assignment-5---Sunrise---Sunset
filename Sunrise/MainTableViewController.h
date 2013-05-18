//
//  MainTableViewController.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: The header of the detail view, all the sunrise time shown
//                    in this view, as well as the current time.

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SunTime.h"
#import "timeCell.h"
#import "CityDBData.h"

@interface MainTableViewController : UITableViewController <CLLocationManagerDelegate>

// timeCell Class
@property (strong, nonatomic) timeCell* cell;

// Used for GPS data
@property BOOL isUsingSelectedCity;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) CLGeocoder* geocoder;
@property (strong, nonatomic) CLPlacemark* placemark;

// Use libnova to calculate the sunrise & sunset time
@property (strong, nonatomic) SunTime* calcSun;
@property (strong, nonatomic) NSArray* sunTime;
// string for sun time
@property (strong, nonatomic) NSString* sunrise;
@property (strong, nonatomic) NSString* sunset;

// The city info get by manually select
@property (strong, nonatomic) CityDBData* theCity;

// city label text
@property (strong, nonatomic) NSString* cityText;

// Keep the clock running
- (void) myTimer:(NSTimer *)timer;

// CurrentTimeLabel text
@property (strong, nonatomic) NSString* timeString;
@property (strong, nonatomic) NSString* dateString;
@property (strong, nonatomic) NSString* timeZone;


// fix the timeZone text in database to standard text
- (NSString*) fixedTimeZone:(NSString*)timeZone;

@end
