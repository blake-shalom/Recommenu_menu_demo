//
//  RMUCommentField.h
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/25/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMUCommentField : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
