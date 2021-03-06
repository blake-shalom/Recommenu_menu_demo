//
//  RMUViewController.h
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "RMUMenuCell.h"
#import "RMUHeaderCollectionView.h"
#import "RMUPicCollectionView.h"
#import "RMUStarView.h"
#import "RMUSubmitReviewView.h"
#import "RMUReviewsPopupView.h"

@interface RMUViewController : UIViewController
<UICollectionViewDataSource, UICollectionViewDelegate,
RMUReviewsPopupDelegate, RMUSubmitReviewDelegate>
@end
