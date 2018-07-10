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
    self.postImage.file = post.image;
    [self.postImage loadInBackground];
    
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", post.likeCount];
    self.usernameLabel.text = post.author.username;
    self.captionLabel.text = post.caption;
}

@end
