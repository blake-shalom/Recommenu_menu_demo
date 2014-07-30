//
//  RMUViewRatingsPopup.h
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/23/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "RMUCommentTableViewCell.h"

@interface RMUViewRatingsPopup : UIView
<UITableViewDataSource, UITableViewDelegate>

@property NSDictionary *reviewDictionary;

- (void) findAllRatingsForMealID:(NSNumber*)mealID;

@end
