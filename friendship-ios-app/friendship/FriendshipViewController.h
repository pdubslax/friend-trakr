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
#import <MessageUI/MessageUI.h>
#import "JBChartInformationView.h"

@interface FriendshipViewController : UIViewController <JBLineChartViewDataSource,JBLineChartViewDelegate,MFMessageComposeViewControllerDelegate>

@property (retain,nonatomic) NSNumber *facebookId;
@property (retain,nonatomic) NSNumber *score;
@property (retain,nonatomic) NSString *name;
@property (nonatomic, strong) AMGProgressView *prog;
@property (nonatomic,strong) UILabel *friendometer_label;
@property (nonatomic,strong) NSNumber *stoppoint;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *lastname;
@property (nonatomic,strong) NSString *number;
@property (nonatomic,strong, retain) MFMessageComposeViewController *messageView;
@property (nonatomic, strong) UILabel *informationView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) JBLineChartView *lineChartView;
@property (nonatomic,strong) NSNumber *min;
@property (nonatomic,strong) UILabel *friendsSince;



- (IBAction)backarrow:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *profile_picture;
@property (strong,nonatomic) UIImage *bigprofpic;

@end
