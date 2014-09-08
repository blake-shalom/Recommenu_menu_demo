//
//  RMUReviewsPopupView.m
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/25/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUReviewsPopupView.h"

@implementation RMUReviewsPopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - UITableView Delegate methods

/*
 *  Return number of rows
 */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.reviewDictionary) {
        return [[self.reviewDictionary objectForKey:@"objects"] count];
    }
    else {
        return 0;
    }
}

/*
 *  Cell For Row, loads data in cells
 */

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMURatingTableCell *reviewCell = (RMURatingTableCell*) [tableView dequeueReusableCellWithIdentifier:@"reviewCell"];
    NSDictionary *commentDict = [[self.reviewDictionary objectForKey:@"objects"]objectAtIndex:indexPath.row];
    NSNumber *commentID = [commentDict objectForKey:@"id"];
    reviewCell.agreeButton.tag = commentID.intValue;
    
    if ([commentDict objectForKey:@"score"] != (id) [NSNull null]) {
        NSNumber *numb = [commentDict objectForKey:@"score"];
        [reviewCell.agreeButton setTitle:[NSString stringWithFormat:(@"Yes! (%i agree)"), numb.intValue]
                                forState:UIControlStateNormal];
    }
    if ([commentDict objectForKey:@"comment"] != (id) [NSNull null])
        [reviewCell.reviewParagraph setText:[commentDict objectForKey:@"comment"]];
    if ([commentDict objectForKey:@"title"] != (id) [NSNull null])
        [reviewCell.reviewTitle setText:[commentDict objectForKey:@"title"]];
    if ([commentDict objectForKey:@"date_posted"] != (id) [NSNull null]) {
        NSString *dateString = [commentDict objectForKey:@"date_posted"];
        dateString = [dateString substringToIndex:10];
        dateString = [dateString stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        [reviewCell.reviewDate setText:dateString];
    }
    if ([commentDict objectForKey:@"nickname"] != (id) [NSNull null])
        [reviewCell.reviewName setText:[commentDict objectForKey:@"nickname"]];
    //Handle Sliders
    NSArray *sliders = [commentDict objectForKey:@"sliders"];
    if (sliders.count > 0){
        for (int i = 0; i < sliders.count; i++) {
            NSNumber *score = [sliders[i] objectForKey:@"score"];
            RMUSlider *currSlider = (RMUSlider*) [reviewCell viewWithTag:i + 5];
            UILabel *currLabel = (UILabel*) [reviewCell viewWithTag:i + 8];
            [currSlider setValue:score.floatValue];
            [currLabel setText:[sliders[i] objectForKey:@"category"]];
        }
    }
    NSNumber *numberStars = [commentDict objectForKey:@"stars"];
    if (numberStars != (id) [NSNull null])
        [reviewCell.starView fillInNumberOfStarsWithNumberOfHalfStars:numberStars.integerValue * 2];
    return reviewCell;
}

#pragma mark - Networking

/*
 *  GET Reviews call that will load all reviews for a given entree
 */

-(void)loadAllReviewsWithEntreeID:(NSNumber*)entreeID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/recommendations/"
      parameters:@{@"entry": entreeID}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"SUCCESS with response %@", responseObject);
             self.reviewDictionary = responseObject;
             [self.reviewsTable reloadData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"FAILED with operation %@", operation.responseString);
         }];
}

#pragma mark - Interactivity

/*
 *  Dismisses popup
 */

-(IBAction)dismissReviewPopup:(id)sender
{
    [self.delegate reviewPopupWillDismiss];
}

/*
 *  Yes pressed and networking is carried out, number updated
 */

-(IBAction)upvoteComment:(UIButton *)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *comment = [self findCommentForID:[NSNumber numberWithInt:sender.tag]];
    NSNumber *score  = [comment objectForKey:@"score"];
    score = [NSNumber numberWithInt:score.intValue + 1];
    [manager PUT:[NSString stringWithFormat:(@"http://tranquil-plateau-8131.herokuapp.com/api/v1/recommendations/%i/"), sender.tag ]
      parameters:@{@"score": score}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"SUCCESS with response %@", responseObject);
             [sender setTitle:[NSString stringWithFormat:(@"Yes! (%i agree)"), score.intValue]
                                     forState:UIControlStateNormal];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"FAILED with operation %@", operation.responseString);
         }];
}

#pragma mark - Miscellaneous

/*
 *  Finds a particular entree for a given id
 */

-(NSDictionary*)findCommentForID:(NSNumber*)commentID
{
    NSArray *commentArray = [self.reviewDictionary objectForKey:@"objects"];
    for (NSDictionary *comment in commentArray)
        if ([comment objectForKey:@"id"] == commentID)
            return comment;
    return nil;
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
