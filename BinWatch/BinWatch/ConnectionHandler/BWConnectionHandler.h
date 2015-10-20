//
//  BWConnectionHandler.h
//  BinWatch
//
//  Created by Supritha Nagesha on 05/09/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWConnectionHandler : NSObject

+ (instancetype)sharedInstance;

- (void)getBinsWithCompletionHandler:(void(^)(NSArray *, NSError *))completionBlock;
- (void)getBinsAtPlace:(NSString*)place WithCompletionHandler:(void(^)(NSArray *, NSError *))completionBlock;
- (void)getBinData:(NSString *)binID from:(long)utcFrom to:(long)utcTo WithCompletionHandler:(void(^)(NSArray *, NSError *))completionBlock;

@end
