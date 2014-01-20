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
	[self.activity_indicator stopAnimating];
	
	// Did we login successfully ?
	if (loggedIn) {
		// Seque to the Image Wall
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
        [self presentViewController:vc animated:NO completion:nil];
        
	} else {
		// Show error alert
		[[[UIAlertView alloc] initWithTitle:@"Login Failed"
									message:@"Facebook Login failed. Please try again"
								   delegate:nil
						  cancelButtonTitle:@"Ok"
						  otherButtonTitles:nil] show];
	}
}


@end
