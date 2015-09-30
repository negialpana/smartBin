//
//  BWGeocoder.h
//  BinWatch
//
//  Created by Seema Kadavan on 9/22/15.
//  Copyright (c) 2015 AirWatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@protocol BWGeocoderDelegate <NSObject>

- (void)geocoderFailedWithError:(NSError *)error;

- (void)geocoderDidReceiveResponse:(NSString *)points;

@end

@interface BWGeocoder : NSObject

@property (nonatomic, assign) id<BWGeocoderDelegate> delegate;

+ (BWGeocoder *)sharedInstance;
- (void) reverseGeocode:(CLLocationCoordinate2D)location;
- (void) reverseGeocoder:(CLLocationCoordinate2D)location;

@end
