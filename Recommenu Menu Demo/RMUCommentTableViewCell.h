//
//  RMUCommentTableViewCell.h
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/28/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMUStarView.h"
#import "RMUSlider.h"

@interface RMUCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *upvoteButton;
@property (weak, nonatomic) IBOutlet UIButton *downvoteButton;
@property (weak, nonatomic) IBOutlet RMUStarView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *upButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *downButtonImage;
@property (weak, nonatomic) IBOutlet RMUSlider *topFoodSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *middleFoodSlider;
@property (weak, nonatomic) IBOutlet RMUSlider *bottomFoodSlider;

@property BOOL isUpvotePressed;
@property BOOL isDownvotePressed;

@end
