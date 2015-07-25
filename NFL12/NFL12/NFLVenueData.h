//
//  NFLVenues.h
//  NFL12
//
//  Created by Kritsakorn on 7/24/15.
//  Copyright (c) 2015 Kritsakorn. All rights reserved.
//
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface NFLVenueData : NSObject
@property (readwrite,nonatomic) int zip;
@property (strong,nonatomic) NSString *phoneNumber;
@property (strong,nonatomic) NSString *ticketLink;
@property (strong,nonatomic) NSString *state;
@property (readwrite,nonatomic) int pcode;
@property (strong,nonatomic) NSString *city;
@property (readwrite,nonatomic) int venue_id;
@property (strong,nonatomic) NSString *tollfreePhone;
@property (strong,nonatomic) NSArray *schedule;
@property (strong,nonatomic) NSString *adress;
@property (strong,nonatomic) NSString *imageURL;
@property (strong,nonatomic) NSString *descriptions;
@property (strong,nonatomic) NSString *name;
@property (nonatomic,strong) UIImage *venueImage;
@property (strong,nonatomic) CLLocation* location;
- (void)loadWithDictionary:(NSDictionary *)dict;
- (NSString*)getFullAddress;
+ (NSString*)requiredDateFormat:(NSDictionary *)date;
@end
