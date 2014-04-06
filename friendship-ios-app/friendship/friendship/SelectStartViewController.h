//
//  SelectStartViewController.h
//  friendship
//
//  Created by Patrick Wilson on 4/6/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MyManger.h"
#import "AddFriendViewController.h"

@interface SelectStartViewController : UIViewController
@property (nonatomic,strong) PFObject *thisistheone;
@property (nonatomic,strong) MyManager *manger;
@property (strong,nonatomic) AddFriendViewController *afvc;
@property (strong,nonatomic) NSNumber *facebookid;


@end
