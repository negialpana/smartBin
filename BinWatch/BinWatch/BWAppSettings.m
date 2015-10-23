//
//  BWAppSettings.m
//  BinWatch
//
//  Created by Seema Kadavan on 10/11/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import "BWAppSettings.h"
#import "AppDelegate.h"

#define DEFAULT_RADIUS 5

@implementation BWAppSettings

NSString* const kSwitchedAppModeNotification    = @"SwitchedAppModeNotification";
NSString* const kExportSelectedNotification     = @"ExportSelectedNotification";
NSString* const kSettingsSelectedNotification   = @"SettingsSelectedNotification";

// UserDefaults
static NSString* const kCoverageRadius = @"Radius";
static NSString* const kSupportMailID = @"MailID";
static NSString* const kExportPDFOn = @"PDF";
static NSString* const kExportExcelOn = @"EXCEL";
static NSString* const kExportCSVOn = @"CSV";
static NSString* const kAppMode = @"AppMode";

static NSString* const kDefaultMailID = @"BinWatch.ReapBenefit@gmail.com";

+ (BWAppSettings *)sharedInstance
{
    static dispatch_once_t onceToken;
    static BWAppSettings *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[BWAppSettings alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerNotifications];
        [self saveUserDefaults];
    }
    return self;
}

-(void)registerNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(switchedAppMode) name:kSwitchedAppModeNotification object:nil];
    [center addObserver:self selector:@selector(exportSelected) name:kExportSelectedNotification object:nil];
    [center addObserver:self selector:@selector(settingsSelected) name:kSettingsSelectedNotification object:nil];
}

-(void)unregisterNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)saveUserDefaults
{
    // Saving default Data to user defaults
    NSString *mailID = [self getSupportMailID];
    if(!mailID)
    {
        // App launching for first time
        [self saveSupportMailID:kDefaultMailID];
        [self saveCoverageRadius:DEFAULT_RADIUS];
        [self saveExportCSV:YES];
        [self saveExportExcel:YES];
        [self saveExportPDF:YES];
        // TODO: This has to be changed
        [self saveAppMode:BWBBMPMode];
    }
 
}

-(void)switchedAppMode{
    BWAppMode appMode = [self getAppMode];
    switch (appMode) {
        case BWUserMode:
            [self saveAppMode:BWBBMPMode];
            [[AppDelegate appDel] switchToMainStoryBoard];
            break;
        case BWBBMPMode:
            [self saveAppMode:BWUserMode];
            [[AppDelegate appDel] switchToUserModeStoryBoard];
            break;
            
        default:
            [self saveAppMode:BWUserMode];
            [[AppDelegate appDel] switchToUserModeStoryBoard];
            break;
    }
}
-(void)switchedToBBMPMode{
    NSLog(@"switchedToBBMPMode notif");
    
}
-(void)exportSelected{
    NSLog(@"exportSelected notif");
    
}
-(void)settingsSelected{
    NSLog(@"settingsSelected notif");
    
}

#pragma mark - Settings getters and setters

-(void) saveAppMode:(BWAppMode)mode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithInt:mode] forKey:kAppMode];
}

-(BWAppMode) getAppMode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kAppMode] integerValue];
}

-(void) saveSupportMailID:(NSString *)mailID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:mailID forKey:kSupportMailID];
}

-(NSString *) getSupportMailID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:kSupportMailID];
}

-(void) saveCoverageRadius:(int)radius
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithInt:radius] forKey:kCoverageRadius];
}

-(int) getCoverageRadius
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kCoverageRadius] integerValue];
}

-(void) saveExportPDF:(bool)enable
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:enable] forKey:kExportPDFOn];
}

-(bool) getExportPDF
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kExportPDFOn] boolValue];
}

-(void) saveExportExcel:(bool)enable
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:enable] forKey:kExportExcelOn];
}

-(bool) getExportExcel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kExportExcelOn] boolValue];
}

-(void) saveExportCSV:(bool)enable
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:enable] forKey:kExportCSVOn];
}

-(bool) getExportCSV
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kExportCSVOn] boolValue];
}

@end
