//
//  MyManger.h
//  friendship
//
//  Created by Patrick Wilson on 1/19/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject {
    NSMutableArray *array;
}

@property (nonatomic, retain) NSMutableArray *array;

+ (id)sharedManager;

@end
