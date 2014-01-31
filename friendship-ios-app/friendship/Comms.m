//
//  Comms.m
//  FBParse
//
//  Created by Toby Stephens on 14/07/2013.
//  Copyright (c) 2013 Toby Stephens. All rights reserved.
//

#import "Comms.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@implementation Comms

+ (void) login:(id<CommsDelegate>)delegate
{
	// Basic User information and your friends are part of the standard permissions
	// so there is no reason to ask for additional permissions
	[PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
		// Was login successful ?
		if (!user) {
			if (!error) {
				NSLog(@"The user cancelled the Facebook login.");
			} else {
				NSLog(@"An error occurred: %@", error.localizedDescription);
			}
			
			// Callback - login failed
			if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
				[delegate commsDidLogin:NO];
			}
		} else {
			if (user.isNew) {
				NSLog(@"User signed up and logged in through Facebook!");
			} else {
				NSLog(@"User logged in through Facebook!");
			}
			
			[FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
				if (!error) {
					NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
					// Store the Facebook Id
					[[PFUser currentUser] setObject:me.id forKey:@"fbId"];
					[[PFUser currentUser] saveInBackground];
				}
				
				// Callback - login successful
				if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
					[delegate commsDidLogin:YES];
				}
			}];
		}
	}];
}

@end
