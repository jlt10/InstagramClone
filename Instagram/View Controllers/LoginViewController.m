//
//  LoginViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/9/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "User.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
}


- (void) loginUser  {
    NSString  *username =  self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [User logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"There was an error logging in: %@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            
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
        } else {
            NSLog(@"User logged in successfully");
            [self segueToFeed];
        }
    }];
}

- (void) segueToFeed {
    self.usernameField.text = @"";
    self.passwordField.text = @"";
    [self performSegueWithIdentifier:@"loginSegue" sender:nil];
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
