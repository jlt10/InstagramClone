//
//  Post.h
//  Instagram
//
//  Created by Jamie Tan on 7/10/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong, nullable) NSString *postID;
@property (nonatomic, strong, nullable) NSString *userID;
@property (nonatomic, strong, nullable) User *author;

@property (nonatomic, strong, nullable) NSString *caption;
@property (nonatomic, strong, nullable) PFFile *image;
@property (nonatomic, strong, nullable) NSNumber *likeCount;
@property (nonatomic, strong, nullable) NSMutableArray *likedBy;
@property (nonatomic, strong, nullable) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
- (NSString * _Nullable ) makeCreatedAtString;
- (BOOL) likedByCurrentUser;

@end
