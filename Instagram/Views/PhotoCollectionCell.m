//
//  PhotoCollectionCell.m
//  Instagram
//
//  Created by Jamie Tan on 7/11/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "PhotoCollectionCell.h"

@implementation PhotoCollectionCell

- (void) setPost:(Post *)post {
    _post = post;
    self.postImage.image = [UIImage imageNamed:@"image_placeholder"];
    self.postImage.file = post.image;
    [self.postImage loadInBackground];
}

@end
