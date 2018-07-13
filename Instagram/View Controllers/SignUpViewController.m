//
//  SignUpViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/12/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "User.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}


- (void)registerUser {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        // we crete a new alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty Field" message:@"Please make sure both username and password fields are completed" preferredStyle:UIAlertControllerStyleAlert];
        
        // create an action(button)N for that alert
        //handler is what happens after press action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                // more extra stuff just want to dismiss
            }];
        }];
        
        //how to actually apply it
        [alert addAction:okAction];
        
        //want to present after programming error
        [self presentViewController:alert animated:YES completion:^{
            // for when the controler is finished
        }];
    }
    else {
        // initialize a user object
        User *newUser = [User user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        newUser.bio = @"";
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self segueToFeed];
            }
        }];
    }
}

- (void) segueToFeed {
    self.usernameField.text = @"";
    self.passwordField.text = @"";
    [self performSegueWithIdentifier:@"loginSegue" sender:nil];
}
- (IBAction)didTapHaveAccount:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // Something
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
