//
//  PhotoCell.h
//  Instagram
//
//  Created by Jamie Tan on 7/9/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <ParseUI/ParseUI.h>
#import "DetailViewController.h"
#import "ProfileViewController.h"

@protocol PhotoCellDelegate

-(void) showProfileScreen:(PFUser *)user;

@end


@interface PhotoCell : UITableViewCell <DetailViewControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *userHeaderView;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicImage;
@property (weak, nonatomic) IBOutlet UILabel *topUsernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *botUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) id<PhotoCellDelegate> delegate;
@end
