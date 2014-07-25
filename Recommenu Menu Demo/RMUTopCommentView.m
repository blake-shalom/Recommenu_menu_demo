//
//  RMUTopCommentView.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/25/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUTopCommentView.h"

@implementation RMUTopCommentView

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
        self.layer.cornerRadius = 6.0f;
        self.layer.borderColor = [UIColor RMUSpringWood].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.masksToBounds = YES;
    }
    return self;
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
