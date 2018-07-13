//
//  User.h
//  Instagram
//
//  Created by Jamie Tan on 7/12/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : PFUser

@property (strong, nonatomic) PFFile *profilePicImage;
@property (strong, nonatomic) NSString *bio;

- (void) updateUserWithPic:(UIImage *)image withBio:(NSString *)bio withCompletion:(PFBooleanResultBlock)completion;
@end
