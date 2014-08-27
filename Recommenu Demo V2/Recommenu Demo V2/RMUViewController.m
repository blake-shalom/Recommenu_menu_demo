//
//  RMUViewController.m
//  Recommenu Demo V2
//
//  Created by Blake Ellingham on 8/21/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUViewController.h"

@interface RMUViewController ()

// UI
@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;

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
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    [self.menuCollectionView registerNib:[UINib nibWithNibName:@"RMUPicCollectionHeader" bundle:[NSBundle mainBundle]]
              forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"picCollectionView"];
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
        return [[self.menuDictionary objectForKey:@"objects"]count];
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
        NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:section];
        return [[course objectForKey:@"sections"] count];
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
    if (indexPath.section > 0){
        RMUHeaderCollectionView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topView" forIndexPath:indexPath];
        NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:indexPath.section];
        [sectionView.sectionTitle setText:[course objectForKey:@"name"]];
        view = sectionView;
    }
    else {
        RMUPicCollectionView *picSectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:@"picCollectionView" forIndexPath:indexPath];
        NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:indexPath.section];
        [picSectionView.sectionLabel setText:[course objectForKey:@"name"]];
        view = picSectionView;

    }
    return view;
}

/*
 *  Cell for index, fills in info from the DB
 */

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell" forIndexPath:indexPath];
    NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:indexPath.section];
    NSArray *meals = [course objectForKey:@"sections"];
    NSDictionary *meal = [[meals[indexPath.row] objectForKey:@"entries"] objectAtIndex:0];
    [cell.itemTitle setText:[meal objectForKey:@"name"]];
    [cell.itemDescription setText:[meal objectForKey:@"description"]];
    // Handle stars
    NSNumber *starAverage = [meal objectForKey:@"star_average"];
    if (starAverage != (id) [NSNull null])
        [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:starAverage.integerValue * 2];
    else
        [cell.starView fillInNumberOfStarsWithNumberOfHalfStars:0];
    
    // Handle Image for dish
    UIImage *img;
    NSString *entreeID = [meal objectForKey:@"id"];
    
    if ([self.imageDictionary objectForKey:entreeID]) {
        img = [self.imageDictionary objectForKey:entreeID];
    }
    else {
        NSURL *url = [NSURL URLWithString:[meal objectForKey:@"image"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        img = [[UIImage alloc]initWithData:data];
        [self.imageDictionary setObject:img forKey:entreeID];
    }
    [cell.itemImage setImage:img];
    
    // Set tag to the id of the dish
    cell.revealReviewButton.tag = entreeID.integerValue;

    return cell;
}

/*
 *  Either return the pic header height or the regular section height
 */

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section > 0) {
        return CGSizeMake(50.0f, 80.0f);
    }
    else {
        return CGSizeMake(50.0f, 350.0f);
    }
}

#pragma mark - Networking

/*
 *  Loads the test menu into a predefined data structure
 */

- (void)loadAllDishes
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://tranquil-plateau-8131.herokuapp.com/api/v1/menus/"
      parameters:@{@"company": @5}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"SUCCESS with response %@", responseObject);
             self.menuDictionary = responseObject;
             [self.menuCollectionView reloadData];
             self.imageDictionary = [[NSMutableDictionary alloc]init];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"FAILED with operation %@", operation.responseString);
         }];
}

#pragma mark - Interactivity

/*
 *  Loads review screen
 */

- (IBAction)revealPopupView:(UIButton*)sender
{
    NSLog(@"REVEALED at index %i", sender.tag);
}

@end
