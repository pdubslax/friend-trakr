//
//  FriendshipTableViewController.m
//  friendship
//
//  Created by Patrick Wilson on 1/18/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "FriendshipTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AddFriendViewController.h"

@interface FriendshipTableViewController ()

@end

@implementation FriendshipTableViewController

NSMutableArray *friendArray;
NSMutableArray *pictureArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1]};
    
    self.add_friend_button.tintColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    
    friendArray=[[NSMutableArray alloc] init];
    pictureArray=[[NSMutableArray alloc] init ];
    
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        //NSArray* pictures = [result objectForKey:@"picture"];
        NSLog(@"Found: %i friends", friends.count);
        int i=0;
        
        for (NSDictionary<FBGraphUser>* friend in friends) {
            NSString *friendName = friend.name;
            int friendID = [friend.id integerValue];
            
            
            
            
            [friendArray addObject:friendName];
            
            [FBRequestConnection
             startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%d/picture?type=small", friendID]];
                     NSData *data = [NSData dataWithContentsOfURL:url];
                     UIImage *profilePic = [[UIImage alloc] initWithData:data] ;
                     [pictureArray addObject:profilePic];
                     
                     
                 }
             }];
            
            
            
            if (i>10) {
                break;
            }
            
            i++;
        }
        
        
    }];

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 3;
    }else{
        return 4;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;    //count of section
}



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.text = @"Test";
    return cell;
}


- (IBAction)findmefriends_button_pressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AddFriendViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"friend_add"];
    vc.friend_array = friendArray;
    vc.profile_picture_array = pictureArray;
    [self.navigationController pushViewController:vc animated:NO];
    
}
@end
