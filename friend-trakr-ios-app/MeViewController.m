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


@interface MeViewController ()
@property (nonatomic, strong) AMGProgressView *prog;

@end



@implementation MeViewController
@synthesize profile_picture,name_label;

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
    
    
    self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 300, 280, 50)];
    self.prog.gradientColors = @[[UIColor colorWithRed:0.1f green:0.7f blue:0.1f alpha:1.0f],
                                [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    self.prog.progress = 0.75f;
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
             [name_label setText:profile_name];
             
         }
     }];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
