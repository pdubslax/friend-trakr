//
//  testViewController.m
//  friendship
//
//  Created by Patrick Wilson on 3/24/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "testViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface testViewController ()

@end

@implementation testViewController

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
    /*
    FBFriendPickerViewController *friendPickerController =
    [[FBFriendPickerViewController alloc] init];
    // Set the friend picker title
    friendPickerController.title = @"Pick Friends";
    
    // TODO: Set up the delegate to handle picker callbacks, ex: Done/Cancel button
    
    // Load the friend data
    [friendPickerController loadData];
    // Show the picker modally
    [friendPickerController presentModallyFromViewController:self animated:YES handler:nil];
     */
    
    //[[UIApplication sharedApplication] openURL: @"sms:98765432"];

    
    //[self postWithText:@"Test 123" ImageName:@"nil" URL:@"nil" Caption:@"nil" Name:@"nil" andDescription:@"nil"];
    // Do any additional setup after loading the view.
    /*
    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    params.name = @"Sharing Tutorial";
    params.caption = @"Build great social apps and get more installs.";
    params.picture = [NSURL URLWithString:@"http://i.imgur.com/g3Qc1HN.png"];
    params.description = @"Allow your users to share stories on Facebook from your app using the iOS SDK.";
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        // Present the share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                         name:params.name
                                      caption:params.caption
                                  description:params.description
                                      picture:params.picture
                                  clientState:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog([NSString stringWithFormat:@"Error publishing story: %@", error.description]);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
    } else {
        // Present the feed dialog
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       nil, @"link",
                                       @"margot.kriete",@"to",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog([NSString stringWithFormat:@"Error publishing story: %@", error.description]);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
    
    */
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) postWithText: (NSString*) message
           ImageName: (NSString*) image
                 URL: (NSString*) url
             Caption: (NSString*) caption
                Name: (NSString*) name
      andDescription: (NSString*) description
{
  
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   url, @"link",
                                   name, @"name",
                                   caption, @"caption",
                                   description, @"description",
                                   message, @"message",
                                   UIImagePNGRepresentation([UIImage imageNamed: image]), @"picture",
                                   nil];
    
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound)
    {
        // No permissions found in session, ask for it
        [FBSession.activeSession requestNewPublishPermissions: [NSArray arrayWithObject:@"publish_actions"]
                                              defaultAudience: FBSessionDefaultAudienceFriends
                                            completionHandler: ^(FBSession *session, NSError *error)
         {
             if (!error)
             {
                 // If permissions granted and not already posting then publish the story
                [self postToWall: params];
             }
         }];
    }
    else
    {
        // If permissions present and not already posting then publish the story
        
            [self postToWall: params];
        
    }
}

-(void) postToWall: (NSMutableDictionary*) params
{
    
    [FBRequestConnection startWithGraphPath:@"me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             //showing an alert for failure
             UIAlertView *alertView = [[UIAlertView alloc]
                                       initWithTitle:@"Post Failed"
                                       message:error.localizedDescription
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
             [alertView show];
         }
         
     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
