//
//  ProfileViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/11/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "ProfileViewController.h"
#import "PhotoCollectionCell.h"
#import "DetailViewController.h"
#import "ProfileEditorViewController.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet PFImageView *profilePicImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@property (strong, nonatomic) NSMutableArray *userPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.editProfileButton.hidden = YES;
    if (!self.user){
        self.user = (User *)[PFUser currentUser];
    }
    
    self.profilePicImage.layer.cornerRadius = self.profilePicImage.frame.size.height/2;
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.userPosts = [[NSMutableArray alloc] init];
    
    CGFloat maxHeight = self.collectionView.frame.origin.y + self.collectionView.contentSize.height + 10;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, maxHeight);
//    self.collectionView.contentSize = CGSizeMake(self.collectionView.contentSize.width, self.collectionView.contentSize.height);
    
    [self.editProfileButton.layer setBorderWidth:1];
    [self.editProfileButton.layer setBorderColor:[[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] CGColor]];
    
    [self refreshView];
}

- (void) viewDidAppear:(BOOL)animated {
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchUserPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:self.user];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            [self.userPosts removeAllObjects];
            for (Post *post in posts) {
                [self.userPosts addObject:post];
            }
            self.postCountLabel.text = [NSString stringWithFormat:@"%lu", self.userPosts.count];
            [self.collectionView reloadData];
        }
        else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
    
}

- (void) refreshView {
    self.profilePicImage.file = self.user.profilePicImage;
    [self.profilePicImage loadInBackground];
    if (self.user.bio) {
        self.descriptionLabel.text = self.user.bio;
    }
    else {
        self.descriptionLabel.text = @"";
    }
    
    if ([self.user.objectId isEqual:User.currentUser.objectId]){
        self.editProfileButton.hidden = NO;
    }
    
    self.usernameLabel.text = self.user.username;
    [self fetchUserPosts];
    
}

- (void) didUpdateUser {
    [self refreshView];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"postDetails"]) {
        DetailViewController *detailController = [segue destinationViewController];
        PhotoCollectionCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        Post *post = self.userPosts[indexPath.row];
        detailController.post = post;
        detailController.delegate = tappedCell;
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // something
    PhotoCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionCell" forIndexPath:indexPath];
    cell.post = self.userPosts[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat spacing = 2;
    layout.minimumInteritemSpacing = spacing;
    layout.minimumLineSpacing = spacing;
    
    CGFloat postsPerRow = 3;
    CGFloat itemDim = (self.collectionView.frame.size.width - (postsPerRow-1)*layout.minimumInteritemSpacing - layout.sectionInset.left - layout.sectionInset.right)/postsPerRow;
    return CGSizeMake(itemDim, itemDim);
}

@end
