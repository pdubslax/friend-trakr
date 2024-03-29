//
//  AddFriendViewController.m
//  friendship
//
//  Created by Patrick Wilson on 1/18/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "AddFriendViewController.h"
#import "FriendshipTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "FriendCell.h"
#import "MyManger.h"
#import "SelectStartViewController.h"
#import "FriendshipViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController{
    NSArray *names;
    NSArray *searchResults;
}



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
    names = self.friend_array;
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [names count];
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
    
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
    */
    
    static NSString *tableId = @"swagswag";
    UITableViewCell *newcell = [tableView dequeueReusableCellWithIdentifier:tableId];
    if (newcell==nil){
        newcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableId];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        newcell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
        newcell.textLabel.text = [names objectAtIndex:indexPath.row];
    }

    newcell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    
    return newcell;

}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSString *searchString = searchText;
    NSArray *words = [searchString componentsSeparatedByString:@" "];
    NSMutableArray *predicateList = [NSMutableArray array];
    for (NSString *word in words) {
        if ([word length] > 0) {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@ OR SELF CONTAINS[c] %@", word, word];
            [predicateList addObject:pred];
        }
    }
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicateList];
    NSLog(@"%@", predicate);
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    
    searchResults = [names filteredArrayUsingPredicate:predicate];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString scope:nil];
    
    return YES;
}


- (IBAction)back_button:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MyManager *sharedManager = [MyManager sharedManager];

    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber * user = [f numberFromString:sharedManager.my_id_array[0]];
    NSUInteger fooIndex = 0;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSString * friendname =  [searchResults objectAtIndex:indexPath.row];
         fooIndex = [names indexOfObject: friendname];
    } else {
        NSString * friendname = [names objectAtIndex:indexPath.row];
        fooIndex = [names indexOfObject: friendname];
    }
    
    NSNumber * friend =  [f numberFromString:[sharedManager.friend_id_array objectAtIndex:fooIndex]];
                       
    
    
    PFObject *addfriend = [PFObject objectWithClassName:@"Friendships"];
    addfriend[@"username"]=[[PFUser currentUser] username];
    addfriend[@"User"]=user;
    addfriend[@"Friend"]=friend;
    
    addfriend[@"myName"]=sharedManager.meviewName;
    
    
    SelectStartViewController *newvc = [[SelectStartViewController alloc] init];
    newvc.thisistheone = addfriend;
    newvc.manger = sharedManager;
    newvc.afvc = self;
    newvc.facebookid = friend;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newvc];
    
    
    [self.navigationController presentViewController:navigationController animated:NO completion:^(){
        
        

    }];
    
    [addfriend saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            [FBRequestConnection
             startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=400&height=400", friend]];
                     NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@",friend]];
                     NSData *data = [NSData dataWithContentsOfURL:url];
                     NSData *data2 = [NSData dataWithContentsOfURL:url2];
                     id jsonObjects = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
                     NSString *profile_name = [jsonObjects objectForKey:@"name"];
                     addfriend[@"theirName"]=profile_name;
                     [addfriend saveInBackground];
                     UIImage *profilePic = [[UIImage alloc] initWithData:data];
                     [sharedManager.array3 addObject:profile_name];
                     [sharedManager.array4 addObject:profilePic];
                     
                     
                     [sharedManager.cur_friend_id addObject:[friend stringValue]];
                     
                     
                     
                     
                 }
             }];
            
            
            
        }
    }];
    

    
    
    
    
}

- (void)shesgone{
    MyManager *sharedManager = [MyManager sharedManager];
    UINavigationController *navController = self.navigationController;
    
    [self.searchDisplayController setActive:FALSE];
    //[self.navigationController popViewControllerAnimated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FriendshipViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"checkmeout"];
    vc.name = [sharedManager.array3 objectAtIndex:[sharedManager.score count]-1];
    vc.score = [sharedManager.score objectAtIndex:[sharedManager.score count]-1];
    vc.facebookId = [sharedManager.cur_friend_id objectAtIndex:[sharedManager.score count]-1];
    vc.bigprofpic = [sharedManager.array4 objectAtIndex:[sharedManager.score count]-1];
    
    [navController popViewControllerAnimated:NO];
    [navController pushViewController:vc animated:NO];
}




@end
