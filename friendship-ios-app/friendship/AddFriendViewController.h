//
//  AddFriendViewController.h
//  friendship
//
//  Created by Patrick Wilson on 1/18/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendViewController : UITableViewController
- (IBAction)back_button:(id)sender;
@property (strong,nonatomic) NSMutableArray *friend_array;
@property (strong,nonatomic) NSMutableArray *profile_picture_array;

@end