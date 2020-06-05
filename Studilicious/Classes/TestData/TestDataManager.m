//
//  TestDataManager.m
//  TamiUI
//
//  Created by Admin on 2016-06-25.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "TestDataManager.h"

@implementation TestDataManager

+ (instancetype)sharedInstance {
    static TestDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//In most cases, server calls will be asynchronus with a mix of background queue for data and main queue for ui update
- (void)getFoodCategories:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FoodCategories" ofType:@"json"];
        if (filePath) {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, data, nil);
            });
        }
    });
}

- (void)getRestaurants:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Restaurants" ofType:@"json"];
        if (filePath) {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, data, nil);
            });
        }
    });
}

@end
