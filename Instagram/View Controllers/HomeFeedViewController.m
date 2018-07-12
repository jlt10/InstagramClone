//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Jamie Tan on 7/9/18.
//  Copyright © 2018 jamietan. All rights reserved.
//

#import "HomeFeedViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "PhotoCell.h"
#import "DetailViewController.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL isMoreDataLoading;
@property (nonatomic) BOOL loadedAllPosts;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    self.posts = [[NSMutableArray alloc] init];
    self.isMoreDataLoading = NO;
    self.loadedAllPosts = NO;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self fetchPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;

    self.loadedAllPosts = NO;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            [self.posts removeAllObjects];
            for (Post *post in posts) {
                [self.posts addObject:post];
            }
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        }
        else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.post = self.posts[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.loadedAllPosts && !self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height - 50;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = YES;
            [self fetchMorePosts:(int)[self.tableView numberOfRowsInSection:0]];
        }
    }
}

- (void) fetchMorePosts:(int)lastPostIndex {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    query.skip = lastPostIndex;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts) {
            for (Post *post in posts) {
                [self.posts addObject:post];
            }
            [self.tableView reloadData];
            self.isMoreDataLoading = NO;
            if (posts.count == 0){
                self.loadedAllPosts = YES;
            }
        }
        else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"postDetails"]) {
        DetailViewController *detailController = [segue destinationViewController];
        PhotoCell *tappedCell = sender;
        detailController.post = tappedCell.post;
        detailController.delegate = tappedCell;
        
    }
}

@end
