//
//  RMUCommentField.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/25/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUCommentField.h"

@implementation RMUCommentField

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
        [self.layer setCornerRadius:6.0f];
        self.layer.masksToBounds = YES;
        [self.layer setBorderColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor];
        [self.layer setBorderWidth:0.5f];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 5.0f, 5.0f);
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
