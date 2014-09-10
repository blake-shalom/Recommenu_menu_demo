//
//  RMUViewController.m
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

// Imports
#import <math.h>
#import "RMUViewController.h"

// Defines
#define LOCAL_QUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define HEIGHT_OF_FOOTER_VIEW 112.0f
#define HEIGHT_OF_PIC_HEADER 433.0f
#define HEIGHT_OF_HEADER 80.0f

@interface RMUViewController ()

// UI
@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIView *yellowSection;
@property (weak, nonatomic) IBOutlet UIView *faderView;
@property (weak, nonatomic) IBOutlet RMUReviewsPopupView *reviewPopup;
@property (weak, nonatomic) IBOutlet RMUSubmitReviewView *submitPopup;

// Data Structures
@property NSDictionary *menuDictionary;
@property NSMutableDictionary *imageDictionary;

@end

@implementation RMUViewController

/*
 *  View did load loads dishes and ready's UI
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.menuCollectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(13, 0, 13, 0);
    [self.menuCollectionView registerNib:[UINib nibWithNibName:@"RMUPicCollectionHeader" bundle:[NSBundle mainBundle]]
              forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"picCollectionView"];
    [self.yellowSection setBackgroundColor:[UIColor RMUSunglow]];
    self.reviewPopup.delegate = self;
    self.submitPopup.delegate = self;
    [self loadAllDishes];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollection View Data Source

/*
 *  Returns count of sections from DB
 */

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.menuDictionary){
        NSArray *courseArray = [[[self.menuDictionary objectForKey:@"objects"]objectAtIndex:0]objectForKey:@"sections"];
        return [courseArray count];
    }
    else
        return 0;
}

/*
 *  Returns number of items in each sections from DB
 */

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.menuDictionary){
        NSArray *courseArray = [[[self.menuDictionary objectForKey:@"objects"]objectAtIndex:0]objectForKey:@"sections"];
        NSDictionary *course = [courseArray objectAtIndex:section];
        return [[course objectForKey:@"entries"] count];
    }
    else {
        return 0;
    }
}

/*
 *  Either we return a header with a pic for the first index, else return just the name
 */

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (indexPath.section > 0){
            RMUHeaderCollectionView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topView" forIndexPath:indexPath];
            NSArray *courseArray = [[[self.menuDictionary objectForKey:@"objects"]objectAtIndex:0]objectForKey:@"sections"];
            NSDictionary *course = [courseArray objectAtIndex:indexPath.section];
            [sectionView.sectionTitle setText:[course objectForKey:@"name"]];
            view = sectionView;
        }
        else {
            RMUPicCollectionView *picSectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                      withReuseIdentifier:@"picCollectionView" forIndexPath:indexPath];
            NSArray *courseArray = [[[self.menuDictionary objectForKey:@"objects"]objectAtIndex:0]objectForKey:@"sections"];
            NSDictionary *course = [courseArray objectAtIndex:indexPath.section];
            [picSectionView.sectionLabel setText:[course objectForKey:@"name"]];
            view = picSectionView;
            
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                      withReuseIdentifier:@"footerView"
                                                             forIndexPath:indexPath];
    }
    return view;
}

/*
 *  Cell for index, fills in info from the DB
 */

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell" forIndexPath:indexPath];
    NSArray *courseArray = [[[self.menuDictionary objectForKey:@"objects"]objectAtIndex:0]objectForKey:@"sections"];
    NSDictionary *course = [courseArray objectAtIndex:indexPath.section];
    NSArray *meals = [course objectForKey:@"entries"];
    NSDictionary *meal = meals[indexPath.row];
    [cell.itemTitle setText:[meal objectForKey:@"name"]];
    [cell.itemDescription setText:[meal objectForKey:@"description"]];
    [cell.numReviewsLabel setText:[NSString stringWithFormat:(@"%@ reviews"), [meal objectForKey:@"review_count"]]];
    // Handle stars
    NSNumber *starAverage = [meal objectForKey:@"star_average"];
    if (starAverage == (id) [NSNull null])
        [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:0];

    CGFloat starFloat = starAverage.floatValue;
    CGFloat starRemain = fmodf(starFloat, 1);
    if (starRemain < 0.33f)
        [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:starAverage.integerValue * 2];
    else if (starRemain < 0.67f)
        [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:starAverage.integerValue * 2 + 1];
    else
        [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:(starAverage.integerValue +1) * 2];
    
    [cell.topCommentLabel setText:[NSString stringWithFormat:(@"\"%@...\""),[meal objectForKey:@"top_comment"]]];
    NSNumber *priceNumber = [meal objectForKey:@"price"];
    if (priceNumber != (id) [NSNull null])
        [cell.priceLabel setText:[NSString stringWithFormat:(@"$%@"),priceNumber]];
    else
        [cell.priceLabel setText:@""];
    
    // Handle Image for dish
    NSString *entreeID = [meal objectForKey:@"id"];
    
    if ([self.imageDictionary objectForKey:entreeID]) {
        UIImage *img = [self.imageDictionary objectForKey:entreeID];
        [cell.itemImage setImage:img];
        [cell.loadIndicator setHidden:YES];
    }
    else {
        UIImage *img = [[UIImage alloc]init];
        [cell.itemImage setImage:img];
        [cell.loadIndicator setHidden:NO];
    }
    
    // Handle Sliders
    NSArray *sliders = [meal objectForKey:@"slider_templates"];
    if (sliders.count > 0){
        for (int i = 0; i < 3; i++) {
            RMUSlider *currSlider = (RMUSlider*) [cell viewWithTag:i + 5];
            UILabel *currLabel = (UILabel*) [cell viewWithTag:i + 8];
            if (i < sliders.count) {
                NSNumber *score = [sliders[i] objectForKey:@"average_score"];
                [currLabel setHidden:NO];
                [currSlider setHidden:NO];
                [currSlider setValue:score.floatValue];
                [currLabel setText:[sliders[i] objectForKey:@"category"]];
            }
            else {
                [currLabel setHidden:YES];
                [currSlider setHidden:YES];
            }
        }
    }

    
    // Set tag to the id of the dish
    cell.revealReviewButton.tag = entreeID.integerValue;
    cell.writeReviewButton.tag = entreeID.integerValue;
    
    return cell;
}

/*
 *  Either return the pic header height or the regular section height
 */

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section > 0) {
        return CGSizeMake(50.0f, HEIGHT_OF_HEADER);
    }
    else {
        return CGSizeMake(50.0f, HEIGHT_OF_PIC_HEADER);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    NSArray *courseArray = [[[self.menuDictionary objectForKey:@"objects"]objectAtIndex:0]objectForKey:@"sections"];
    if (section == courseArray.count -1)
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), HEIGHT_OF_FOOTER_VIEW);
    else
        return CGSizeZero;
}


#pragma mark - Networking

/*
 *  Loads the test menu into a predefined data structure
 */

- (void)loadAllDishes
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/menus/"
      parameters:@{@"company": @1}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"SUCCESS with response %@", responseObject);
             self.menuDictionary = responseObject;
             [self.menuCollectionView reloadData];
             [self.loadingIndicator setHidden:YES];
             [self performSelectorInBackground:@selector(loadMenuPictures) withObject:nil];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"FAILED with operation %@", operation.responseString);
         }];
}

- (void)loadMenuPictures
{
    self.imageDictionary = [[NSMutableDictionary alloc]init];
    NSArray *courseArray = [[[self.menuDictionary objectForKey:@"objects"]objectAtIndex:0]objectForKey:@"sections"];
    for (NSDictionary *course in courseArray){
        NSArray *meals = [course objectForKey:@"entries"];
        for (NSDictionary *meal in meals) {
            NSString *entreeID = [meal objectForKey:@"id"];
            NSURL *url = [NSURL URLWithString:[meal objectForKey:@"image"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc]initWithData:data];
            if (img != nil)
                [self.imageDictionary setObject:img forKey:entreeID];
            [self.menuCollectionView reloadData];
        }
    }
}

#pragma mark - Animations

/*
 *  Animates in the 
 */

#pragma mark - Interactivity

/*
 *  Loads review screen
 */

- (IBAction)revealPopupView:(UIButton*)sender
{
    [self.faderView setHidden:NO];
    [self.reviewPopup setHidden:NO];
    [self.reviewPopup loadAllReviewsWithEntreeID:[NSNumber numberWithInt:sender.tag]];
}

- (IBAction)revealWriteReviewView:(UIButton*)sender
{
    [self.faderView setHidden:NO];
    [self.submitPopup setHidden:NO];
}

#pragma mark - RMUReviewPopupDelegate

/*
 *  Gets rid of the fader and review popup
 */

-(void)reviewPopupWillDismiss
{
    [self.faderView setHidden:YES];
    [self.reviewPopup setHidden:YES];
}

#pragma mark - RMUSubmitPopupDelegate

/*
 *  Gets rid of the fader and review popup
 */

-(void)submitReviewReadyWillDismiss
{
    [self.faderView setHidden:YES];
    [self.submitPopup setHidden:YES];
}

@end
