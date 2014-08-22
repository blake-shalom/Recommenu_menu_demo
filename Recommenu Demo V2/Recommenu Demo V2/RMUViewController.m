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

@end

@implementation RMUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.menuCollectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    [self loadAllDishes];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollection View Data Source

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.menuDictionary){
        return [[self.menuDictionary objectForKey:@"objects"]count];
    }
    else
        return 0;
}


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

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RMUHeaderCollectionView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topView" forIndexPath:indexPath];
    NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:indexPath.section];
    [view.sectionTitle setText:[course objectForKey:@"name"]];
    return view;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell" forIndexPath:indexPath];
    NSDictionary *course = [[self.menuDictionary objectForKey:@"objects"]objectAtIndex:indexPath.section];
    NSDictionary *meal = [[[[course objectForKey:@"sections"]objectAtIndex:indexPath.row] objectForKey:@"entries"] objectAtIndex:0];
    [cell.itemTitle setText:[meal objectForKey:@"name"]];
    [cell.itemDescription setText:[meal objectForKey:@"description"]];
    NSURL *url = [NSURL URLWithString:[meal objectForKey:@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    [cell.itemImage setImage:img];
    return cell;
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
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"FAILED with operation %@", operation.responseString);
         }];
}

@end