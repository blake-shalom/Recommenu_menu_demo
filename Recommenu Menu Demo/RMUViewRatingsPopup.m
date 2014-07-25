//
//  RMUViewRatingsPopup.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/23/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUViewRatingsPopup.h"

@interface RMUViewRatingsPopup()

@property (weak,nonatomic) IBOutlet UITableView *ratingsTable;
@property (weak,nonatomic) IBOutlet UILabel *popupTitle;
@property (weak,nonatomic) IBOutlet UIButton *mostRecentButton;
@property (weak,nonatomic) IBOutlet UIButton *highestRatedButton;


@end

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

- (IBAction)mostRecentSelected:(id)sender
{
    [self.mostRecentButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [self.mostRecentButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [self.highestRatedButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.highestRatedButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
}

- (IBAction)highestRatedSelected:(id)sender
{
    [self.highestRatedButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [self.highestRatedButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [self.mostRecentButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.mostRecentButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
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
