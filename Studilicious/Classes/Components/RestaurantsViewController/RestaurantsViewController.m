//
//  RestaurantsViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-14.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "RestaurantsViewController.h"
#import "RestaurantsCell.h"
#import "GradientView.h"

#import "Restaurant.h"

#import "TestDataManager.h"
#import "STLServerUtil.h"
#import <sys/utsname.h>

@interface RestaurantsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) DOPDropDownMenu *dropdownMenu;

@property (strong, nonatomic) NSArray *restaurants;
@property (strong, nonatomic) NSMutableArray *searchCriterias;

@end

@implementation RestaurantsViewController


BOOL IsiPhoneX(void)
{
    static BOOL isiPhoneX = NO;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
#if TARGET_IPHONE_SIMULATOR
        NSString *model = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
#else
        
        struct utsname systemInfo;
        uname(&systemInfo);
        
        NSString *model = [NSString stringWithCString:systemInfo.machine
                                             encoding:NSUTF8StringEncoding];
#endif
        isiPhoneX = [model isEqualToString:@"iPhone10,3"] || [model isEqualToString:@"iPhone10,6"];
    });
    
    return isiPhoneX;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchCriterias = [[NSMutableArray alloc] init];
    [self.searchCriterias addObject:@[@"All Cuisine", @"Brunch", @"Comfort Food", @"Fusion", @"Bar and Grill", @"Burger", @"Italian", @"Mexican", @"Korean"]];
    [self.searchCriterias addObject:@[@"Anywhere", @"Within 100 km", @"Within 10 km", @"Within 1 km"]];
    [self.searchCriterias addObject:@[@"By Distance", @"By Rating", @"By Popularity", @"Newly Opened"]];
    
    DOPDropDownMenu *menu = NULL;
    if (IsiPhoneX()) {
        menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 93) andHeight:44];
    } else {
        menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 73) andHeight:44];
    }
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    self.dropdownMenu = menu;
    
    self.restaurants = [[NSArray alloc] init];
    [[TestDataManager sharedInstance] getRestaurants:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (![STLServerUtil isError:error]) {
            self.restaurants = [NSArray yy_modelArrayWithClass:[Restaurant class] json:responseObject];
        }
        [self.tableView reloadData];
    }];
    
    UINib *nib = [UINib nibWithNibName:@"RestaurantsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RestaurantsCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)getClosestDistance:(double)distance{
    double convertedValue = distance;
    int multiplyFactor = 0;
    
    NSArray *tokens = @[@"m",@"km"];
    
    while (convertedValue > 1000 && [tokens count]>multiplyFactor) {
        convertedValue /= 1000;
        multiplyFactor++;
    }
    return [NSString stringWithFormat:@"%4.1f %@",convertedValue, tokens[multiplyFactor]];
}

- (IBAction)clickedMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurants.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantsCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantsCell" owner:self options:nil] objectAtIndex:0];
    }
    if (!cell.gradientsApplied) {
        cell.gradientsApplied = YES;
        GradientView *gradientView = [[GradientView alloc] initWithFrame:cell.bounds];
        gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        gradientView.layer.colors = @[(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor]];
        gradientView.layer.startPoint = CGPointMake(0.5, 0.4);
        gradientView.alpha = 0.6;
        [cell.bannerImage insertSubview:gradientView atIndex:1];
    }
    Restaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    cell.restaurantName.text = restaurant.restaurantName;
    cell.cuisineType.text = [[restaurant.cuisineType valueForKey:@"type"] componentsJoinedByString:@", "];
    cell.distanceAway.text = [NSString stringWithFormat:@"%@ away",[self getClosestDistance:[restaurant.distanceAway doubleValue]]];
    cell.openStatus.text = restaurant.isOpen ? @"Open" : @"Closed";
    cell.bannerImage.image = [UIImage imageNamed:restaurant.bannerImageUrl];
    cell.logoImage.image = [UIImage imageNamed:restaurant.logoImageUrl];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //self.selectedSlot = [_appointments objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"RestaurantDetailSegue" sender:self];
}

#pragma mark - DOPDropDownMenu Delegate
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return [[self.searchCriterias objectAtIndex:column] count];
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    return [[self.searchCriterias objectAtIndex:indexPath.column] objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return self.searchCriterias.count;
}

@end
