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
@property (nonatomic,retain) NSMutableArray *friend_id_array;
@property (nonatomic,retain) NSMutableArray *my_id_array;



@property (nonatomic,retain) NSMutableArray *array3;
@property (nonatomic,retain) NSMutableArray *array4;
@property (nonatomic,retain) NSMutableArray *score;
@property (nonatomic,retain) NSMutableArray *cur_friend_id;

@property (nonatomic,retain) NSString *meviewName;
@property (nonatomic,retain) UIImage *meviewImage;

@property (nonatomic,retain) NSNumber *avgScore;


+ (id)sharedManager;
- (void) reset;

@end
