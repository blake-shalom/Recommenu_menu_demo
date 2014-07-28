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
@property (weak,nonatomic) IBOutlet UIView *contentView;

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.layer.cornerRadius = 6.0f;
    self.contentView.layer.masksToBounds = YES;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUCommentTableViewCell *cell = (RMUCommentTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"ratingCell"];
    cell.upvoteButton.tag = indexPath.row;
    cell.downvoteButton.tag = indexPath.row;
    [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:indexPath.row];
    NSLog(@"%@", indexPath);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0f;
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

- (IBAction)upvoteRecommendation:(id)sender
{
//    UIButton *upButton = (UIButton*)sender;
//    NSIndexPath *upvotedIndex = [NSIndexPath indexPathForRow:upButton.tag inSection:0];
//    RMUCommentTableViewCell *upCell = (RMUCommentTableViewCell*) [self tableView:self.ratingsTable cellForRowAtIndexPath:upvotedIndex];
//    [upCell.upButtonImage setImage:[UIImage imageNamed:@"up5g"]];
}

- (IBAction)downvoteRecommendation:(id)sender
{
    NSLog(@"DOWNVOTING BATCH");

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
