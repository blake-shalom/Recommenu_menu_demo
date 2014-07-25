//
//  RMUSubmitReviewView.h
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/24/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUSlider.h"
#import "RMUCurvedButton.h"
#import "RMUCommentField.h"

@interface RMUSubmitReviewView : UIView

@property (weak, nonatomic) IBOutlet RMUSlider *topFoodSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *middleFoodSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *bottomFoodSlider;
@property (weak, nonatomic) IBOutlet RMUCurvedButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *visibleView;
@property (weak, nonatomic) IBOutlet RMUCommentField *commentTextField;

@end
