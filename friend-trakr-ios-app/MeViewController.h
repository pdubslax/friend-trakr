//
//  MeViewController.h
//  ParseStarterProject
//
//  Created by Patrick Wilson on 1/18/14.
//
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *profile_picture;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settings;
- (IBAction)settings_button:(id)sender;
@end
