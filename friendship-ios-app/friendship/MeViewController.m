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
#import "AMBCircularButton.h"
#import "FriendshipViewController.h"



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

-(void)viewDidAppear:(BOOL)animated{
    MyManager *sharedManager = [MyManager sharedManager];
    self.friendometer_label.text = [NSString stringWithFormat:@"%.d", [[sharedManager.score valueForKeyPath:@"@avg.self"] intValue] ];
    //NSLog(@"%@",self.friendometer_label.text);
    self.prog.progress = [[sharedManager.score valueForKeyPath:@"@avg.self"] floatValue]/100;
    float R=255 - (255*self.prog.progress *100)/100;
    float G=255 - (255*(100-self.prog.progress*100))/100;
    float B=20;
    R=R/100;
    G=G/100;
    B=B/100;
    
    
    
    
    
    self.prog.gradientColors = @[[UIColor colorWithRed:R green:G blue:B alpha:1.0],
                                 [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    if ([self.friendometer_label.text isEqual:@""]){
        self.friendometer_label.text=@"0";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    [self.tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Thin" size:21.0]};
    
        
    self.settings.tintColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    
    if (self.view.bounds.size.height == 568) {
        self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, self.profile_picture.frame.origin.y+self.profile_picture.frame.size.height+10, 280, 50)];
    } else {
        self.prog = [[AMGProgressView alloc] initWithFrame:CGRectMake(20, 245, 280, 50)];
    }
    
    CGRect frame = CGRectMake(38, 345, 85, 85);
    self.bestimage = [[AMBCircularButton alloc] initWithFrame:frame];
    [self.view addSubview:self.bestimage];
    
    CGRect frame2 = CGRectMake(198,345,85,85);
    self.worstimage = [[AMBCircularButton alloc] initWithFrame:frame2];
    [self.view addSubview:self.worstimage];
    
    [self.bestimage addTarget:self action:@selector(bestclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.worstimage addTarget:self action:@selector(worstclick:) forControlEvents:UIControlEventTouchUpInside];
    
    MyManager *sharedManager = [MyManager sharedManager];
    if (sharedManager.advice[3]!=nil) {
        self.worstFriend.text = [NSString stringWithFormat:@"%@",sharedManager.advice[0]];
        self.bestFriend.text = [NSString stringWithFormat:@"%@",sharedManager.advice[2]];
        [self.bestimage setCircularImage:sharedManager.advice[3] forState:UIControlStateNormal];
        [self.worstimage setCircularImage:sharedManager.advice[1] forState:UIControlStateNormal];

    }
    
    /*
    self.friendometer_label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.prog.frame.origin.y-50, 320, 40)];
    

    self.friendometer_label.text = [NSString stringWithFormat:@"FriendOMeter:  %d", [[sharedManager.score valueForKeyPath:@"@avg.self"] intValue] ];
    [self.friendometer_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    //[friendometer_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    self.friendometer_label.textAlignment = NSTextAlignmentCenter;
    */
     /*
    UILabel *number_label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.prog.frame.origin.y+50, 320, 50)];

    number_label.text = [NSString stringWithFormat:@"%.02f", [[sharedManager.score valueForKeyPath:@"@avg.self"] floatValue]];
    number_label.textAlignment = NSTextAlignmentCenter;
    */
   // [self.view addSubview:self.friendometer_label];
    
    self.prog.progress = [[sharedManager.score valueForKeyPath:@"@avg.self"] floatValue]/100;
    float R=255 - (255*self.prog.progress *100)/100;
    float G=255 - (255*(100-self.prog.progress*100))/100;
    float B=20;
    R=R/100;
    G=G/100;
    B=B/100;
    
    
    
    
    
    self.prog.gradientColors = @[[UIColor colorWithRed:R green:G blue:B alpha:1.0],
                                 [UIColor colorWithRed:0.6f green:0.9f blue:0.6f alpha:1.0f]];
    
    
    
    
    self.prog.progress = [[sharedManager.score valueForKeyPath:@"@avg.self"] floatValue]/100;
  
    
    
    
    
    [self.view addSubview:self.prog];
    CALayer *roundtest = [self.prog layer];
    [roundtest setMasksToBounds:YES];
    [roundtest setCornerRadius:10.0];
    
    UILabel *scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, self.prog.frame.origin.y, 60, 50)];
    scoreLabel.text = [NSString stringWithFormat:@"%.d", [[sharedManager.score valueForKeyPath:@"@avg.self"] intValue] ];
    if ([scoreLabel.text isEqual:@""]){
        scoreLabel.text=@"0";
    }
    scoreLabel.textColor = [UIColor blackColor];
    scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    //scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
    [self.view addSubview:scoreLabel];
    self.friendometer_label = scoreLabel;
    
    //[self.view addSubview:number_label];
    
    
    
    [profile_picture setContentMode:UIViewContentModeScaleAspectFill];
    
    CALayer *round = [profile_picture layer];
    [round setMasksToBounds:YES];
    [round setCornerRadius:62.5];
    
    
    
    
    
    
    
    [profile_picture setImage:sharedManager.meviewImage];
    self.navigationController.navigationBar.topItem.title=sharedManager.meviewName;
    
    
    
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
    /*
    JBLineChartView *lineChartView = [[JBLineChartView alloc] init];
    lineChartView.delegate = self;
    lineChartView.dataSource = self;
    //lineChartView.headerView = headerView;
    
    lineChartView.frame = CGRectMake(0, 320, 320, 200);
    [lineChartView reloadData];
    
    [self.view addSubview:lineChartView];
    lineChartView.backgroundColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    */
    
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

- (void)bestclick:(UIButton *)senderswag {
    MyManager *sharedManager = [MyManager sharedManager];
    NSUInteger fooIndex = [sharedManager.array3 indexOfObject: sharedManager.advice[2]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FriendshipViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"checkmeout"];
    
    vc.name = [sharedManager.array3 objectAtIndex:fooIndex];
    vc.score = [sharedManager.score objectAtIndex:fooIndex];
    vc.facebookId = [sharedManager.cur_friend_id objectAtIndex:fooIndex];
    vc.bigprofpic = [sharedManager.array4 objectAtIndex:fooIndex];
    
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (void)worstclick:(UIButton *)senderswag {
    MyManager *sharedManager = [MyManager sharedManager];
    NSUInteger fooIndex = [sharedManager.array3 indexOfObject: sharedManager.advice[0]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FriendshipViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"checkmeout"];
    
    vc.name = [sharedManager.array3 objectAtIndex:fooIndex];
    vc.score = [sharedManager.score objectAtIndex:fooIndex];
    vc.facebookId = [sharedManager.cur_friend_id objectAtIndex:fooIndex];
    vc.bigprofpic = [sharedManager.array4 objectAtIndex:fooIndex];
    
    [self.navigationController pushViewController:vc animated:NO];
}






@end
