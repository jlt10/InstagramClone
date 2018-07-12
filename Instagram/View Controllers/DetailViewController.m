//
//  DetailViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/10/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "DetailViewController.h"
#import <ParseUI/ParseUI.h>
#import <DateTools/NSDate+DateTools.h>

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
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    
    self.postImage.image = [UIImage imageNamed:@"image_placeholder"];
    self.profilePicImage.layer.cornerRadius = self.profilePicImage.frame.size.height/2;
    self.postImage.file = self.post.image;
    [self.postImage loadInBackground];
    
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post.likeCount];
    self.likeButton.selected = [self.post likedByCurrentUser];
    self.topUsernameLabel.text = self.post.author.username;
    self.botUsernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    self.createdAtLabel.text = [self.post makeCreatedAtString];
}

- (void) toggleFavorite{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.post.objectId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (object) {
            Post *post = (Post *)object;
            if ([post likedByCurrentUser]) {
                [post incrementKey:@"likeCount" byAmount:@(-1)];
                [post removeObject:PFUser.currentUser.objectId forKey:@"likedBy"];
                //                NSLog(@"Unliking Likes: %@ Faved: %d", post.likeCount, [post likedByCurrentUser]);
            }
            else {
                [post incrementKey:@"likeCount" byAmount:@(1)];
                [post addObject:PFUser.currentUser.objectId forKey:@"likedBy"];
                //                NSLog(@"Liking Likes: %@ Faved: %d", post.likeCount, [post likedByCurrentUser]);
            }
            [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    self.post = post;
                    [self refreshView];
                }
                
            }];
        }
        else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (void) refreshView {
    self.likeButton.selected = [self.post likedByCurrentUser];
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post.likeCount];
}
- (IBAction)didTapLike:(id)sender {
    [self toggleFavorite];
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
