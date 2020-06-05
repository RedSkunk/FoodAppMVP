//
//  RestaurantMenuItemViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-15.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "RestaurantMenuItemViewController.h"
#import "RestaurantMenuItemInfoCell.h"
#import "RestaurantMenuItemOptionCell.h"
#import "RestaurantMenuItemSectionCell.h"

#import "GradientView.h"

@interface RestaurantMenuItemViewController ()

@property (strong, nonatomic) NSMutableArray *tableCells;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;

@end

@implementation RestaurantMenuItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GradientView *gradientView = [[GradientView alloc] initWithFrame:self.bannerImage.bounds];
    gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gradientView.layer.colors = @[(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor]];
    gradientView.layer.startPoint = CGPointMake(0.5, 0.4);
    gradientView.alpha = 0.3;
    [self.bannerImage insertSubview:gradientView atIndex:1];
    
    self.tableCells = [[NSMutableArray alloc] init];
    
    RestaurantMenuItemInfoCell *infoCell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantMenuItemInfoCell" owner:self options:nil] objectAtIndex:0];
    infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tableCells addObject:@{@"cell":infoCell, @"height":@80}];
    
    NSArray *menuOption = @[@{@"optionName":@"Regular", @"price":@0}, @{@"optionName":@"Large", @"price":@1.29}];
    for (NSString *option in menuOption) {
        RestaurantMenuItemOptionCell *optionCell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantMenuItemOptionCell" owner:self options:nil] objectAtIndex:0];
        optionCell.itemOption.text = [option valueForKey:@"optionName"];
        double price = [[option valueForKey:@"price"] doubleValue];
        optionCell.itemPrice.text = price == 0 ? @"" : [NSString stringWithFormat:@"$%@",@(price).stringValue];
        [self.tableCells addObject:@{@"cell":optionCell, @"height":@56}];
    }
    
    RestaurantMenuItemSectionCell *sectionCell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantMenuItemSectionCell" owner:self options:nil] objectAtIndex:0];
    sectionCell.sectionTitle.text = @"Side Option - Choose one";
    sectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tableCells addObject:@{@"cell":sectionCell, @"height":@35}];
    
    NSArray *menuOption2 = @[@{@"optionName":@"Salad", @"price":@0}, @{@"optionName":@"French Fries", @"price":@0}];
    for (NSString *option in menuOption2) {
        RestaurantMenuItemOptionCell *optionCell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantMenuItemOptionCell" owner:self options:nil] objectAtIndex:0];
        optionCell.itemOption.text = [option valueForKey:@"optionName"];
        double price = [[option valueForKey:@"price"] doubleValue];
        optionCell.itemPrice.text = price == 0 ? @"" : [NSString stringWithFormat:@"$%@",@(price).stringValue];
        [self.tableCells addObject:@{@"cell":optionCell, @"height":@56}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)clickedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableCells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[[self.tableCells objectAtIndex:indexPath.row] valueForKey:@"height"] doubleValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[self.tableCells objectAtIndex:indexPath.row] valueForKey:@"cell"];
    
    return cell;
}



@end
