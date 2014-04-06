//
//  blueButton.m
//  friendship
//
//  Created by Patrick Wilson on 4/6/14.
//  Copyright (c) 2014 Patrick Wilson. All rights reserved.
//

#import "blueButton.h"

@implementation blueButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        UIColor * color = [UIColor colorWithRed:52/255.0f green:73/255.0f blue:94/255.0f alpha:1.0f];
        self.backgroundColor = color;
    }
    else {
        self.backgroundColor = [UIColor colorWithRed:0.122 green:0.149 blue:0.232 alpha:1];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
