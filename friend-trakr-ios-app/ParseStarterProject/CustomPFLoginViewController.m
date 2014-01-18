//
//  CustomPFLoginViewController.m
//  ParseStarterProject
//
//  Created by Patrick Wilson on 1/17/14.
//
//

#import "CustomPFLoginViewController.h"

@interface CustomPFLoginViewController ()

@end

@implementation CustomPFLoginViewController

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    self.logInView.usernameField.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.logInView.passwordField.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    

	// Do any additional setup after loading the view.
    
    [self.logInView.facebookButton addTarget:self action:@selector(facebookLogin) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) facebookLogin{
  /*
 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
 UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
 
 
 [self presentViewController:vc animated:NO completion:nil];*/
}

@end
