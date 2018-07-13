//
//  PhotoCell.m
//  Instagram
//
//  Created by Jamie Tan on 7/9/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapUserProfile)];
    [self.userHeaderView addGestureRecognizer:singleFingerTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPost:(Post *)post {
    _post = post;
    self.postImage.image = [UIImage imageNamed:@"image_placeholder"];
    self.postImage.file = post.image;
    [self.postImage loadInBackground];
    
    self.profilePicImage.layer.cornerRadius = self.profilePicImage.frame.size.height/2;
    self.profilePicImage.image = [UIImage imageNamed:@"profile_tab"];
    if (self.post.author.profilePicImage) {
        self.profilePicImage.file = self.post.author.profilePicImage;
        [self.profilePicImage loadInBackground];
    }
    
    [self refreshView];
    self.topUsernameLabel.text = post.author.username;
    self.botUsernameLabel.text = post.author.username;
    self.captionLabel.text = post.caption;
    self.createdAtLabel.text = [[post makeCreatedAtString] uppercaseString];
}

- (void) refreshView{
//    NSLog(@"Likes: %@ Faved: %d", post.likeCount, [post likedByCurrentUser]);
    self.likeButton.selected = [self.post likedByCurrentUser];
    NSString *likesText = @"%@ Likes";
    if ([self.post.likeCount isEqualToNumber:@1]) likesText = @"%@ Like";
    self.likesLabel.text = [NSString stringWithFormat:likesText, self.post.likeCount];
}

- (IBAction)didTapLike:(id)sender {
    [self toggleFavorite];
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
                [post removeObject:User.currentUser.objectId forKey:@"likedBy"];
//                NSLog(@"Unliking Likes: %@ Faved: %d", post.likeCount, [post likedByCurrentUser]);
            }
            else {
                [post incrementKey:@"likeCount" byAmount:@(1)];
                [post addObject:User.currentUser.objectId forKey:@"likedBy"];
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

-(void)didUpdatePost:(Post *)post {
    self.post = post;
    [self refreshView];
}

- (void) didTapUserProfile {
    [self.delegate showProfileScreen:self.post.author];
}

@end
