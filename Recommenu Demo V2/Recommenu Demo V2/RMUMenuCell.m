//
//  RMUMenuCell.m
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUMenuCell.h"

@implementation RMUMenuCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    [self.numReviewsLabel setTextColor:[UIColor RMUGreenBlue]];
    [self.topCommentLabel setTextColor:[UIColor RMUGreenBlue]];
    [self.writeReviewButton setTitleColor:[UIColor RMUGreenBlue] forState:UIControlStateNormal];
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
