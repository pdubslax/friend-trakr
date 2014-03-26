//
//  ViewController.m
//  friendship
//
//  Created by Patrick Wilson on 1/18/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Comms.h"
#import "BButton.h"
#import "ViewController.h"
#import "MyManger.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    
    [PFUser logOut];
    
    CGRect frame = CGRectMake(20, 405, 280, 50);
    BButton *btn = [[BButton alloc] initWithFrame:frame type:BButtonTypeFacebook style:BButtonStyleBootstrapV3];
    [btn setTitle:@"Login" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buttonPressed:(UIButton *)sender {
    // The permissions requested from the user
    
    // Disable the Login button to prevent multiple touches
	sender.hidden = YES;
	
	// Show an activity indicator
	[self.activity_indicator startAnimating];
	
	// Do the login
	[Comms login:self];
    
    
    
    // Login PFUser using Facebook
    
    
    
    
}

- (void) commsDidLogin:(BOOL)loggedIn {
	// Re-enable the Login button
	
	
	// Stop the activity indicator
	
	
	// Did we login successfully ?
	if (loggedIn) {
		// Seque to the Image Wall
        
        
        [self add_friend_method]; // generates array of people you might want to follow
        
        //
        
        
 //NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self
                                                          //selector: @selector(callAfterSixtySecond:) userInfo: nil repeats: YES];
        
        
        
        
        
	} else {
		// Show error alert
		[[[UIAlertView alloc] initWithTitle:@"Login Failed"
									message:@"Facebook Login failed. Please try again"
								   delegate:nil
						  cancelButtonTitle:@"Ok"
						  otherButtonTitles:nil] show];
	}
}

-(void) callAfterSixtySecond:(NSTimer*) t
{
    
    
    
}

- (void)add_friend_method{
    
    //www.facebook.com/ajax/typeahead/search/facebar/bootstrap/?viewer=1317841444&__a=1
    NSMutableArray* alreadyFriends = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Friendships"];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            for (PFObject *test in objects){
                
                NSString *friendnumber = [test objectForKey:@"Friend"];
                [alreadyFriends addObject:[NSString stringWithFormat:@"%@",friendnumber]];
 
            }
            
            
            
            MyManager *sharedManager = [MyManager sharedManager];
            
            NSMutableArray* friendArray=[[NSMutableArray alloc] init];
            NSMutableArray* pictureArray=[[NSMutableArray alloc] init ];
            NSMutableArray* friend_id_array=[[NSMutableArray alloc] init ];
            
            FBRequest* friendsRequest = [FBRequest requestForMyFriends];
            
            [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                          NSDictionary* result,
                                                          NSError *error) {
                NSArray* friends = [result objectForKey:@"data"];
                NSLog(@"Found: %i friends", friends.count);
                
                //following is the logic concerning the initial adding of a full facebook friends list
                
                
                //int i=0;
                
                for (NSDictionary<FBGraphUser>* friend in friends) {
                    NSString *friendName = friend.name;
                    NSString *friendID = friend.id;
                    /*
                    if (![alreadyFriends containsObject:friendID]) {
                        [FBRequestConnection
                         startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                             if (!error) {
                                 
                                 NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small", friendID]];
                                 NSData *data = [NSData dataWithContentsOfURL:url];
                                 UIImage *profilePic = [[UIImage alloc] initWithData:data] ;
                                 [pictureArray addObject:profilePic];
                     
                                 
                                 
                                 
                                 
                                 
                             }
                         }];
                        i++;
                        
                    }
                    */
                    [friendArray addObject:friendName];
                    [friend_id_array addObject:friendID];
                    
                    
                    
                    
                    
                }
                
                
            }];
            
            FBRequest* meRequest = [FBRequest requestForMe];
            
            [meRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                     NSDictionary* result,
                                                     NSError *error) {
                
                [sharedManager.my_id_array addObject:[result objectForKey:@"id"]];
                
            }];
            
            
            
            sharedManager.array1 = friendArray;
            sharedManager.array2 = pictureArray;
            sharedManager.friend_id_array = friend_id_array;
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self find_current_follows];
            });

            
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
}

- (void)find_current_follows{
    NSMutableArray* friendArray=[[NSMutableArray alloc] init];
    NSMutableArray* pictureArray=[[NSMutableArray alloc] init ];
    NSMutableArray* scoreArray=[[NSMutableArray alloc] init ];
    NSMutableArray* curfriendID=[[NSMutableArray alloc]init];
    MyManager *sharedManager = [MyManager sharedManager];
    PFQuery *query = [PFQuery queryWithClassName:@"Friendships"];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            for (PFObject *test in objects){
                
                
                //int usernumber = [[test objectForKey:@"User"] intValue];
                NSString *friendnumber = [test objectForKey:@"Friend"];
                int score = [[test objectForKey:@"Score"]intValue];
                
                [FBRequestConnection
                 startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small", friendnumber]];
                         NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@",friendnumber]];
                         NSData *data = [NSData dataWithContentsOfURL:url];
                         NSData *data2 = [NSData dataWithContentsOfURL:url2];
                         UIImage *profilePic = [[UIImage alloc] initWithData:data] ;
                         
                         NSDictionary* jsonObjects = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
                         NSString *name = [jsonObjects objectForKey:@"name"];
                         [pictureArray addObject:profilePic];
                         [friendArray addObject:name];
                         [scoreArray addObject:[NSNumber numberWithInt:score]];
                         
                         [curfriendID addObject:[NSString stringWithFormat:@"%@",friendnumber]];
                     }
                 }];
                
                
            }
            sharedManager.array3 = friendArray;
            sharedManager.array4 = pictureArray;
            sharedManager.score = scoreArray;
            sharedManager.cur_friend_id = curfriendID;
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self move_on];
            });
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
    
    
    
    
}


- (void)move_on{
    
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSString *facebookId = [result objectForKey:@"id"];
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=400&height=400", facebookId]];
             NSData *data = [NSData dataWithContentsOfURL:url];
             NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@", facebookId]];
             NSData *data2 = [NSData dataWithContentsOfURL:url2];
             
             id jsonObjects = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
             NSString *profile_name = [jsonObjects objectForKey:@"name"];
             
             UIImage *profilePic = [[UIImage alloc] initWithData:data] ;
             
             MyManager *sharedManager = [MyManager sharedManager];
             sharedManager.meviewImage = profilePic;
             sharedManager.meviewName = profile_name;
             
             dispatch_async(dispatch_get_main_queue(), ^ {
                 [self all_done];
             });
             
         }
     }];
    
    
}

- (void)all_done{
    [self.activity_indicator stopAnimating];
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
    [self presentViewController:vc animated:NO completion:nil];
}




@end
