//
//  ProfileViewController.h
//  Instagram
//
//  Created by Jamie Tan on 7/11/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "User.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) User *user;

@end
