# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **40** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"
- [X] User can pull to refresh the last 20 posts submitted to "Instagram"
- [X] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [X] Run your app on your phone and use the camera to take the photo
- [X] Style the login page to look like the real Instagram login page.
- [X] Style the feed to look like the real Instagram feed.
- [X] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs for Home Feed and Profile
- [X] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [X] Show the username and creation time for each post
- [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
- [X] Allow the logged in user to add a profile photo
- [X] Display the profile photo with each post
- [X] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [X] User can like a post and see number of likes for each post in the post details screen.
- [X] Implement a custom camera view.

The following **additional** features are implemented:

- [X] User can add a bio and see a user's bio by going to that user's profile page
- [X] User can post a photo from the photo library
- [X] Compose new post screen presents modally like real Instagram
- [X] User profile updates after changes are made (new post/new profile picture/new bio)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. When to make classes for buttons/views that are often repeated across screens (to avoid copy paste)
2. More features of collection views and table views (like section headers/footers) that we didn't get a chance to cover in Codepath

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/R0nw8N2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://i.imgur.com/g7RvA48.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://i.imgur.com/Y5B90oj.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library


## Notes

One of the things with this project that was especially challenging was getting everything to update (and stay updated) between view controllers and screens, as well as learning how and what blocks and delegates were. I think I was mostly able to meet the challenge as I now know how to make a delegate and a little bit about why, but overall I think I need to learn much more before I feel comfortable calling myself adept. Autolayout is still a challenge. One of the things I'd really like to work on for future projects is app structure and how to be efficient when making all these files and view controllers. By the end of this project my classes looked kinda cluttered together. 

## License

Copyright [2018] [Jamie Tan]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
