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
        // Initialization code
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

@end
