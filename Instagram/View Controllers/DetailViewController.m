//
//  DetailViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/10/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "DetailViewController.h"
#import <ParseUI/ParseUI.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImage;
@property (weak, nonatomic) IBOutlet UILabel *botUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topUsernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profilePicImage.layer.cornerRadius = self.profilePicImage.frame.size.height/2;
    self.postImage.file = self.post.image;
    [self.postImage loadInBackground];
    
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post.likeCount];
    self.topUsernameLabel.text = self.post.author.username;
    self.botUsernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
