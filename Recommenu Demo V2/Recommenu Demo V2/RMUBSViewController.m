//
//  RMUBSViewController.m
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/26/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUBSViewController.h"

@interface RMUBSViewController ()

@property (weak, nonatomic) IBOutlet RMUReviewsPopupView *reviewPopup;

@end

@implementation RMUBSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSNumber *entree = [NSNumber numberWithInt:42];
    [self.reviewPopup loadAllReviewsWithEntreeID:entree];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
