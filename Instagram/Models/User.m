//
//  User.m
//  Instagram
//
//  Created by Jamie Tan on 7/12/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic profilePicImage, bio;


- (void) updateUserWithPic:(UIImage *)image withBio:(NSString *)bio withCompletion:(PFBooleanResultBlock)completion{
    self.profilePicImage = [self getPFFileFromImage:image];
    self.bio = bio;
    
    [self saveInBackgroundWithBlock:completion];
}

- (PFFile *) getPFFileFromImage: (UIImage * _Nullable) image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}


@end
