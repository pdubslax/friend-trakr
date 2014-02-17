//
//  AddFriendViewController.m
//  friendship
//
//  Created by Patrick Wilson on 1/18/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "AddFriendViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "FriendCell.h"
#import "MyManger.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MyManager *sharedManager = [MyManager sharedManager];
    self.friend_array = sharedManager.array1;
    self.profile_picture_array = sharedManager.array2;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.friend_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *simpleTableIdentifier = @"FriendCell";
    
    FriendCell *cell = (FriendCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FriendCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    
    cell.name_label.text = [self.friend_array objectAtIndex:indexPath.row];
    
    
    cell.profile_image.image = [self.profile_picture_array objectAtIndex:indexPath.row];
    
    CALayer *roundtest = [cell.profile_image layer];
    [roundtest setMasksToBounds:YES];
    [roundtest setCornerRadius:27.0];

    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



- (IBAction)back_button:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)search_button:(id)sender {
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyManager *sharedManager = [MyManager sharedManager];

    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber * user = [f numberFromString:sharedManager.my_id_array[0]];
    
    NSNumber * friend =  [f numberFromString:[sharedManager.friend_id_array objectAtIndex:indexPath.row]];
                       
    
    
    PFObject *addfriend = [PFObject objectWithClassName:@"Friendships"];
    addfriend[@"username"]=[[PFUser currentUser] username];
    addfriend[@"User"]=user;
    addfriend[@"Friend"]=friend;
    NSNumber *score = [NSNumber numberWithInteger:arc4random()%100];
    addfriend[@"Score"]=score;
    [addfriend saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            [FBRequestConnection
             startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small", friend]];
                     NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@",friend]];
                     NSData *data = [NSData dataWithContentsOfURL:url];
                     NSData *data2 = [NSData dataWithContentsOfURL:url2];
                     id jsonObjects = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
                     NSString *profile_name = [jsonObjects objectForKey:@"name"];

                     UIImage *profilePic = [[UIImage alloc] initWithData:data];
                     [sharedManager.array3 addObject:profile_name];
                     [sharedManager.array4 addObject:profilePic];
                     [sharedManager.score addObject:score];
                 }
             }];
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
}
@end
