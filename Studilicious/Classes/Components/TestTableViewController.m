//
//  TestTableViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-15.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"

@interface TestTableViewController ()

@property (strong, nonatomic) NSMutableArray *tableCells;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableCells = [[NSMutableArray alloc] init];
    
    for (int count = 0; count < 2; count++) {
        TestTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.tableCells addObject:@{@"type":@"a", @"cell":cell, @"height":@44}];
    }
    
    for (int count = 0; count < 2; count++) {
        TestTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.tableCells addObject:@{@"type":@"b", @"cell":cell, @"height":@44}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    for (NSDictionary *cellInfo in self.tableCells) {
        if ([[cellInfo valueForKey:@"type"] isEqualToString:@"b"]) {
            TestTableViewCell *cell = [cellInfo valueForKey:@"cell"];
            cell.label.text = @"changed";
        }
    }
}


@end
