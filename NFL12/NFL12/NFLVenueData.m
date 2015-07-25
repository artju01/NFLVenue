//
//  NFLVenues.m
//  NFL12
//
//  Created by Kritsakorn on 7/24/15.
//  Copyright (c) 2015 Kritsakorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLVenueData.h"



@implementation NFLVenueData
- (void)loadWithDictionary:(NSDictionary *)dict
{
    self.zip= [[dict objectForKey:@"zip"] intValue];
    self.phoneNumber = [dict objectForKey:@"phone"];
    self.ticketLink = [dict objectForKey:@"ticket_link"];
    self.state = [dict objectForKey:@"state"];
    self.pcode = [[dict objectForKey:@"pcode"] intValue];
    self.city = [dict objectForKey:@"city"];
    self.venue_id = [[dict objectForKey:@"id"] intValue];
    self.tollfreePhone = [dict objectForKey:@"tollfreephone"];
    self.schedule = [dict objectForKey:@"schedule"];
    self.adress = [dict objectForKey:@"address"];
    self.imageURL = [dict objectForKey:@"image_url"];
    self.descriptions = [dict objectForKey:@"description"];
    self.name = [dict objectForKey:@"name"];
    CLLocationDegrees latitude = [[dict objectForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitude = [[dict objectForKey:@"longitude"] doubleValue];
    self.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
}

- (NSString*)getFullAddress
{
    return [NSString stringWithFormat:@"%@, %@, %@ %d",self.adress, self.city, self.state, self.zip];
}

#pragma mark - Return the format the is required by app

+ (NSString*)requiredDateFormat:(NSDictionary *)date
{
    NSString *text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [formatter setAMSymbol:@"am"];
    [formatter setPMSymbol:@"pm"];
    
    NSDate *startDate = [formatter dateFromString:date[@"start_date"]];
    NSDate *endDate = [formatter dateFromString:date[@"end_date"]];
    
    //set to current timezone
    [formatter setDateFormat:@"cccc L/d hh:mma"];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    
    if ([NFLVenueData isSameDay:startDate second:endDate]) {
        NSString *startString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:startDate]];
        [formatter setDateFormat:@"hh:mma"];
        NSString *endString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
        text = [NSString stringWithFormat:@"%@ to %@\n", startString, endString];
    }
    else {
        NSString *startString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:startDate]];
        NSString *endString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
        text = [NSString stringWithFormat:@"%@ to %@\n", startString, endString];
    }
    return text;
}

#pragma mark -Compare day, time, year

+ (BOOL) isSameDay:(NSDate *) startDate second:(NSDate *)endDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsForFirstDate = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:startDate];
    NSDateComponents *componentsForSecondDate = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:endDate];
    return ([componentsForFirstDate day] == [componentsForSecondDate day]) && ([componentsForFirstDate month] == [componentsForSecondDate month]) && ([componentsForFirstDate year] == [componentsForSecondDate year]);
}
@end

