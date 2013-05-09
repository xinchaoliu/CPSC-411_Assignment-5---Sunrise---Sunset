//
//  MainTableViewController.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SunTime.h"
#import "timeCell.h"
#import "CityDBData.h"

@interface MainTableViewController : UITableViewController <CLLocationManagerDelegate>

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

@end
