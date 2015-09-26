//
//  HomeCollectionViewCell.m
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "CategoryTableViewCell.h"
#import "OlxPrefix.pch"
@interface HomeCollectionViewCell()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray* productsArray;
}
@end



@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    CGSize cellSize = GET_CELL_SIZE;
    self.categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, cellSize.width,cellSize.height)];
    self.categoryTableView.delegate=self;
    self.categoryTableView.dataSource=self;
    [self addSubview:self.categoryTableView];
    [self bringSubviewToFront:self.categoryTableView];
    
}
-(void) reloadDataForTable;
{
    [self.categoryTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    productsArray = [self.dataDict objectForKey:@"data"];
    return productsArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (CategoryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"categoryCell";
    
    CategoryTableViewCell *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell bindDataWith:[productsArray objectAtIndex:indexPath.row]];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GET_CELL_SIZE.width, 44)];
        UILabel *lbl =[[UILabel alloc] initWithFrame:CGRectMake(30, 0, GET_CELL_SIZE.width, 44)];
        lbl.text=[self.dataDict objectForKey:@"header"];
        [view setBackgroundColor:RGBA(245, 246, 245, 1.0)];
        [view addSubview:lbl];
        return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}




@end
