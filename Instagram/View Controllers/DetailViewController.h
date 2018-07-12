//
//  DetailViewController.h
//  Instagram
//
//  Created by Jamie Tan on 7/10/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol DetailViewControllerDelegate

- (void) didUpdatePost:(Post *)post;
@end


@interface DetailViewController : UIViewController

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) id<DetailViewControllerDelegate> delegate;

@end
