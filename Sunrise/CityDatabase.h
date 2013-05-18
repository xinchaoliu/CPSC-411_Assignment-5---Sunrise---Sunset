//
//  CityDatabase.h
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
//                    project.

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "CityDBData.h"

@interface CityDatabase : NSObject
{
    // Connection to database
    sqlite3* _databaseConnection;
}

+ (CityDatabase*) db;

// Select state from db
- (NSArray*) selectStates;

// Select city from db where state = theState
- (NSArray*) selectCitiesInState:(NSString*)theState;

@end
