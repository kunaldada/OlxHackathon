//
//  FilterViewController.m
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *categoriesArray;
    NSMutableArray *selectedCategoriesArray;
    BOOL wasCategoryChanged;
}
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    categoriesArray = [[NSArray alloc] initWithObjects:@"Mobiles",@"Cars",@"Electronics", nil];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Categories"]) {
        selectedCategoriesArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Categories"]];
    }
    self.title=@"Filter Categories";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (wasCategoryChanged) {
        [[NSUserDefaults standardUserDefaults] setValue:selectedCategoriesArray forKey:@"Categories"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.changedDelegate reloadForNewCategoriesWithCategoryArray:selectedCategoriesArray];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return categoriesArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text= [categoriesArray objectAtIndex:indexPath.row];
    if ([selectedCategoriesArray containsObject:[categoriesArray objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
/*    wasCategoryChanged=YES;
    if ([selectedCategoriesArray containsObject:[categoriesArray objectAtIndex:indexPath.row]]) {
        [selectedCategoriesArray removeObject:[categoriesArray objectAtIndex:indexPath.row]];
    }
    else{
        [selectedCategoriesArray addObject:[categoriesArray objectAtIndex:indexPath.row]];
    }
    NSArray *idxArray = [[NSArray alloc] initWithObjects:indexPath, nil];
    [tableView reloadRowsAtIndexPaths:idxArray withRowAnimation:UITableViewRowAnimationNone];
  */
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
