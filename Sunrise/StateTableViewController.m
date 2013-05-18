//
//  StateTableViewController.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: Use the state list from entry view to show a tableview
//                    for user to choose a state. Then, pass the selected state
//                    to the next cityTableView.

#import "StateTableViewController.h"

@interface StateTableViewController ()

@end

@implementation StateTableViewController

@synthesize states;

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    states = nil;
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
    return [states count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stateCell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                    forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }    
    cell.textLabel.text = [states objectAtIndex:indexPath.row];
    
    return cell;
}

// Use segue to send the selected state
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        NSIndexPath* index = [self.tableView indexPathForSelectedRow];
        CityTableViewController* vc = segue.destinationViewController;
        vc.theState = [states  objectAtIndex:index.row];
}

@end
