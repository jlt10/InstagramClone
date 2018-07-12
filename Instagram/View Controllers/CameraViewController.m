//
//  CameraViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/9/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "CameraViewController.h"
#import <UIKit/UIKit.h>
#import "Post.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionText;
@property (nonatomic) BOOL uploading;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];    // Do any additional setup after loading the view.
    self.uploading = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapCancel:(id)sender {
    [self clear];
}

- (IBAction)didTapImage:(id)sender {
    [self getImage];
}

- (void) clear{
    self.captionText.text = @"";
    self.postImageView.image = [UIImage imageNamed:@"image_placeholder"];
    [self dismissViewControllerAnimated:YES completion:^{
        //something
    }];
}

- (IBAction)didTapShare:(id)sender {
    if (![self.postImageView.image isEqual:[UIImage imageNamed:@"image_placeholder"]] && !self.uploading) {
        NSLog(@"Starting Request");
        self.uploading = YES;
        [Post postUserImage:self.postImageView.image withCaption:self.captionText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self clear];
                NSLog(@"Everything's cool");
            }
            else {
                NSLog(@"Failed with error: %@", error.localizedDescription);
            }
            self.uploading = NO;
        }];
    }
    else {
        NSLog(@"No image dude or uploading right now");
    }
}

- (void) getImage{
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera unavailiable, using photo library instead");
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    CGSize size = CGSizeMake(400, 400);
    
    self.postImageView.image = [self resizeImage:editedImage withSize:size];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
