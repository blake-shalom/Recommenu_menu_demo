//
//  RMUSlider.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUSlider.h"

#define HEIGHT_OF_SLIDER 20.0f

@implementation RMUSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    CGRect result = [super trackRectForBounds:bounds];
    result.size.height = HEIGHT_OF_SLIDER;
    return result;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
    result.size.width = 16.0f;
    return result;
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
