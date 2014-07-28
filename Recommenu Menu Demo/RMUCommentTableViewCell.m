//
//  RMUCommentTableViewCell.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/28/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUCommentTableViewCell.h"

@implementation RMUCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.isDownvotePressed = NO;
        self.isUpvotePressed = NO;
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.isDownvotePressed = NO;
        self.isUpvotePressed = NO;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)upvoteTouched:(id)sender
{
    if (!self.isUpvotePressed && !self.isDownvotePressed) {
        [self.upButtonImage setImage:[UIImage imageNamed:@"up5g"]];
        self.isUpvotePressed = YES;
    }
    else if (self.isUpvotePressed && !self.isDownvotePressed) {
        [self.upButtonImage setImage:[UIImage imageNamed:@"up5"]];
        self.isUpvotePressed = NO;
    }
}


- (IBAction)downvoteTouched:(id)sender
{
    if (!self.isUpvotePressed && !self.isDownvotePressed) {
        [self.downButtonImage setImage:[UIImage imageNamed:@"down5r"]];
        self.isDownvotePressed = YES;
    }
    else if (!self.isUpvotePressed && self.isDownvotePressed) {
        [self.downButtonImage setImage:[UIImage imageNamed:@"down5"]];
        self.isDownvotePressed = NO;
    }
}

@end
