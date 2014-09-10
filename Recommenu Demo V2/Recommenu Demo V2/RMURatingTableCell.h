//
//  RMURatingTableCell.h
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/25/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUStarView.h"
#import "RMUSlider.h"

@interface RMURatingTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet RMUStarView *starView;
@property (weak, nonatomic) IBOutlet RMUSlider *bottomSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *middleSlider;
@property (weak, nonatomic) IBOutlet UILabel *topSliderLabel;
@property (weak, nonatomic) IBOutlet RMUSlider *topSlider;
@property (weak, nonatomic) IBOutlet UILabel *middleSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewName;
@property (weak, nonatomic) IBOutlet UILabel *reviewDate;
@property (weak, nonatomic) IBOutlet UILabel *reviewParagraph;
@property (weak, nonatomic) IBOutlet UILabel *reviewTitle;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UILabel *numLikes;

@end
