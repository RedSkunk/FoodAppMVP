//
//  RestaurantMenuDetailViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-15.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "RestaurantMenuDetailViewController.h"
#import "RestaurantMenuItemCell.h"

@interface RestaurantMenuDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *menuType;

@end

@implementation RestaurantMenuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuType.text = self.selectedMenuType;
    
    UINib *nib = [UINib nibWithNibName:@"RestaurantMenuItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RestaurantMenuItemCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantMenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantMenuItemCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantMenuItemCell" owner:self options:nil] objectAtIndex:0];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"RestaurantMenuItemSegue" sender:self];
}

@end
