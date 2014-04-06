//
//  SelectStartViewController.m
//  friendship
//
//  Created by Patrick Wilson on 4/6/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "SelectStartViewController.h"

@interface SelectStartViewController ()

@end

@implementation SelectStartViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UISlider *slideme = [[UISlider alloc] initWithFrame:CGRectMake(0.0,240,320,40)];
    //[slideme setBackgroundColor:[UIColor blackColor]];
    
    [slideme setValue:0.5f];
    [slideme setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slideme setMaximumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slideme addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventValueChanged];

    //[self.view setBackgroundColor:[slideme tintColor]];
    [self.view addSubview:slideme];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2+M_PI);
    slideme.transform = trans;
    
    /*
    R=(255*n)/100
    G=(255*(100-n))/100;
    B=0
    */
    // Do any additional setup after loading the view.
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
    [self.view setBackgroundColor:[UIColor colorWithRed:R green:G blue:B alpha:1.0]];
    
}
@end