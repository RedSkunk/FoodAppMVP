//
//  RestaurantLocationCell.h
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-15.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *email;

@end
