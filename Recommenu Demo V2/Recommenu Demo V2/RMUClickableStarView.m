//
//  RMUClickableStarView.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/24/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUClickableStarView.h"

@implementation RMUClickableStarView

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
        for (UIButton *button in self.subviews) {
            [button addTarget:self
                       action:@selector(addStarsWithObject:)
             forControlEvents:UIControlEventTouchUpInside];
        }
        // Initialization code
    }
    return self;
}

- (void)addStarsWithObject:(id)sender
{
    UIButton *starButton = (UIButton*)sender;
    [self fillInNumberOfStarsWithNumberOfHalfStars:(starButton.tag + 1) * 2];
    self.numStars = [NSNumber numberWithInt:starButton.tag + 1];
}

- (void)fillInNumberOfStarsWithNumberOfHalfStars:(NSInteger) numberOfHalfStars
{
    for (UIButton *button in self.subviews) {
        if (button.tag < numberOfHalfStars / 2) {
            // Make it a full star
            [button setBackgroundImage:[UIImage imageNamed:@"little27y"] forState:UIControlStateNormal];
        }
        else if (button.tag == numberOfHalfStars / 2) {
            if (numberOfHalfStars % 2 == 1) {
                [button setBackgroundImage:[UIImage imageNamed:@"halfstar"] forState:UIControlStateNormal];
            }
            else {
                [button setBackgroundImage:[UIImage imageNamed:@"little27g"] forState:UIControlStateNormal];
            }
        }
        else {
            // Blank star
            [button setBackgroundImage:[UIImage imageNamed:@"little27g"] forState:UIControlStateNormal];
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
