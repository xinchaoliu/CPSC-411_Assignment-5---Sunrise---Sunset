//
//  CityDBData.m
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import "CityDBData.h"

@implementation CityDBData

@synthesize name;
@synthesize state;
@synthesize latitude;
@synthesize longitude;
@synthesize time_zone;

- (id) initWithName:(NSString*)theName
           andState:(NSString*)theState
        andLatitude:(NSString*)theLatitude
       andLongitude:(NSString*)theLongitude
        andTimezone:(NSString*)theTimezone
{
    self = [super init];
    if (self) {
        name = theName;
        state = theState;
        latitude = theLatitude;
        longitude = theLongitude;
        time_zone = theTimezone;
    }
    return self;
}

@end
