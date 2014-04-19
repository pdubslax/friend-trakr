//
//  FriendshipViewController.m
//  friendship
//
//  Created by Patrick Wilson on 3/22/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "FriendshipViewController.h"
#import "AMGProgressView.h"
#import "MyManger.h"
#import <FacebookSDK/FacebookSDK.h>
#import "JBLineChartView.h"
#import "JBChartView.h"
#import <Parse/Parse.h>
#import "BButton.h"
#import <MessageUI/MessageUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AMBCircularButton.h"
#import "JBChartInformationView.h"
#import "Constants/JBConstants.h"




//#import "JBChartHeaderView.m"



@implementation FriendshipViewController


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
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@", self.facebookId]];
             NSData *data = [NSData dataWithContentsOfURL:url];
             NSDictionary *infodic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             self.firstname = [NSString stringWithFormat:@"%@",infodic[@"first_name"]];
             self.lastname = [NSString stringWithFormat:@"%@",infodic[@"last_name"]];
             
             
         }
     }];
    
    
    
    
    
    
    [self.tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    
    
    self.navigationController.navigationBar.topItem.title=self.name;
    /*[self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:21],
      NSFontAttributeName, nil]];
    */
    
    if (self.view.bounds.size.height == 568) {
        self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, self.profile_picture.frame.origin.y+self.profile_picture.frame.size.height+63, 280, 50)];
    } else {
        self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 245, 280, 50)];
    }
    /*
    self.friendometer_label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.prog.frame.origin.y-50, 320, 40)];
    
    
    self.friendometer_label.text = [NSString stringWithFormat:@"Friend Score:  %d", [self.score intValue] ];
    [self.friendometer_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    //[friendometer_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    self.friendometer_label.textAlignment = NSTextAlignmentCenter;
    
   */
    /*
     UILabel *number_label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.prog.frame.origin.y+50, 320, 50)];
     
     number_label.text = [NSString stringWithFormat:@"%.02f", [[sharedManager.score valueForKeyPath:@"@avg.self"] floatValue]];
     number_label.textAlignment = NSTextAlignmentCenter;
     */
    //[self.view addSubview:self.friendometer_label];
    float R=255 - (255*[self.score intValue])/100;
    float G=255 - (255*(100-[self.score intValue]))/100;
    float B=20;
    R=R/100;
    G=G/100;
    B=B/100;
    
    
    
    
    
    self.prog.gradientColors = @[[UIColor colorWithRed:R green:G blue:B alpha:1.0],
                                     [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    
    
    self.prog.progress = [self.score floatValue]/100;
    
    
    
    
    
    [self.view addSubview:self.prog];
    CALayer *roundtest = [self.prog layer];
    [roundtest setMasksToBounds:YES];
    [roundtest setCornerRadius:10.0];
    
   
    
    
    
    [self.profile_picture setContentMode:UIViewContentModeScaleAspectFill];
    
    CALayer *round = [self.profile_picture layer];
    [round setMasksToBounds:YES];
    [round setCornerRadius:62.5];
    
    /*
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=400&height=400", self.facebookId]];
             NSData *data = [NSData dataWithContentsOfURL:url];
             
             UIImage *profilePic = [[UIImage alloc] initWithData:data] ;
             [self.profile_picture setImage:profilePic];
             
             
             
         }
     }];
    */
    [self.profile_picture setImage:self.bigprofpic];
    
    /*
    JBChartHeaderView *headerView = [[JBChartHeaderView alloc] initWithFrame:CGRectMake(0,300,320,20)];
    headerView.titleLabel.text = @"Test";
    headerView.titleLabel.textColor = [UIColor blackColor];
    headerView.titleLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    headerView.titleLabel.shadowOffset = CGSizeMake(0, 1);
    headerView.subtitleLabel.text = kJBStringLabel2013;
    headerView.subtitleLabel.textColor = kJBColorLineChartHeader;
    headerView.subtitleLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    headerView.subtitleLabel.shadowOffset = CGSizeMake(0, 1);
    headerView.separatorColor = kJBColorLineChartHeaderSeparatorColor;
    */
    
    UILabel *scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, self.prog.frame.origin.y, 60, 50)];
    scoreLabel.text = [NSString stringWithFormat:@"%.d", [[NSNumber numberWithFloat:self.prog.progress*100] intValue]];
    
    scoreLabel.textColor = [UIColor blackColor];
    scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
    [self.view addSubview:scoreLabel];
    self.friendometer_label = scoreLabel;

    self.lineChartView = [[JBLineChartView alloc] init];
    self.lineChartView.delegate = self;
    self.lineChartView.dataSource = self;
    //lineChartView.headerView = headerView;
    
    self.lineChartView.frame = CGRectMake(0, 340, 320, 180);
    self.lineChartView.backgroundColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    [self.lineChartView reloadData];
    
    JBChartInformationView *test = [[JBChartInformationView alloc] initWithFrame:CGRectMake(0, 320, 320, 20)];
    [test setBackgroundColor:[UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1]];
    [self.view addSubview:test];
    
    self.informationView = [[UILabel alloc]initWithFrame:CGRectMake(0,315,320,60)];
    [self.informationView setBackgroundColor:[UIColor clearColor]];
    [self.informationView setTextAlignment:NSTextAlignmentCenter];
    [self.informationView setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30]];
    [self.informationView setTextColor:[UIColor whiteColor]];
    [self.view addSubview:self.lineChartView];
    [self.view addSubview:self.informationView];
    
    
    CGRect frame = CGRectMake(self.prog.frame.origin.x+40-4, 204, 50, 50);
    AMBCircularButton *btn = [[AMBCircularButton alloc] initWithFrame:frame];
    [btn setCircularImage:[UIImage imageNamed:@"fbook.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    
    CGRect frame2 = CGRectMake(self.prog.frame.origin.x+120-4,204,50,50);
    AMBCircularButton *btn2 = [[AMBCircularButton alloc] initWithFrame:frame2];
    [btn2 setCircularImage:[UIImage imageNamed:@"messages.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    
    CGRect frame3 = CGRectMake(self.prog.frame.origin.x+200-4,204, 50, 50);
    AMBCircularButton *btn3= [[AMBCircularButton alloc] initWithFrame:frame3];
    [btn3 setCircularImage:[UIImage imageNamed:@"hangout.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
   
    
    [btn addTarget:self action:@selector(buttonPressedyea:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(hangout:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(text:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    
    if (self.prog.progress>0&&self.prog.progress<=.2){
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1_wall.png"]];
    }
    if (self.prog.progress>.2&&self.prog.progress<=.4){
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2_wall.png"]];
    }
    if (self.prog.progress>.4&&self.prog.progress<=.6){
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"4_wall.png"]];
    }
    if (self.prog.progress>.6&&self.prog.progress<=.8){
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"4_wall.png"]];
    }
    if (self.prog.progress>.8&&self.prog.progress<=1){
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"4_wall.png"]];
    }
    
*/
    // Do any additional setup after loading the view.
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:[NSString stringWithFormat:@"%@",self.facebookId]];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Friendships"];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query whereKey:@"Friend" equalTo:myNumber];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            for (PFObject *test in objects){
                
                self.dataArray  = [test objectForKey:@"history"];
                int min = [[self.dataArray valueForKeyPath:@"@min.intValue"] intValue];
                self.min = [NSNumber numberWithInt:min];
                [self.lineChartView reloadData];
                
            }}}];
}

- (void)prepareMessageView{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    self.messageView = controller;
    [controller setMessageComposeDelegate:self];
    if([MFMessageComposeViewController canSendText])
    {
        self.number = @"";
        NSMutableDictionary *contactInfoDict = [[NSMutableDictionary alloc]
                                                initWithObjects:@[@"", @"", @"", @"", @"", @"", @"", @"", @""]
                                                forKeys:@[@"firstName", @"lastName", @"mobileNumber", @"homeNumber", @"homeEmail", @"workEmail", @"address", @"zipCode", @"city"]];
        
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBookRef );
        CFIndex nPeople = ABAddressBookGetPersonCount( addressBookRef );
        
        for ( int i = 0; i < nPeople;  )
        {
            ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
            CFTypeRef generalCFObject = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
            if ((__bridge NSString *)generalCFObject!=nil) {
                [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"firstName"];
                CFRelease(generalCFObject);
            }
            
            CFTypeRef lastname = ABRecordCopyValue(ref, kABPersonLastNameProperty);
            if ((__bridge NSString *)lastname!=nil) {
                [contactInfoDict setObject:(__bridge NSString *)lastname forKey:@"lastName"];
                CFRelease(lastname);
            }
            
            
            ABMultiValueRef phonesRef = ABRecordCopyValue(ref, kABPersonPhoneProperty);
            for (int i=0; i<ABMultiValueGetCount(phonesRef); i++) {
                CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
                CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
                
                if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                    [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"mobileNumber"];
                }
                
                
                if (CFStringCompare(currentPhoneLabel, kABPersonPhoneIPhoneLabel, 0) == kCFCompareEqualTo) {
                    [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"mobileNumber"];
                }
                
                CFRelease(currentPhoneLabel);
                CFRelease(currentPhoneValue);
            }
            CFRelease(phonesRef);
            
            
            if ([self.firstname isEqualToString:contactInfoDict[@"firstName"]] && [self.lastname isEqualToString:contactInfoDict[@"lastName"]]){
                NSLog(@"Match");
                self.number= contactInfoDict[@"mobileNumber"];
              
                
            }
            i++;
            if (i==nPeople) {
                controller.body = [NSString stringWithFormat:@"Hey %@!",self.firstname];
                if ([self.number isEqualToString:@""]) {
                    controller.recipients = [NSArray arrayWithObjects:nil];
                }else{
                    controller.recipients = [NSArray arrayWithObjects:self.number,nil];
                }
                controller.messageComposeDelegate = self;
                
            }
        }
        
        
        
    }
    


}

- (void)text:(UIButton *)senderswag{
        [self prepareMessageView];
        [self presentViewController:self.messageView animated:NO completion:nil];
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            
            [self performSelector:@selector(hangout:) withObject:nil];
            
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor whiteColor];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return 2; // width of line in chart
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
    return JBLineChartViewLineStyleSolid; // style of line in chart
}

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return 1; // number of lines in chart
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return [self.dataArray count];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    int test =[[self.dataArray objectAtIndex:horizontalIndex] intValue];
    float returntest = ((test-[self.min intValue])*.01);
    
    return returntest;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint
{
    
    NSLog(@"%lu",(unsigned long)horizontalIndex);
    NSNumber *valueNumber = [self.dataArray objectAtIndex:horizontalIndex];
    [self.informationView setText:[NSString stringWithFormat:@"%d", [valueNumber intValue]]];
    
    /*
    [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
    [self.tooltipView setText:[[self.daysOfWeek objectAtIndex:horizontalIndex] uppercaseString]];d
    */
     // Update view
}

- (void)didUnselectLineInLineChartView:(JBLineChartView *)lineChartView
{
    [self.informationView setText:@""];
    
    
}



- (IBAction)backarrow:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];

}

- (void)hangout:(UIButton *)senderswag {
    NSNumber *newScore;
    if (self.prog.progress >= .9) {
        self.stoppoint = [NSNumber numberWithFloat:1];
        MyManager *sharedManager = [MyManager sharedManager];
        newScore = [NSNumber numberWithFloat:100];
        [sharedManager.score setObject:newScore atIndexedSubscript:[sharedManager.cur_friend_id indexOfObject:self.facebookId]];
        
        
        
        
    }else{
        self.stoppoint = [NSNumber numberWithFloat:self.prog.progress +.1];
        MyManager *sharedManager = [MyManager sharedManager];
        newScore = [NSNumber numberWithFloat:(self.prog.progress + .1) *100];
        [sharedManager.score setObject:newScore atIndexedSubscript:[sharedManager.cur_friend_id indexOfObject:self.facebookId]];
        
        
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:YES];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Friendships"];
    [query whereKey:@"Friend" equalTo:[NSNumber numberWithLongLong:[self.facebookId longLongValue]]];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    NSLog(@"%@",[NSNumber numberWithLongLong:[self.facebookId longLongValue]]);
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
        if (!error) {
            // Found UserStats
            [userStats setObject:newScore forKey:@"Score"];
            
            // Save
            [userStats saveInBackground];
        } else {
            // Did not find any UserStats for the current user
            NSLog(@"Error: %@", error);
        }
    }];


}
- (void)buttonPressedyea:(UIButton *)senderswag {
    
    NSString *fid = [NSString stringWithFormat:@"%@", self.facebookId];
    
   
    
    NSMutableDictionary *params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
     fid,@"to",
     nil];
    
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (result==FBWebDialogResultDialogCompleted) {
                                                      
                                                      if([[resultURL absoluteString] length]> 20){
                                                          NSLog(@"YES! YOU GET POINTS!");
                                                          NSNumber *newScore;
                                                          if (self.prog.progress >= .9) {
                                                              self.stoppoint = [NSNumber numberWithFloat:1];
                                                              MyManager *sharedManager = [MyManager sharedManager];
                                                              newScore = [NSNumber numberWithFloat:100];
                                                              [sharedManager.score setObject:newScore atIndexedSubscript:[sharedManager.cur_friend_id indexOfObject:self.facebookId]];
                                                              
                                                              
                                                              
                                                              
                                                          }else{
                                                              self.stoppoint = [NSNumber numberWithFloat:self.prog.progress +.1];
                                                              MyManager *sharedManager = [MyManager sharedManager];
                                                              newScore = [NSNumber numberWithFloat:(self.prog.progress + .1) *100];
                                                              [sharedManager.score setObject:newScore atIndexedSubscript:[sharedManager.cur_friend_id indexOfObject:self.facebookId]];
                                                              
                                                              
                                                          }
                                                          [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                                           target:self
                                                                                         selector:@selector(targetMethod:)
                                                                                         userInfo:nil
                                                                                          repeats:YES];
                                                          
                                                          PFQuery *query = [PFQuery queryWithClassName:@"Friendships"];
                                                          [query whereKey:@"Friend" equalTo:[NSNumber numberWithLongLong:[self.facebookId longLongValue]]];
                                                          
                                                          [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
                                                          NSLog(@"%@",[NSNumber numberWithLongLong:[self.facebookId longLongValue]]);
                                                          [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
                                                              if (!error) {
                                                                  // Found UserStats
                                                                  [userStats setObject:newScore forKey:@"Score"];
                                                                  
                                                                  // Save
                                                                  [userStats saveInBackground];
                                                              } else {
                                                                  // Did not find any UserStats for the current user
                                                                  NSLog(@"Error: %@", error);
                                                              }
                                                          }];
                                                          
                                                      }
                                                      else{
                                                        //Didnt actually send
                                                      }
                                                  }else{
                                                      NSLog(@"didnt go through");
                                                  }
                                              }
     ];
    
}

- (void) targetMethod:(NSTimer *)timer{
    
    self.prog.progress = self.prog.progress+.005;
    if (self.prog.progress>[self.stoppoint floatValue]) {
        [timer invalidate];
    }
    float R=255 - (255*self.prog.progress*100)/100;
    float G=255 - (255*(100-self.prog.progress*100))/100;
    float B=20;
    R=R/100;
    G=G/100;
    B=B/100;
    
    self.prog.gradientColors = @[[UIColor colorWithRed:R green:G blue:B alpha:1.0],
                                 [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    
    self.friendometer_label.text = [NSString stringWithFormat:@"%.d", [[NSNumber numberWithFloat:self.prog.progress*100] intValue]];
    
    
}
@end
