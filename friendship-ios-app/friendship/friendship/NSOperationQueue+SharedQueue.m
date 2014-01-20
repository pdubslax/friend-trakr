//
//  NSOperationQueue+SharedQueue.m
//  friendship
//
//  Created by Patrick Wilson on 1/19/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "NSOperationQueue+SharedQueue.h"

@implementation NSOperationQueue (SharedQueue)

+ (NSOperationQueue *) pffileOperationQueue {
	static NSOperationQueue *pffileQueue = nil;
	if (pffileQueue == nil) {
		pffileQueue = [[NSOperationQueue alloc] init];
		[pffileQueue setName:@"com.rwtutorial.pffilequeue"];
	}
	return pffileQueue;
}

@end

