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
    if (self.reviewDictionary) {
        return [[self.reviewDictionary objectForKey:@"objects"] count];
    }
    else {
        return 0;
    }
}

- (void) findAllRatingsForMealID:(NSNumber*)mealID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/recommendations/"
      parameters:@{@"entry": mealID}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"SUCCESS with response %@", responseObject);
             self.reviewDictionary = responseObject;
             [self.ratingsTable reloadData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"FAILED with operation %@", operation.responseString);
         }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUCommentTableViewCell *cell = (RMUCommentTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"ratingCell"];
    cell.upvoteButton.tag = indexPath.row;
    cell.downvoteButton.tag = indexPath.row;
    NSDictionary *commentDict = [[self.reviewDictionary objectForKey:@"objects"]objectAtIndex:indexPath.row];
    [cell.commentLabel setText: [commentDict objectForKey:@"comment"]];
    [cell.nameLabel setText:@"Margaret G."];
    [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:10 - indexPath.row];
    [cell.topFoodSlider setValue:70.0f animated:YES];
    [cell.middleFoodSlider setValue:30.0f animated:YES];
    [cell.bottomFoodSlider setValue:50.0f animated:YES];

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
}

- (IBAction)downvoteRecommendation:(id)sender
{
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
