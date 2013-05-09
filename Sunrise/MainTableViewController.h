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

@interface MainTableViewController : UITableViewController <CLLocationManagerDelegate>

// Used for GPS data
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) CLGeocoder* geocoder;
@property (strong, nonatomic) CLPlacemark* placemark;

// Use libnova to calculate the sunrise & sunset time
@property (strong, nonatomic) SunTime* calcSun;

// string for sun time
@property (strong, nonatomic) NSString* sunrise;
@property (strong, nonatomic) NSString* sunset;

// city label text
@property (strong, nonatomic) NSString* city;

@end
