//
//  MeViewController.m
//  ParseStarterProject
//
//  Created by Patrick Wilson on 1/18/14.
//
//

#import "MeViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "AMGProgressView.h"
#import "BButton.h"
#import "MyManger.h"
#import <FacebookSDK/FacebookSDK.h>
#import "NSOperationQueue+SharedQueue.h"



@interface MeViewController ()
@property (nonatomic, strong) AMGProgressView *prog;

@end



@implementation MeViewController
@synthesize profile_picture;

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
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            
            NSLog(@"done loading");
        });
    });
    
    [[NSOperationQueue pffileOperationQueue] addOperationWithBlock:^ {
        //execute on another thread 
    }];
    
    
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1]};
        
    self.settings.tintColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    
    if (self.view.bounds.size.height == 568) {
        self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 400, 280, 50)];
    } else {
        self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 350, 280, 50)];
    }
    
    UILabel *friendometer_label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.prog.frame.origin.y-40, 320, 40)];
    friendometer_label.text = @"FriendOMeter";
    friendometer_label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:friendometer_label];
    
    
    
    self.prog.gradientColors = @[[UIColor colorWithRed:0.1f green:0.7f blue:0.1f alpha:1.0f],
                                [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    self.prog.progress = 0.75f;
    //self.prog.outsideBorder = [UIColor blackColor];
    //int percent = self.prog.progress*100;
    //[friend_percentage_label setText:[NSString stringWithFormat:@"Friendship Score of %d/100", percent]];
    
    
    [self.view addSubview:self.prog];
    CALayer *roundtest = [self.prog layer];
    [roundtest setMasksToBounds:YES];
    [roundtest setCornerRadius:10.0];
    
    
    
    [profile_picture setContentMode:UIViewContentModeScaleAspectFill];
    CALayer *round = [profile_picture layer];
    [round setMasksToBounds:YES];
    [round setCornerRadius:10.0];
    
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSString *facebookId = [result objectForKey:@"id"];
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", facebookId]];
             NSData *data = [NSData dataWithContentsOfURL:url];
             NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@", facebookId]];
             NSData *data2 = [NSData dataWithContentsOfURL:url2];

             id jsonObjects = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
             NSString *profile_name = [jsonObjects objectForKey:@"name"];
             
             UIImage *profilePic = [[UIImage alloc] initWithData:data] ;
             [profile_picture setImage:profilePic];
             self.navigationController.navigationBar.topItem.title=profile_name;
             
         }
     }];
    
    /*
    [[BButton appearance] setButtonCornerRadius:@10.0f];
    
    CGRect frame = CGRectMake(20, 460, 135, 50);
    BButton *btn = [[BButton alloc] initWithFrame:frame type:BButtonTypeDanger style:BButtonStyleBootstrapV3];
    [btn setTitle:@"Logout" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    CGRect frame2 = CGRectMake(20, 405, 280, 50);
    BButton *btn2 = [[BButton alloc] initWithFrame:frame2 type:BButtonTypeInverse style:BButtonStyleBootstrapV3];
    [btn2 setTitle:@"General Settings" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    CGRect frame3 = CGRectMake(165, 460, 135, 50);
    BButton *btn3 = [[BButton alloc] initWithFrame:frame3 type:BButtonTypePrimary style:BButtonStyleBootstrapV3];
    [btn3 setTitle:@"Connect" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
*/
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)settings_button:(id)sender {

    
    [PFUser logOut];
    

    
    MyManager *sharedManager = [MyManager sharedManager];
    [sharedManager reset];
    
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"logscrn"];
    vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    
    
    
    [self presentViewController:vc animated:YES completion:nil];
}



@end
