//
//  RMUViewController.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/18/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUViewController.h"
#define MAX_ROWS 2
#define MAX_COLS 4

@interface RMUViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UIView *shroudView;
@property (weak, nonatomic) IBOutlet RMUViewRatingsPopup *viewRatingsPopup;
@property (weak, nonatomic) IBOutlet RMUSubmitReviewView *submitReviewPopup;
@property (weak, nonatomic) IBOutlet UIButton *dismissKeyboardButton;

@property NSDictionary *menuDictionary;

@end

@implementation RMUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor RMUSpringWood]];
    [self.menuTable setBackgroundColor:[UIColor RMUSpringWood]];
    [self.menuTable setSeparatorColor:[UIColor RMUSpringWood]];
    [self loadAllDishes];
    self.submitReviewPopup.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)keyboardDidShow: (NSNotification *) notif
{
    [self.dismissKeyboardButton setHidden:NO];
}
- (IBAction)dismissButtonTouched:(id)sender
{
    [self.view endEditing:YES];
    [self.dismissKeyboardButton setHidden:YES];
}

#pragma mark - UITableView DataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.menuDictionary){
        return [[self.menuDictionary objectForKey:@"objects"]count];
    }
    else
        return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.menuDictionary){
        NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:section];
        return [[course objectForKey:@"sections"] count];
    }
    else {
        return 0;
    }
}

#pragma mark - Networking Methods

- (void)loadAllDishes
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/menus/"
      parameters:@{@"company": @5}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"SUCCESS with response %@", responseObject);
             self.menuDictionary = responseObject;
             [self.menuTable reloadData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"FAILED with operation %@", operation.responseString);
         }];
}

#pragma mark - UITableView Delegate methods

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenuTableViewCell *menuCell = (RMUMenuTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"foodCell"];
    NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:indexPath.section];
    NSDictionary *meal = [[[[course objectForKey:@"sections"]objectAtIndex:indexPath.row] objectForKey:@"entries"] objectAtIndex:0];
    [menuCell.foodItemNameLabel setText:[meal objectForKey:@"name"]];
    [menuCell.foodDescriptionLabel setText:[meal objectForKey:@"description"]];
    menuCell.writeReviewsButton.tag = indexPath.section * 2 + indexPath.row;
    menuCell.readReviewsButton.tag = indexPath.section * 2 + indexPath.row;
    menuCell.isTopCommentVisible = NO;
    [menuCell.topCommentView setHidden:YES];
    [menuCell.starView fillInNumberOfStarsWithNumberOfHalfStars:10 - indexPath.row];
    [menuCell.topFoodSlider setValue:70.0f animated:YES];
    [menuCell.middleFoodSlider setValue:30.0f animated:YES];
    [menuCell.bottomFoodSlider setValue:50.0f animated:YES];

    return menuCell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:section];
    return [course objectForKey:@"name"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(20, 15, 320, 20);
    myLabel.font = [UIFont boldSystemFontOfSize:18];
    myLabel.text = [[self tableView:tableView titleForHeaderInSection:section] uppercaseString];
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

- (void)animateShroudInWithCompletion:(void (^)(BOOL))completion
{
    [self.shroudView setHidden:NO];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self.shroudView setAlpha:0.4f];
                     }
     completion:completion];
}
- (void)animateShroudOut
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self.shroudView setAlpha:0.0f];
                     }
                     completion:^(BOOL finished) {
                         [self.shroudView setHidden:YES];
                     }];
}

- (IBAction)writeReviewButtonPressed:(UIButton*)button
{
    NSInteger section = button.tag / 2;
    NSInteger row = button.tag % 2;
    NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:section];
    NSDictionary *meal = [[[[course objectForKey:@"sections"]objectAtIndex:row] objectForKey:@"entries"] objectAtIndex:0];
    NSNumber *mealID = [meal objectForKey:@"id"];
    self.submitReviewPopup.mealId = mealID;
    [self animateShroudInWithCompletion:^(BOOL completion) {
        [self.submitReviewPopup setHidden:NO];
    }];
}
- (IBAction)revealReviewPopup:(id)sender {
}

- (IBAction)revealWriteReviewView:(id)sender {
}
- (IBAction)viewRatingsButtonPressed:(UIButton*)button
{
    NSInteger section = button.tag / 2;
    NSInteger row = button.tag % 2;
    NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:section];
    NSDictionary *meal = [[[[course objectForKey:@"sections"]objectAtIndex:row] objectForKey:@"entries"] objectAtIndex:0];
    NSNumber *mealID = [meal objectForKey:@"id"];
    [self.viewRatingsPopup findAllRatingsForMealID:mealID];

    [self animateShroudInWithCompletion:^(BOOL completion) {
        [self.viewRatingsPopup setHidden:NO];
    }];
}
- (IBAction)revealWriteReviewView:(id)sender {
}
- (IBAction)revealWriteReviewView:(id)sender {
}

- (IBAction)exitSubmitRating:(id)sender
{
    [self.submitReviewPopup setHidden:YES];
    [self animateShroudOut];
}
- (IBAction)exitViewRatings:(id)sender
{
    [self.viewRatingsPopup setHidden:YES];
    [self animateShroudOut];
}

- (void)submitReviewReadyWillDismiss
{
    [self.submitReviewPopup setHidden:YES];
    [self animateShroudOut];
}

@end
