//
//  MyManger.m
//  friendship
//
//  Created by Patrick Wilson on 1/19/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "MyManger.h"

@implementation MyManager

@synthesize array;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
