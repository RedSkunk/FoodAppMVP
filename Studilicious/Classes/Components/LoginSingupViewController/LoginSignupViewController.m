//
//  LoginSignupViewController.m
//  Studilicious
//
//  Created by Jeffrey So on 2016-08-07.
//  Copyright © 2016 Jeffrey So. All rights reserved.
//

#import "LoginSignupViewController.h"
#import "UIColor+fromHex.h"

@interface LoginSignupViewController ()
@property (weak, nonatomic) IBOutlet UIView *introView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIScrollView *signupView;

@property (weak, nonatomic) IBOutlet UITextField *loginUsername;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;

@property (weak, nonatomic) IBOutlet UITextField *signupEmail;
@property (weak, nonatomic) IBOutlet UITextField *signupUsername;
@property (weak, nonatomic) IBOutlet UITextField *signupPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *signupPassword;
@property (weak, nonatomic) IBOutlet UITextField *signupConfirmPassword;

@property (weak, nonatomic) IBOutlet BLMultiColorLoader *multiColorLoader;

@end

@implementation LoginSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawPlaceholderWithColor:[UIColor colorWithHexString:@"#F9F9F9" alpha:1.0]];
    self.multiColorLoader.lineWidth = 2.0;
    self.multiColorLoader.colorArray = [NSArray arrayWithObjects:[UIColor whiteColor], nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawPlaceholderWithColor:(UIColor *)color {
    self.loginUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    self.loginPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.signupEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    self.signupUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    self.signupPhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.signupPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.signupConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
}

- (IBAction)clickedLogin:(id)sender {
    if ([self.loginUsername hasText] && [self.loginPassword hasText]) {
        
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.introView.alpha = 0;
                             self.loginView.alpha = 0;
                             self.signupView.alpha = 0;
                             self.introView.hidden = YES;
                             self.loginView.hidden = YES;
                             self.signupView.hidden = YES;
                         } completion:^(BOOL finished) {
                             self.multiColorLoader.hidden = NO;
                             [self.multiColorLoader startAnimation];
                             [self.multiColorLoader stopAnimationAfter:1.2];
                         }];
        [self performSelector:@selector(transitionToHomeView) withObject:nil afterDelay:1.3];
    }
}

- (void)transitionToHomeView {
    [self performSegueWithIdentifier:@"FoodCategoriesSegue" sender:self];
}

- (IBAction)clickedRegister:(id)sender {
    
}

- (IBAction)toggledLogin:(id)sender {
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.introView.hidden = YES;
                         self.loginView.hidden = NO;
                         self.signupView.hidden = YES;
                         self.introView.alpha = 0;
                         self.loginView.alpha = 1.0;
                         self.signupView.alpha = 0;
                     } completion:^(BOOL finished) {

                     }];
}

- (IBAction)toggledSignup:(id)sender {
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.introView.hidden = YES;
                         self.loginView.hidden = YES;
                         self.signupView.hidden = NO;
                         self.introView.alpha = 0;
                         self.loginView.alpha = 0;
                         self.signupView.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         
                     }];
}

@end
