//
//  RMUStarView.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/23/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUStarView.h"

@implementation RMUStarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)fillInNumberOfStarsWithNumberOfHalfStars:(NSInteger) numberOfHalfStars
{
    for (UIView *subview in self.subviews) {
        UIImageView *imageView = (UIImageView*)subview;
        if (subview.tag <= numberOfHalfStars / 2) {
            if ((numberOfHalfStars % 2 == 1) && (subview.tag == numberOfHalfStars / 2 + 1)) {
                // Make it a half star
            }
            else {
                // Make it a full star
                imageView.image = [UIImage imageNamed:@"little27y"];
            }
        }
        else {
            // Blank star
            imageView.image = [UIImage imageNamed:@"little27g"];

        }
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
