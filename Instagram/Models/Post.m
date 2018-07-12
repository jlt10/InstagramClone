//
//  Post.m
//  Instagram
//
//  Created by Jamie Tan on 7/10/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "Post.h"
#import <DateTools/NSDate+DateTools.h>

@implementation Post

@dynamic postID, userID, author, caption, image, likeCount, likedBy, commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage:(UIImage *)image withCaption:(NSString *)caption withCompletion:(PFBooleanResultBlock)completion {
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.likedBy = [[NSMutableArray alloc] init];
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock:completion];
}

+ (PFFile *) getPFFileFromImage: (UIImage * _Nullable) image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

- (NSString *) makeCreatedAtString{
    NSString *createdAtString = @"";
    NSTimeInterval secondsBetween = [[NSDate date] timeIntervalSinceDate:self.createdAt];
    if (secondsBetween <= 3600*12) {
        createdAtString = self.createdAt.timeAgoSinceNow;
    }
    else {
        // Configure output format
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterLongStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        createdAtString = [formatter stringFromDate:self.createdAt];
    }
    return createdAtString;
}

- (BOOL) likedByCurrentUser {
    return [self.likedBy containsObject:PFUser.currentUser.objectId];
}

@end
