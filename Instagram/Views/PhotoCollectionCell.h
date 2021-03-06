//
//  PhotoCollectionCell.h
//  Instagram
//
//  Created by Jamie Tan on 7/11/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"
#import "DetailViewController.h"

@interface PhotoCollectionCell : UICollectionViewCell <DetailViewControllerDelegate>
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;

@end
