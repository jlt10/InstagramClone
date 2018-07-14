//
//  CustomCameraViewController.h
//  Instagram
//
//  Created by Jamie Tan on 7/13/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCameraViewControllerDelegate

- (void) didTakePhoto:(UIImage *)image;

@end


@interface CustomCameraViewController : UIViewController

@property (strong, nonatomic) id<CustomCameraViewControllerDelegate> delegate;

@end
