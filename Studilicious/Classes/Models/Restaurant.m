//
//  Restaurants.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-14.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "Restaurant.h"
#import "CuisineType.h"

@implementation Restaurant

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cuisineType" : [CuisineType class]};
}

@end
