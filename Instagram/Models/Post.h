//
//  Post.h
//  Instagram
//
//  Created by Jamie Tan on 7/10/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong, nullable) NSString *postID;
@property (nonatomic, strong, nullable) NSString *userID;
@property (nonatomic, strong, nullable) PFUser *author;

@property (nonatomic, strong, nullable) NSString *caption;
@property (nonatomic, strong, nullable) PFFile *image;
@property (nonatomic, strong, nullable) NSNumber *likeCount;
@property (nonatomic) BOOL liked;
@property (nonatomic, strong, nullable) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
- (NSString * _Nullable ) makeCreatedAtString;

@end
