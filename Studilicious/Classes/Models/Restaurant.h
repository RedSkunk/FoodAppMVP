//
//  Restaurants.h
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-14.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "YYModel.h"

@interface Restaurant : NSObject

@property NSString *restaurantName;
@property NSArray *cuisineType; //NSArray<CuisineType>
@property NSString *bannerImageUrl;
@property NSString *logoImageUrl;
@property NSNumber *distanceAway;
@property BOOL isOpen;

@end
