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

@interface PhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (strong, nonatomic) Post *post;

@end
