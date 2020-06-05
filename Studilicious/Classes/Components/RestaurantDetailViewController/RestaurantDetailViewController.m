//
//  RestaurantDetailViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-14.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "RestaurantMenuDetailViewController.h"
#import "RestaurantDetailCell.h"
#import "RestaurantMenuCell.h"
#import "RestaurantContactCell.h"

@interface RestaurantDetailViewController ()

@property (strong, nonatomic) NSMutableArray *tableCells;
@property (strong, nonatomic) NSString *selectedMenuType;

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableCells = [[NSMutableArray alloc] init];
    
    RestaurantDetailCell *detailCell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantDetailCell" owner:self options:nil] objectAtIndex:0];
    detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tableCells addObject:@{@"cell":detailCell, @"height":@186}];
    
    NSArray *menuOption = @[@"Entrée", @"Salad", @"Pasta", @"Pizza", @"Drinks", @"Desert"];
    for (NSString *option in menuOption) {
        RestaurantMenuCell *optionCell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantMenuCell" owner:self options:nil] objectAtIndex:0];
        optionCell.menuOption.text = option;
        [self.tableCells addObject:@{@"cell":optionCell, @"height":@44}];
    }
    RestaurantContactCell *contactCell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantContactCell" owner:self options:nil] objectAtIndex:0];
    [self setLocation:[[CLLocation alloc] initWithLatitude:43.647331 longitude:-79.379444] imageView:contactCell.locationImage];
    contactCell.address.text = @"181 Bay Street, Toronto, Ontario";
    contactCell.phoneNumber.text = @"647-557-8165";
    contactCell.email.text = @"None";
    contactCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tableCells addObject:@{@"cell":contactCell, @"height":@270}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setLocation:(CLLocation *)location imageView:(UIImageView *)imageView{
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = MKCoordinateRegionMakeWithDistance(location.coordinate, 700.0, 700.0);
    options.scale = [UIScreen mainScreen].scale;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    options.size = CGSizeMake(screenRect.size.width, 150);
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        imageView.image = snapshot.image;
    }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //self.selectedSlot = [_appointments objectAtIndex:indexPath.row];
    if (indexPath.row != 0 && indexPath.row != [self.tableCells count]-1) {
        RestaurantMenuCell *optionCell = [[self.tableCells objectAtIndex:indexPath.row] valueForKey:@"cell"];
        self.selectedMenuType = optionCell.menuOption.text;
        [self performSegueWithIdentifier:@"RestaurantMenuDetailSegue" sender:self];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"RestaurantMenuDetailSegue"]) {
        RestaurantMenuDetailViewController *vc = [segue destinationViewController];
        vc.selectedMenuType = self.selectedMenuType;
    }
}

@end
