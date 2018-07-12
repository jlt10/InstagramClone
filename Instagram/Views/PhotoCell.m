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
    
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", post.likeCount];
    self.likeButton.selected = [post likedByCurrentUser];
    self.usernameLabel.text = post.author.username;
    self.captionLabel.text = post.caption;
    self.createdAtLabel.text = [[post makeCreatedAtString] uppercaseString];
}

- (void) refreshView{
//    NSLog(@"Likes: %@ Faved: %d", post.likeCount, [post likedByCurrentUser]);
    self.likeButton.selected = [self.post likedByCurrentUser];
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post.likeCount];
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

@end
