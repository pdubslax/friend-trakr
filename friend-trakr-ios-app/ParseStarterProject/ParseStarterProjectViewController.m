#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>
#import "CustomPFLoginViewController.h"

@implementation ParseStarterProjectViewController{
    int test;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    test=0;

    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

    
    
    CustomPFLoginViewController *logInController = [[CustomPFLoginViewController alloc] init];
    logInController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton  | PFLogInFieldsSignUpButton | PFLogInFieldsFacebook;
    logInController.delegate = self;
    logInController.signUpController.delegate = self;
    if (test==0) {
        [self presentModalViewController:logInController animated:NO];

    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
        
        
        [self presentViewController:vc animated:NO completion:nil];
    }
    
}


/*! @name Responding to Actions */
/// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUser:user permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Woohoo, user logged in with Facebook!");
            }
        }];
    }
    [self dismissModalViewControllerAnimated:YES];
    test=1;
    
    
    
}

/// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissModalViewControllerAnimated:YES];
}











@end
