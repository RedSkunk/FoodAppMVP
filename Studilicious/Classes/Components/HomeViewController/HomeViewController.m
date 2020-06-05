//
//  HomeViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-07.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *navButtonGroup;
@property (weak, nonatomic) IBOutlet UIView *searchView;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showButtonGroup:(NSArray *)buttonGroup exclude:(NSArray *)exclusions {
    for (UIButton *button in buttonGroup) {
        if (![exclusions containsObject:button]) {
            button.hidden = NO;
        }
    }
}

- (void)hideButtonGroup:(NSArray *)buttonGroup exclude:(NSArray *)exclusions {
    for (UIButton *button in buttonGroup) {
        if (![exclusions containsObject:button]) {
            button.hidden = YES;
        }
    }
}

- (IBAction)clickedSearch:(UIButton *)sender {
    [self hideButtonGroup:self.navButtonGroup exclude:@[sender]];
}

- (IBAction)clickedMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

@end
