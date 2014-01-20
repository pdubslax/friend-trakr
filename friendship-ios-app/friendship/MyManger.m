//
//  MyManger.m
//  friendship
//
//  Created by Patrick Wilson on 1/19/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "MyManger.h"

@implementation MyManager

@synthesize array1,array2,array3,array4,score;

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
        array1 = [[NSMutableArray alloc] init];
        array2 = [[NSMutableArray alloc] init];
        array3 = [[NSMutableArray alloc] init];
        array4 = [[NSMutableArray alloc] init];
        score = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void) reset
{
    [array1 removeAllObjects];
    [array2 removeAllObjects];
    [array3 removeAllObjects];
    [array4 removeAllObjects];
    [score removeAllObjects];
}

@end
