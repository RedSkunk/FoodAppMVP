//
//  FoodCategoriesViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-13.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "FoodCategoriesViewController.h"
#import "FoodCategoriesCell.h"

#import "FoodCategory.h"

#import "TestDataManager.h"
#import "STLServerUtil.h"

@interface FoodCategoriesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *categories;

@end

@implementation FoodCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categories = [[NSArray alloc] init];
    [[TestDataManager sharedInstance] getFoodCategories:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (![STLServerUtil isError:error]) {
            self.categories = [NSArray yy_modelArrayWithClass:[FoodCategory class] json:responseObject];
        }
        [self.tableView reloadData];
    }];
    
    
    UINib *nib = [UINib nibWithNibName:@"FoodCategoriesCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FoodCategoriesCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickedMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodCategoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodCategoriesCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FoodCategoriesCell" owner:self options:nil] objectAtIndex:0];
    }
    FoodCategory *category = [self.categories objectAtIndex:indexPath.row];
    cell.category.text = category.categoryName;
    cell.categoryImage.image = [UIImage imageNamed:category.categoryImageUrl];
    
    return cell;
}


@end
