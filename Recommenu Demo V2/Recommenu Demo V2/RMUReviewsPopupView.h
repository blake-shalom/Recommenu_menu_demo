//
//  RMUReviewsPopupView.h
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/25/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMUReviewsPopupView : UIView
<UITableViewDataSource, UITableViewDelegate>

@property (weak,nonatomic) IBOutlet UITableView *reviewsTable;
@property (weak,nonatomic) IBOutlet UILabel *dishNameLabel;

@end
