//
//  SelectStartViewController.m
//  friendship
//
//  Created by Patrick Wilson on 4/6/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "SelectStartViewController.h"
#import "GRKGradientView.h"
#import "BButton.h"
#import "MyManger.h"
#import "AddFriendViewController.h"
#import "blueButton.h"

@interface SelectStartViewController ()
@property (nonatomic,strong) GRKGradientView *upGradient;
@property (nonatomic,strong) UISlider *slideme;


@end

@implementation SelectStartViewController
@synthesize slideme;

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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1]};
    self.navigationController.navigationBar.topItem.title = @"Select Current Friendship Level";
    
    
    slideme = [[UISlider alloc] initWithFrame:CGRectMake(10,265,300,40)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [slideme setBackgroundColor:[UIColor clearColor]];
    
    [slideme setValue:0.5f];
    [slideme setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slideme setMaximumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slideme addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
    UIImage *guy = [UIImage imageNamed:@"smiley-smile.png"];
    
    self.upGradient = [[GRKGradientView alloc]initWithFrame:CGRectMake(0, 20, 320, 700)];
    self.upGradient.gradientColors = [NSArray arrayWithObjects: [UIColor colorWithRed:1.27 green:1.27 blue:0 alpha:1.0],[UIColor whiteColor], nil];


    //[self.view setBackgroundColor:[slideme tintColor]];
    [self.view addSubview:self.upGradient];
    [self.view addSubview:slideme];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2+M_PI);
    slideme.transform = trans;
    
    
    
    [slideme setThumbImage:guy forState:UIControlStateNormal];
    
    UILabel *bestfriends = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 50)];
    [bestfriends setText:@"Best Friends"];
    [bestfriends setFont:[UIFont boldSystemFontOfSize:25.0f]];
    [bestfriends setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:bestfriends];
    
   
    
    CGRect frame = CGRectMake(-10, self.view.frame.size.height-60, 340, 60);
    blueButton *btn = [[blueButton alloc] initWithFrame:frame] ;
    btn.backgroundColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
   
    [btn setTitle:@"Submit" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(buttonPressedyea:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *worstfriends = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y-70, 320, 50)];
    [worstfriends setText:@"Worst Enemies"];
    [worstfriends setFont:[UIFont boldSystemFontOfSize:25.0f]];
    [worstfriends setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:worstfriends];

    
}

- (void)buttonPressedyea:(UIButton *)senderswag {
    
    float steez = (float)[slideme value];
    NSNumber *score = [NSNumber numberWithInt:(int)(steez*100)];
    
    self.thisistheone[@"Score"]=score;
    
    [self.thisistheone saveInBackground];
    
    [self.manger.score addObject:score];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.afvc shesgone];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sliderMoved:(id)sender {
    
    UISlider *slider = (UISlider *)sender;
    NSLog(@"SliderValue ... %f",(float)[slider value]);
    float test = 100-(float)([slider value]*100);
    
    float R=(255*test)/100;
    float G=(255*(100-test))/100;
    float B=0;
    R=R/100;
    G=G/100;
    B=B/100;
    
    self.upGradient.gradientColors = [NSArray arrayWithObjects: [UIColor colorWithRed:R green:G blue:B alpha:1.0],[UIColor whiteColor], nil];
    
    
    
    
}
@end