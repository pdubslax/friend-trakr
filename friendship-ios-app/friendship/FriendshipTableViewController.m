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
#import "FriendCell.h"
#import "MyManger.h"
#import "AMGProgressView.h"

@interface FriendshipTableViewController ()

@end

@implementation FriendshipTableViewController

NSMutableArray *friendArray;
NSMutableArray *pictureArray;
NSMutableArray *scoreArray;


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
    
    MyManager *sharedManager = [MyManager sharedManager];
    friendArray = sharedManager.array3;
    pictureArray = sharedManager.array4;
    scoreArray = sharedManager.score;
    
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1]};
    
    self.add_friend_button.tintColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    
    

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [friendArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"FriendCell";
    
    FriendCell *cell = (FriendCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FriendCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    int score = [[scoreArray objectAtIndex:indexPath.row] intValue];
    
    cell.name_label.text = [friendArray objectAtIndex:indexPath.row];
    
    
    cell.profile_image.image = [pictureArray objectAtIndex:indexPath.row];
    
    CALayer *roundtest = [cell.profile_image layer];
    [roundtest setMasksToBounds:YES];
    [roundtest setCornerRadius:27.0];
    
    AMGProgressView * prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(0, 5, 320, 50)];
    if (score>50) {
        prog.gradientColors = @[[UIColor colorWithRed:0.1f green:0.7f blue:0.1f alpha:1.0f],
                                [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    }else{
        prog.gradientColors = @[[UIColor colorWithRed:0.7f green:0.1f blue:0.1f alpha:1.0f],
                                    [UIColor colorWithRed:0.9f green:0.6f blue:0.6f alpha:1.0f]];
    }
    
    float num = score;
    num/=100;
    
    prog.progress = num;
    [cell.contentView insertSubview:prog atIndex:0];
    
    
    
    return cell;
}


- (IBAction)findmefriends_button_pressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AddFriendViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"friend_add"];
    //vc.friend_array = friendArray;
    //vc.profile_picture_array = pictureArray;
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dsfdsf");
}
@end
