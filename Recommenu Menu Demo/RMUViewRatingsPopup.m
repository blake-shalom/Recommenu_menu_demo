//
//  RMUViewRatingsPopup.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/23/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUViewRatingsPopup.h"

@implementation RMUViewRatingsPopup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"ratingCell"];
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
