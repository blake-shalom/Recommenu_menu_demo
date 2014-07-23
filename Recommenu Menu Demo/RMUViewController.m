//
//  RMUViewController.m
//  Recommenu Menu Demo
//
//  Created by Blake Ellingham on 7/18/14.
//  Copyright (c) 2014 Blake Ellingham. All rights reserved.
//

#import "RMUViewController.h"

@interface RMUViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTable;

@end

@implementation RMUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor RMUSpringWood]];
    [self.menuTable setBackgroundColor:[UIColor RMUSpringWood]];
    [self.menuTable setSeparatorColor:[UIColor RMUSpringWood]];
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

#pragma mark - UITableView DataSource methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark - UITableView Delegate methods

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMUMenuTableViewCell *menuCell = (RMUMenuTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"foodCell"];
    [menuCell.starView fillInNumberOfStarsWithNumberOfHalfStars:(indexPath.row + 1) * 5];
    return menuCell;
}



@end
