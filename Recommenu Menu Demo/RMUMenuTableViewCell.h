//
//  RMUMenuTableViewCell.h
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUSlider.h"

@interface RMUMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *foodItemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodDescriptionLabel;
@property (weak, nonatomic) IBOutlet RMUSlider *topFoodSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *middleFoodSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *bottomFoodSlider;
@property (weak, nonatomic) IBOutlet UIButton *viewReviewsButton;
@property (weak, nonatomic) IBOutlet UIButton *writeReviewsButton;

@end
