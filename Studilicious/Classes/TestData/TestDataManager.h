//
//  TestDataManager.h
//  TamiUI
//
//  Created by Admin on 2016-06-25.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestDataManager : NSObject

+ (instancetype)sharedInstance;

- (void)getFoodCategories:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
- (void)getRestaurants:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;

@end
