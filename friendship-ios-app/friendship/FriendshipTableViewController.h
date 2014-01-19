//
//  FriendshipTableViewController.h
//  friendship
//
//  Created by Patrick Wilson on 1/18/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendshipTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *add_friend_button;

@property (strong, nonatomic) IBOutlet UITableView *friendship_tableView;
- (IBAction)findmefriends_button_pressed:(id)sender;

@end
