//
//  CityTableViewController.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import "CityTableViewController.h"

@interface CityTableViewController ()

@end

@implementation CityTableViewController

@synthesize theState;
@synthesize cities;

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

    // Get cities from db
    cities = [[CityDatabase db]selectCitiesInState:theState];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    cities = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    // Get city name from the cities array
    CityDBData* city = [cities objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

// Use segue to send the selected state
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* index = [self.tableView indexPathForSelectedRow];
    MainTableViewController* vc = segue.destinationViewController;
    vc.theCity = [cities objectAtIndex:index.row];
    vc.isUsingSelectedCity = YES;
}

@end
