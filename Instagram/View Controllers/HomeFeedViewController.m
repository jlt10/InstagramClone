//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/9/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "HomeFeedViewController.h"
#import <Parse/Parse.h>

@interface HomeFeedViewController ()

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [self dismissViewControllerAnimated:YES completion:^{
            // do something upon completion
        }];
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