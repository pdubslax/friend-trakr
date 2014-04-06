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
    
    slideme = [[UISlider alloc] initWithFrame:CGRectMake(-40.0,260,400,40)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [slideme setBackgroundColor:[UIColor clearColor]];
    
    [slideme setValue:0.5f];
    [slideme setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slideme setMaximumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slideme addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];
    UIImage *guy = [UIImage imageNamed:@"smiley-smile.png"];
    
    self.upGradient = [[GRKGradientView alloc]initWithFrame:CGRectMake(0, 0, 320, 700)];
    self.upGradient.gradientColors = [NSArray arrayWithObjects: [UIColor colorWithRed:1.27 green:1.27 blue:0 alpha:1.0],[UIColor whiteColor], nil];


    //[self.view setBackgroundColor:[slideme tintColor]];
    [self.view addSubview:self.upGradient];
    [self.view addSubview:slideme];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2+M_PI);
    slideme.transform = trans;
    
    
    
    [slideme setThumbImage:guy forState:UIControlStateNormal];
    
    UILabel *bestfriends = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
    [bestfriends setText:@"Best Friends"];
    [bestfriends setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:bestfriends];
    
    UILabel *worstfriends = [[UILabel alloc] initWithFrame:CGRectMake(0, 480, 320, 50)];
    [worstfriends setText:@"Worst Enemies"];
    [worstfriends setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:worstfriends];
    
    CGRect frame = CGRectMake(0,520,320,50);
    BButton *btn = [[BButton alloc] initWithFrame:frame type:BButtonTypeDanger style:BButtonStyleBootstrapV3];
    [btn setTitle:@"Submit" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(buttonPressedyea:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
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