//
//  CameraViewController.h
//  Instagram
//
//  Created by Jamie Tan on 7/9/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) UIImage *startImage;

@end
