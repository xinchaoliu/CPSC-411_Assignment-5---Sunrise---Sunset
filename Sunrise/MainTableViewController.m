//
//  MainTableViewController.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

@synthesize locationManager;
@synthesize currentLocation;
@synthesize geocoder;
@synthesize placemark;
@synthesize calcSun;
@synthesize sunrise;
@synthesize sunset;
@synthesize city;

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

    // Get location information from GPS
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 1000.0f;
        [locationManager startUpdatingLocation];
    }
    
    geocoder = [[CLGeocoder alloc]init];
    
    calcSun = [[SunTime alloc]init];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [locationManager stopUpdatingLocation];
}

// GPS Fail Alert
- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError *)error
{
    NSLog(@"GPSdidFailWithError: %@",error);
    UIAlertView* errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Faild to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    NSArray* sunTime;
    sunTime = [calcSun sunTimeAtLatitude:[NSString stringWithFormat:@"%.8f",currentLocation.coordinate.latitude] andLongitude:[NSString stringWithFormat:@"%.8f",currentLocation.coordinate.longitude]];
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
         city = [NSString stringWithFormat:@"%@, %@",placemark.locality,
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"timeCell";
    timeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.sunriseLabel.text = sunrise;
    cell.sunsetLabel.text = sunset;
    cell.cityLabel.text = city;
    
    return cell;
}

@end
