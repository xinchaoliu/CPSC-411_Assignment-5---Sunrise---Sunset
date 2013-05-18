//
//  CityTableViewController.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: The cityTableView allow user to choose a city from the
//                    state they choosen. There's a search bar at the top to
//                    help user easily find the city they want. When user
//                    selected the city, the city's infomation shall be passed
//                    to the mainTableView to generate the data.

#import "CityTableViewController.h"

@interface CityTableViewController ()

@end

@implementation CityTableViewController

@synthesize theState;
@synthesize cities;
@synthesize cityNames;
@synthesize searchResults;

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
    cityNames = [[NSMutableArray alloc]init];
    for (CityDBData* theCity in cities) {
        [cityNames addObject:theCity.name];
    }
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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // show searchresults or all cities
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    } else {
    return [cityNames count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cityCell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
        // Get city name from the cities array
        cell.textLabel.text = [cityNames objectAtIndex:indexPath.row];
    }
    
    return cell;
}

// Use segue to send the selected state
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSelectSegue"]) {
        MainTableViewController* vc = segue.destinationViewController;
        NSIndexPath* indexPath = nil;
        
        // select from search result
        if ([self.searchDisplayController isActive]) {
            indexPath = [self.searchDisplayController.searchResultsTableView
                         indexPathForSelectedRow];
            int inx = 0;
            for (int i = 0; i < [cities count]; i++)
            {
                if ([[[cities objectAtIndex:i] name] isEqualToString:[searchResults objectAtIndex:indexPath.row]])
                {
                    inx = i;
                    break;
                }
            }
            vc.theCity = [cities objectAtIndex:inx];
            vc.isUsingSelectedCity = YES;
            
        } else {
            // select from tableview
            indexPath = [self.tableView indexPathForSelectedRow];
            vc.theCity = [cities objectAtIndex:indexPath.row];
            vc.isUsingSelectedCity = YES;
        }
    }
}

// Add search function to cityTableView

// Filter for searching
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate* resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF CONTAINS[cd] %@",
                                    searchText];
    searchResults = [cityNames filteredArrayUsingPredicate:resultPredicate];
}

// searchDisplayController
- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar
                                       scopeButtonTitles]
                       objectAtIndex:[self.searchDisplayController.searchBar
                                      selectedScopeButtonIndex]]];
    return YES;
}

// Selected search result
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier:@"showSelectSegue" sender:self];
    }
}


@end
