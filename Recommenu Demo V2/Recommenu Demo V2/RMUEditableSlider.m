//
//  RMUEditableSlider.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/28/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUEditableSlider.h"

@implementation RMUEditableSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setThumbImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return [super trackRectForBounds:bounds];
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
