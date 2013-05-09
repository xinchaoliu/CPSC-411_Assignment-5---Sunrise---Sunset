//
//  CityDBData.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDBData : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* latitude;
@property (strong, nonatomic) NSString* longitude;
@property (strong, nonatomic) NSString* time_zone;

- (id) initWithName:(NSString*)theName
           andState:(NSString*)theState
        andLatitude:(NSString*)theLatitude
       andLongitude:(NSString*)theLongitude
        andTimezone:(NSString*)theTimezone;

@end
