//
//  FriendshipViewController.h
//  friendship
//
//  Created by Patrick Wilson on 3/22/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBLineChartView.h"
#import "AMGProgressView.h"

@interface FriendshipViewController : UIViewController <JBLineChartViewDataSource,JBLineChartViewDelegate>

@property (retain,nonatomic) NSNumber *facebookId;
@property (retain,nonatomic) NSNumber *score;
@property (retain,nonatomic) NSString *name;
@property (nonatomic, strong) AMGProgressView *prog;
@property (nonatomic,strong) UILabel *friendometer_label;
@property (nonatomic,strong) NSNumber *stoppoint;
- (IBAction)backarrow:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *profile_picture;
@property (strong,nonatomic) UIImage *bigprofpic;

@end
