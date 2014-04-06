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
    
    
    
    
    [self.tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    
    
    self.navigationController.navigationBar.topItem.title=self.name;
    /*[self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:21],
      NSFontAttributeName, nil]];
    */
    
    if (self.view.bounds.size.height == 568) {
        self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, self.profile_picture.frame.origin.y+self.profile_picture.frame.size.height+10, 280, 50)];
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
    scoreLabel.text = [[NSNumber numberWithFloat:self.prog.progress*100] stringValue];
    scoreLabel.textColor = [UIColor blackColor];
    scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
    [self.view addSubview:scoreLabel];
    self.friendometer_label = scoreLabel;

    JBLineChartView *lineChartView = [[JBLineChartView alloc] init];
    lineChartView.delegate = self;
    lineChartView.dataSource = self;
    //lineChartView.headerView = headerView;
    
    lineChartView.frame = CGRectMake(0, 320, 320, 200);
    lineChartView.backgroundColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    [lineChartView reloadData];
    
    [self.view addSubview:lineChartView];
    
    
    CGRect frame = CGRectMake(self.prog.frame.origin.x+10, self.prog.frame.origin.y+self.prog.frame.size.height+10, 80, 40);
    BButton *btn = [[BButton alloc] initWithFrame:frame type:BButtonTypeFacebook style:BButtonStyleBootstrapV3];
    [btn setTitle:@"Message" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    CALayer *ummm = [btn layer];
    [ummm setMasksToBounds:YES];
    [ummm setCornerRadius:10.0];
    
    CGRect frame2 = CGRectMake(self.prog.frame.origin.x+10+90, self.prog.frame.origin.y+self.prog.frame.size.height+10, 80, 40);
    BButton *btn2 = [[BButton alloc] initWithFrame:frame2 type:BButtonTypeSuccess style:BButtonStyleBootstrapV3];
    [btn2 setTitle:@"Call" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    CALayer *ummm2 = [btn2 layer];
    [ummm2 setMasksToBounds:YES];
    [ummm2 setCornerRadius:10.0];
    
    CGRect frame3 = CGRectMake(self.prog.frame.origin.x+180+10, self.prog.frame.origin.y+self.prog.frame.size.height+10, 80, 40);
    BButton *btn3 = [[BButton alloc] initWithFrame:frame3 type:BButtonTypeDanger style:BButtonStyleBootstrapV3];
    [btn3 setTitle:@"Hang Out" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    CALayer *ummm3 = [btn3 layer];
    [ummm3 setMasksToBounds:YES];
    [ummm3 setCornerRadius:10.0];
    
    [btn addTarget:self action:@selector(buttonPressedyea:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(hangout:) forControlEvents:UIControlEventTouchUpInside];
    
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
    return 10; // number of values for a line
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    if (horizontalIndex%2){
        return horizontalIndex;
    }else{
        return 10-horizontalIndex;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint
{
    NSLog(@"%lu",(unsigned long)horizontalIndex);
    // Update view
}

- (void)didUnselectLineInLineChartView:(JBLineChartView *)lineChartView
{
    // Update view
}



- (IBAction)backarrow:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];

}

- (void)hangout:(UIButton *)senderswag {
    NSNumber *newScore;
    if (self.prog.progress > 90) {
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
                                                          if (self.prog.progress > 90) {
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
