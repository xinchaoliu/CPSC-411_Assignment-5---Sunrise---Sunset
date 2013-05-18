//
//  MainTableViewController.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: There are two way to navigate to this view: using GPS or
//                    select city from the list. This view shows both the
//                    sunrise & sunset time, in user's timezone time or in local
//                    time. Also the user can see their own current time & date.
//                    When using GPS, the location data will keep changing, and
//                    show the current place and sun time.

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

@synthesize isUsingSelectedCity;
@synthesize locationManager;
@synthesize currentLocation;
@synthesize geocoder;
@synthesize placemark;
@synthesize calcSun;
@synthesize sunTime;
@synthesize sunrise;
@synthesize sunset;
@synthesize theCity;
@synthesize cityText;
@synthesize timeString;
@synthesize dateString;
@synthesize timeZone;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    calcSun = [[SunTime alloc]init];
    cityText = @"Location updating...";
    // Check if using location service or using manually selected location
    if (isUsingSelectedCity)
    {
        // Update sun time info
        sunTime = [calcSun sunTimeAtLatitude:theCity.latitude
                                andLongitude:theCity.longitude];
        // Convert result to NSString
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        sunrise = [dateFormatter stringFromDate:[sunTime objectAtIndex:0]];
        sunset = [dateFormatter stringFromDate:[sunTime objectAtIndex:1]];
        cityText =
        [NSString stringWithFormat:@"%@, %@",theCity.name,theCity.state];
    } else {
        // Get location information from GPS
        if ([CLLocationManager locationServicesEnabled]) {
            locationManager = [[CLLocationManager alloc]init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.distanceFilter = 1000.0f;
            [locationManager startUpdatingLocation];
        }
        geocoder = [[CLGeocoder alloc]init];
    }
    
    // Set current time
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(myTimer:)
                                   userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [locationManager stopUpdatingLocation];
}

// GPS Fail Alert
- (void)locationManager:(CLLocationManager*)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"GPSdidFailWithError: %@",error);
    UIAlertView* errorAlert =
    [[UIAlertView alloc]initWithTitle:@"Error"
                              message:@"Faild to Get Your Location"
                             delegate:nil
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil];
    [errorAlert show];
}

// Keep current location info
- (void)locationManager:(CLLocationManager*)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@",newLocation);
    currentLocation = newLocation;
    
    // Add updating location to refresh placemark
    [locationManager startUpdatingLocation];
    
    // Update sun time info  
    NSString* latitude =
    [NSString stringWithFormat:@"%.8f",currentLocation.coordinate.latitude];
    NSString* longitude =
    [NSString stringWithFormat:@"%.8f",currentLocation.coordinate.longitude];
    sunTime = [calcSun sunTimeAtLatitude:latitude andLongitude:longitude];
    // Convert result to NSString
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    sunrise = [dateFormatter stringFromDate:[sunTime objectAtIndex:0]];
    sunset = [dateFormatter stringFromDate:[sunTime objectAtIndex:1]];
    
    // Get the place info
    
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         placemark = [placemarks objectAtIndex:0];
         cityText = [NSString stringWithFormat:@"%@, %@",placemark.locality,
                 placemark.administrativeArea];
     }];
    
    // Reload the view
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"timeCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                     forIndexPath:indexPath];
    
    // Configure the cell...
    
    // sunrise time
    self.cell.sunriseLabel.text =
        [NSString stringWithFormat:@"%@ %@",sunrise,timeZone];
    
    // Convert local time with timezone
    NSDateFormatter* localFormatter = [[NSDateFormatter alloc]init];
    [localFormatter setTimeZone:
     [NSTimeZone timeZoneWithName:[self fixedTimeZone:theCity.time_zone]]];
    [localFormatter setDateFormat:@"HH:mm:ss zzz"];
    self.cell.sunriseLocalLabel.text =
        [localFormatter stringFromDate:[sunTime objectAtIndex:0]];
    
    
    // sunset time
    self.cell.sunsetLabel.text =
    [NSString stringWithFormat:@"%@ %@",sunset,timeZone];
    
    // Convert local time with timezone
    self.cell.sunsetLocalLabel.text =
    [localFormatter stringFromDate:[sunTime objectAtIndex:1]];
    

    self.cell.cityLabel.text = cityText;

    return self.cell;
}

- (void) myTimer:(NSTimer*)timer
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    // set current date
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [NSDate date];
    [[NSDate date]timeIntervalSince1970];
    dateString = [dateFormatter stringFromDate:date];    
    self.cell.dateLabel.text = dateString;
    
    // set current time
    [dateFormatter setDateFormat:@"HH:mm:ss zzz"];
    timeString = [dateFormatter stringFromDate:date];    
    self.cell.timeLabel.text = timeString;
    
    // get timezone
    [dateFormatter setDateFormat:@"zzz"];
    timeZone = [dateFormatter stringFromDate:date];
    
    // Reload the view
    [self.tableView reloadData];
}

// standardise the timezone
- (NSString*) fixedTimeZone:(NSString*)theTimeZone
{
    NSString* fixedTimeZone;
    if ([theTimeZone isEqualToString:@"Mountain"]) {
        fixedTimeZone = @"America/Denver";
    } else if ([theTimeZone isEqualToString:@"Arizona"]) {
        fixedTimeZone = @"America/Phoenix";
    } else if ([theTimeZone isEqualToString:@"Alaska"]) {
        fixedTimeZone = @"America/Halifax";
    } else if ([theTimeZone isEqualToString:@"America/Indianapolis"]) {
        fixedTimeZone = @"America/New_York";
    } else if ([theTimeZone isEqualToString:@"America/Puerto_Rico"]) {
        fixedTimeZone = @"America/Halifax";
    } else if ([theTimeZone isEqualToString:@"America/Virgin"]) {
        fixedTimeZone = @"America/Halifax";
    } else if ([theTimeZone isEqualToString:@"Central"]) {
        fixedTimeZone = @"America/Chicago";
    } else if ([theTimeZone isEqualToString:@"Eastern"]) {
        fixedTimeZone = @"America/New_York";
    } else if ([theTimeZone isEqualToString:@"Hawaii"]) {
        fixedTimeZone = @"Pacific/Honolulu";
    } else if ([theTimeZone isEqualToString:@"Pacific/Guam"]) {
        fixedTimeZone = @"Pacific/Guam";
    } else if ([theTimeZone isEqualToString:@"Pacific/Saipan"]) {
        fixedTimeZone = @"Pacific/Saipan";
    } else if ([theTimeZone isEqualToString:@"Pacific/Samoa"]) {
        fixedTimeZone = @"Pacific/Niue";
    }
    return fixedTimeZone;
}

@end
