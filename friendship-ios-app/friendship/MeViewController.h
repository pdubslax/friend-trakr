//
//  MeViewController.h
//  ParseStarterProject
//
//  Created by Patrick Wilson on 1/18/14.
//
//

#import <UIKit/UIKit.h>
#import "JBLineChartView.h"

@interface MeViewController : UIViewController <JBLineChartViewDataSource,JBLineChartViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *profile_picture;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settings;
@property (strong,nonatomic) UILabel  *friendometer_label;
- (IBAction)settings_button:(id)sender;
@end
