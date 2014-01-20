//
//  MyManger.h
//  friendship
//
//  Created by Patrick Wilson on 1/19/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject

@property (nonatomic, retain) NSMutableArray *array1;
@property (nonatomic,retain) NSMutableArray *array2;
@property (nonatomic,retain) NSMutableArray *array3;
@property (nonatomic,retain) NSMutableArray *array4;
@property (nonatomic,retain) NSMutableArray *score;


+ (id)sharedManager;
- (void) reset;

@end
