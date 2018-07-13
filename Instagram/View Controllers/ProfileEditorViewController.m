//
//  ProfileEditorViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/12/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "ProfileEditorViewController.h"
#import <ParseUI/ParseUI.h>

@interface ProfileEditorViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicImage;
@property (weak, nonatomic) IBOutlet UITextView *bioText;
@property (nonatomic) BOOL addedBio;

@end

@implementation ProfileEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
    self.user = (User *)[PFUser currentUser];
    
    self.profilePicImage.layer.cornerRadius = self.profilePicImage.frame.size.height/2;
    self.profilePicImage.image = [UIImage imageNamed:@"profile_tab"];
    self.bioText.delegate = self;
    
    self.usernameLabel.text = self.user.username;
    if (self.user.profilePicImage) {
        self.profilePicImage.file = self.user.profilePicImage;
        [self.profilePicImage loadInBackground];
    }
    if (self.user.bio && ![self.user.bio isEqualToString:@""]) {
        self.bioText.text = self.user.bio;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    CGSize size = CGSizeMake(200, 200);
    
    self.profilePicImage.image = [self resizeImage:editedImage withSize:size];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // Something
    }];
}

- (IBAction)didTapDone:(id)sender {
    NSString *bio = @"";
    if (self.addedBio) {
        bio = self.bioText.text;
    }
    else {
        if (self.user.bio) bio = self.user.bio;
    }
    
    [self.user updateUserWithPic:self.profilePicImage.image withBio:bio withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Success");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            NSLog(@"Failure");
        }
    }];
}
- (IBAction)didTapChangeProfImage:(id)sender {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (!self.addedBio) {
        self.bioText.text = @"";
        self.bioText.textColor = [UIColor blackColor];
        self.addedBio = YES;
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    if ([self.bioText.text isEqualToString:@""]) {
        self.bioText.text = @"Add a bio...";
        self.bioText.textColor = [UIColor darkGrayColor];
        self.addedBio = NO;
    }
}
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
