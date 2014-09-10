//
//  RMUSubmitReviewView.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/24/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUSubmitReviewView.h"

@implementation RMUSubmitReviewView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.visibleView.layer setCornerRadius:6.0f];
    self.visibleView.layer.masksToBounds = YES;
}

#pragma mark - Interactivity

#warning NEED TO FINISH POST CALL

/*
 *  Submit button is pressed, SOME NETWORKING IS GOING DOWN
 */

- (IBAction)submitPressed:(id)sender
{
    NSString *comment = self.commentTextField.text;
    NSString *title = self.titleTextField.text;
    NSString *nickname = self.nicknameTextField.text;
    NSNumber *numStars;
    if (self.starView.numStars)
        numStars = self.starView.numStars;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/recommendations/"
       parameters:@{
                    @"comment": comment,
                    @"title": title,
                    @"nickname": nickname,
                    @"stars": numStars,
                    @"score": @"0.00",
                    @"user": @"/api/v1/user/1/",
                    @"date_posted": @"2014-07-28T18:48:29.241317",
                    @"entry": [NSString stringWithFormat:(@"/api/v1/entries/%li/"),(long)self.mealId.integerValue],
                    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"SUCCESS with response %@", responseObject);
              UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank You!"
                                                             message:@"Thanks for posting!"
                                                            delegate:self
                                                   cancelButtonTitle:@"Done"
                                                   otherButtonTitles: nil];
              [alert show];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"FAILED with operation %@", operation.responseString);
          }];
}
// {"approved": 1, "checked": 1, "comment": "", "date_posted": "2014-09-03T18:29:26.837659", "entry": "/api/v1/entries/1/", "id": 1, "nickname": "Bob2325", "sliders": [], "title": "", "user": "/api/v1/user/1/" , "stars": 4.5, "score": 0.0}
/*
 *  Dismisses popup!
 */

-(IBAction)cancelSubmitReview:(id)sender
{
    [self.delegate submitReviewReadyWillDismiss];
}

#pragma mark - UIAlertView Delegate

/*
 *  Call delegate after UIAlertView
 */

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.delegate submitReviewReadyWillDismiss];
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
