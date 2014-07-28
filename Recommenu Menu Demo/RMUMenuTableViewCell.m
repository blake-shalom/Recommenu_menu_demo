//
//  RMUMenuTableViewCell.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUMenuTableViewCell.h"

@implementation RMUMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;

        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.isTopCommentVisible = NO;
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)topCommentButtonPressed:(id)sender
{
    if (self.isTopCommentVisible){
        [self.topCommentView setHidden:YES];
    }
    else {
        [self.topCommentView setHidden:NO];
    }
    self.isTopCommentVisible = !self.isTopCommentVisible;
}

@end
