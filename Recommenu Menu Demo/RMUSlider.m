//
//  RMUSlider.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUSlider.h"

#define HEIGHT_OF_SLIDER 15.0f

@interface RMUSlider()

@property CGFloat sliderHeight;

@end

@implementation RMUSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor =[UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.borderColor =[UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.sliderHeight = HEIGHT_OF_SLIDER;
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        [[UIColor RMUBlueChill] setFill];
        UIRectFill(rect);
        [self setThumbImage:[[UIImage alloc]init] forState:UIControlStateNormal];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setMinimumTrackImage:image forState:UIControlStateNormal];
        [self setMaximumTrackTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    CGRect result = [super trackRectForBounds:bounds];
    result.size.height = self.sliderHeight;
    result.origin.x -= 2.0f;
    result.size.width += 2.0f;
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
