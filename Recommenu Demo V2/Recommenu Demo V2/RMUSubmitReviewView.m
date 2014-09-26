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

#warning EMAIL IS NOT USED!!!!!!
/*
 *  Submit button is pressed, SOME NETWORKING IS GOING DOWN
 */

- (IBAction)submitPressed:(id)sender
{
    NSString *comment = self.commentTextField.text;
    NSString *title = self.titleTextField.text;
    NSString *nickname = self.nicknameTextField.text;
    NSString *email = self.emailTextField.text;
    NSNumber *numStars;
    if ([comment isEqualToString:@""] || [title isEqualToString:@""] ||
        [nickname isEqualToString:@""] || [email isEqualToString:@""] ||
        (!self.starView.numStars)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please Fill Out all forms!"
                                                       message:@"Comment Will be posted when all forms are filled."
                                                      delegate:self
                                             cancelButtonTitle:@"Done"
                                             otherButtonTitles: nil];
        alert.tag = 1;
        [alert show];
    }
    else {
        numStars = self.starView.numStars;
        NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
        [decimalStyleFormatter setMaximumFractionDigits:1];
        NSNumber *number = [decimalStyleFormatter numberFromString:[NSString stringWithFormat:(@"%f"), numStars.floatValue]];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
        NSDate *currentDate = [NSDate date];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        NSMutableArray *sliderArray = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            RMUSlider *currSlider = (RMUSlider*) [self viewWithTag:i + 5];
            UILabel *currLabel = (UILabel*) [self viewWithTag:i + 8];
            if (!currLabel.isHidden){
                NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
                [decimalStyleFormatter setMaximumFractionDigits:1];
                [decimalStyleFormatter setMinimumFractionDigits:1];
                NSNumber *sliderNum = [decimalStyleFormatter numberFromString:[NSString stringWithFormat:(@"%f"), currSlider.value]];
                NSLog(@"%@", sliderNum);
                NSDictionary *slider = @{@"category": currLabel.text,
                                         @"score": sliderNum,
                                         @"slider_template": self.templateArray[i]};
                [sliderArray addObject:slider];
            }
            else {
                break;
            }
        }

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager POST:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/recommendations/"
           parameters:@{
                        @"comment": comment,
                        @"title": title,
                        @"nickname": nickname,
                        @"stars": number,
                        @"score": @"0.0",
                        @"user": @"/api/v1/user/1/",
                        @"date_posted": dateString,
                        @"entry": [NSString stringWithFormat:(@"/api/v1/entries/%li/"),(long)self.mealId.integerValue],
                        @"sliders": sliderArray
                        }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"SUCCESS with response %@", responseObject);
                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank You!"
                                                                 message:@"Thanks for posting!"
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles: nil];
                  alert.tag = 0;
                  [alert show];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Request body %@", [[NSString alloc] initWithData:[operation.request HTTPBody] encoding:NSUTF8StringEncoding]);
                  NSLog(@"%@", operation.request);
                  NSLog(@"FAILED with operation %@", operation.responseString);
                  
                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank You!"
                                                                 message:@"Thanks for posting!"
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles: nil];
                  alert.tag = 0;
                  [alert show];
              }];
        
    }
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
    if (alertView.tag == 0)
        [self.delegate submitReviewReadyWillDismiss];
}

-(void)loadSlidersWithSliderArray:(NSArray*)sliderArray
{
    self.templateArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        RMUSlider *currSlider = (RMUSlider*) [self viewWithTag:i + 5];
        UILabel *currLabel = (UILabel*) [self viewWithTag:i + 8];
        if (i < sliderArray.count) {
            [currLabel setHidden:NO];
            [currSlider setHidden:NO];
            NSString *sliderText = [sliderArray[i] objectForKey:@"category"];
            [currLabel setText:sliderText];
            [self.templateArray addObject:[sliderArray[i] objectForKey:@"resource_uri"]];
        }
        else {
            [currLabel setHidden:YES];
            [currSlider setHidden:YES];
        }
    }
}

-(void)clearAllTextFields
{
    self.commentTextField.text = @"";
    self.titleTextField.text = @"";
    self.nicknameTextField.text = @"";
    self.emailTextField.text = @"";
    [self.starView fillInNumberOfStarsWithNumberOfHalfStars:0];
    for (int i = 0; i < 3; i++) {
        RMUSlider *currSlider = (RMUSlider*) [self viewWithTag:i + 5];
        [currSlider setValue:50.0f];
    }
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
