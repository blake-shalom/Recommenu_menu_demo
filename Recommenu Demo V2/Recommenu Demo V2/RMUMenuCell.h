//
//  RMUMenuCell.h
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUStarView.h"
#import "RMUSlider.h"

@interface RMUMenuCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemDescription;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet RMUStarView *starView;
@property (weak, nonatomic) IBOutlet RMUSlider *topSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *middleSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *bottomSlider;
@property (weak, nonatomic) IBOutlet UILabel *numReviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondSliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdSliderLabel;
@property (weak, nonatomic) IBOutlet UIButton *revealReviewButton;

@end
