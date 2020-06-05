//
//  RestaurantsCell.h
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-14.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageViewAligned.h"

@interface RestaurantsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UIImageViewAligned *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *cuisineType;
@property (weak, nonatomic) IBOutlet UILabel *distanceAway;
@property (weak, nonatomic) IBOutlet UILabel *openStatus;
@property BOOL gradientsApplied;

@end
