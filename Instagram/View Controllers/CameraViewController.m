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
#import <MBProgressHUD/MBProgressHUD.h>

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionText;
@property (nonatomic) BOOL uploading;
@property (nonatomic) BOOL addedCaption;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];    // Do any additional setup after loading the view.
    self.captionText.delegate = self;
    self.uploading = NO;
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapCancel:(id)sender {
    [self clear];
}

- (IBAction)didTapImage:(id)sender {
    [self getImageFromCamera];
}

- (IBAction)didTapSelectFromLibrary:(id)sender {
    [self getImageFromLibrary];
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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *caption = self.captionText.text;
        if (!self.addedCaption) {
            caption = @"";
        }
        [Post postUserImage:self.postImageView.image withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self clear];
                NSLog(@"Everything's cool");
            }
            else {
                NSLog(@"Failed with error: %@", error.localizedDescription);
            }
            self.uploading = NO;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    else {
        NSLog(@"No image dude or uploading right now");
    }
}

- (void) getImageFromCamera{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera unavailiable, using photo library instead");
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void) getImageFromLibrary {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.captionText.text = @"";
    self.captionText.textColor = [UIColor blackColor];
    self.addedCaption = YES;
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    if ([self.captionText.text isEqualToString:@""]) {
        self.captionText.text = @"Add a caption...";
        self.captionText.textColor = [UIColor darkGrayColor];
        self.addedCaption = NO;
    }
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
