//
//  ViewController.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: The entry view, show two button for two different way to
//                    check the sun time. The state list will be generated when
//                    this view did load, to reduce the lag.

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize states;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    states = [[CityDatabase db] selectStates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Use segue to send the selected state
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"stateSegue"])
    {
        StateTableViewController* vc = segue.destinationViewController;
        vc.states = states;
    }
}

@end
