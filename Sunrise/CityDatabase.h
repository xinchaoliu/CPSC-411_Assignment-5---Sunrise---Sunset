//
//  CityDatabase.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

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
