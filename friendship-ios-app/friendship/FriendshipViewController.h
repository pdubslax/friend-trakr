//
//  FriendshipViewController.h
//  friendship
//
//  Created by Patrick Wilson on 3/22/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBLineChartView.h"

@interface FriendshipViewController : UIViewController <JBLineChartViewDataSource,JBLineChartViewDelegate>

@property (retain,nonatomic) NSNumber *facebookId;
@property (retain,nonatomic) NSNumber *score;
@property (retain,nonatomic) NSString *name;
- (IBAction)backarrow:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *profile_picture;

@end
