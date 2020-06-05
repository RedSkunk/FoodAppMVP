//
//  LeftMenuViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-07.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MenuOptionCell.h"

#import "StoryboardList.h"

@interface LeftMenuViewController ()

@property (weak, nonatomic) IBOutlet UIView *topOffset;

@property NSArray *optionList;
@property NSArray *optionImage;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.optionList = @[@"HOME", @"RESTAURANT", @"EVENT", @"ENTERTAINMENT", @"SETTING"];
    self.optionImage = @[@"Nav Home", @"Nav Restaurant", @"Nav Event", @"Nav Entertainment", @"Nav Setting"];
    
    CGRect offsetFrame = self.topOffset.frame;
    offsetFrame.size.height = self.view.frame.size.height/10;
    [self.topOffset setFrame:offsetFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.optionList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuOptionCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuOptionCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.optionImage.image = [UIImage imageNamed:[self.optionImage objectAtIndex:indexPath.row]];
    cell.optionTitle.text = [self.optionList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.frostedViewController hideMenuViewController];
    
    //based on specification, some will push, while others will replace
    if (indexPath.row == 0) {
        ((UINavigationController *)self.frostedViewController.contentViewController).viewControllers = @[[[StoryboardList mainStoryboard] instantiateViewControllerWithIdentifier:@"FoodCategoriesViewController"]];
    } else if (indexPath.row == 1) {
        ((UINavigationController *)self.frostedViewController.contentViewController).viewControllers = @[[[StoryboardList mainStoryboard] instantiateViewControllerWithIdentifier:@"RestaurantsViewController"]];
    }
}

@end
