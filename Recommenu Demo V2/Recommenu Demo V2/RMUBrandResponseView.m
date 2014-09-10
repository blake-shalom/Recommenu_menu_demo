//
//  RMUBrandResponseView.m
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 9/9/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//


#import "RMUBrandResponseView.h"

@implementation RMUBrandResponseView

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
        self.layer.cornerRadius = 5.0f;
        [self setBackgroundColor:[UIColor RMUWhiteSmoke]];
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor RMUZircon].CGColor;
        self.layer.borderWidth = 1.0f;
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
