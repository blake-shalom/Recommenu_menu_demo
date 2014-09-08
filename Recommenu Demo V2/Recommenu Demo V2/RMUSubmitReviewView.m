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

/*
 *  Submit button is pressed, SOME NETWORKING IS GOING DOWN
 */

- (IBAction)submitPressed:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *commentString = self.commentTextField.text;
    NSNumber *num = [NSNumber numberWithLong:self.mealId.integerValue + 2500];
    [manager POST:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/recommendations/"
       parameters:@{
                    @"comment": commentString,
                    @"date_posted": @"2014-07-28T18:48:29.241317",
                    @"entry": [NSString stringWithFormat:(@"/api/v1/entries/%li/"),(long)self.mealId.integerValue],
                    @"id": num,
                    @"resource_uri": [NSString stringWithFormat:(@"/api/v1/recommendations/%i/"),self.mealId.integerValue + 2500],
                    @"score": @"18",
                    @"user": @"/api/v1/user_profile/107/"
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
