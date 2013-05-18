//
//  CityDatabase.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//
//  Email: leo_liu@csu.fullerton.edu
//
//  Due: 23:59, May.17, 2013
//
//  File Description: The database control class. Two SQL queries used in the
//                    project. When query the database using the selected state
//                    all information of the cities will be returned in an array

#import "CityDatabase.h"

@implementation CityDatabase

static CityDatabase* _databaseObj;

+ (CityDatabase*) db
{
    if (_databaseObj == nil) {
        _databaseObj = [[CityDatabase alloc] init];
    }
    return _databaseObj;
}

- (id) init
{
    self = [super init];
    if (self) {
        NSString* databasePath =
        [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"sqlite"];
        if (sqlite3_open([databasePath UTF8String], &_databaseConnection)
            != SQLITE_OK) {
            NSLog(@"Failed to open database.");
        }
    }
    return self;
}

- (void) dealloc
{
    sqlite3_close(_databaseConnection);
}

// Select state from db
- (NSArray*) selectStates
{
    NSMutableArray* states = [[NSMutableArray alloc] init];
    
    // Get data from db with SQL query
    NSString* query = @"SELECT DISTINCT state FROM cities ORDER BY state";
    sqlite3_stmt *statement;
    const unsigned char* text;
    NSString* state;
    if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String],
                           [query length], &statement, nil) == SQLITE_OK) {
        // Acquire data
        while (sqlite3_step(statement) == SQLITE_ROW) {
            text = sqlite3_column_text(statement, 0);
            if (text)
                state = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                state = nil;
            
            // Store all result into array
            [states addObject: state];
        }        
        sqlite3_finalize(statement);
    }
    return states;
}

// Select city from db where state = theState
- (NSArray*) selectCitiesInState:(NSString*)theState
{
    NSMutableArray* cities = [[NSMutableArray alloc] init];
    NSString* name;
    NSString* state;
    NSString* latitude;
    NSString* longitude;
    NSString* time_zone;   
    
    // Prepare the query
    NSString* query = [NSString stringWithFormat:
     @"SELECT * FROM cities WHERE state = '%@'",theState];
    
    sqlite3_stmt *statement;
    const unsigned char* text;
    if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String],
                           [query length], &statement, nil) == SQLITE_OK) {
        // Grab data
        while (sqlite3_step(statement) == SQLITE_ROW) {
            text = sqlite3_column_text(statement, 0);
            if (text)
                name = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                name = nil;
            text = sqlite3_column_text(statement, 1);
            if (text)
                state = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                state = nil;
            text = sqlite3_column_text(statement, 2);
            if (text)
                latitude = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                latitude = nil;
            text = sqlite3_column_text(statement, 3);
            if (text)
                longitude = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                longitude = nil;
            text = sqlite3_column_text(statement, 4);
            if (text)
                time_zone = [NSString stringWithCString:(const char*)text
                                           encoding:NSUTF8StringEncoding];
            else
                time_zone = nil;
            
            // Initialize City data
            CityDBData* theCity = [[CityDBData alloc] initWithName:name
                                                          andState:state
                                                       andLatitude:latitude
                                                      andLongitude:longitude
                                                       andTimezone:time_zone];
            [cities addObject: theCity];
        }
        sqlite3_finalize(statement);
    }
    return cities;
}

@end
