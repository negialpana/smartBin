//
//  BWAppSettings.h
//  BinWatch
//
//  Created by Seema Kadavan on 10/11/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BWAppMode) {
    BWUserMode,
    BWBBMPMode,
};

@interface BWAppSettings : NSObject

@property (nonatomic, assign) BWAppMode appMode;
@property (nonatomic, assign) NSInteger defaultRadius;


extern NSString* const kSwitchedAppModeNotification;
extern NSString* const kExportSelectedNotification;
extern NSString* const kSettingsSelectedNotification;

+ (BWAppSettings *)sharedInstance;
@end
