//
//  HomeViewController.m
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "OlxPrefix.pch"
#import "LXReorderableCollectionViewFlowLayout.h"
#import "DummyData.h"
#import "FilterViewController.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,LXReorderableCollectionViewDataSource,LXReorderableCollectionViewDelegateFlowLayout,categoryChanged>
{
    NSString *searchStr;
    BOOL reloadCollectionView;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    searchStr=@"";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Categories"]) {
        self.categoriesArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Categories"];
    }
    else{
        self.categoriesArray = [[NSMutableArray alloc] initWithObjects:@"Mobiles",@"Cars",@"Electronics", nil];
        [self writeToUserDefaults];
    }
    
    self.homeCollectionView.collectionViewLayout=[self getLayout];
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
    self.homeCollectionView.showsHorizontalScrollIndicator = NO;
//    self.homeCollectionView.pagingEnabled = YES;
//    self.navigationItem.rightBarButtonItem = [self getRightMenuButton];
        // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (reloadCollectionView) {
        self.homeCollectionView.contentOffset=CGPointMake(0, 0);
        self.homeCollectionView.collectionViewLayout=[self getLayout];
        [self.homeCollectionView.collectionViewLayout invalidateLayout];
        [self.homeCollectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"homeCell"];
        self.homeCollectionView.showsHorizontalScrollIndicator = NO;
        
        [self.homeCollectionView reloadData];
        reloadCollectionView=NO;

    }
    
}
-(void) writeToUserDefaults{
    
    [[NSUserDefaults standardUserDefaults] setValue:self.categoriesArray forKey:@"Categories"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (UIBarButtonItem *) getRightMenuButton{
    

    UIButton *_leftBarButtonItem = [[UIButton alloc] initWithFrame:CGRectMake(0.0,0.0, 45.0f,44.0f)];
    _leftBarButtonItem.showsTouchWhenHighlighted = TRUE;
    [_leftBarButtonItem addTarget:self action:@selector(filterTapped) forControlEvents:UIControlEventTouchUpInside];
    [_leftBarButtonItem setTitle:@"Filter" forState:UIControlStateNormal];
    [_leftBarButtonItem setTitle:@"Filter" forState:UIControlStateHighlighted];
    [_leftBarButtonItem setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButtonItem];
    
    return leftBarButtonItem;
}

-(void) filterTapped{
    
    FilterViewController *filter = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    filter.changedDelegate=self;
    [self.navigationController pushViewController:filter animated:YES];

}
-(void) reloadForNewCategoriesWithCategoryArray:(NSArray*) categoryArray{
    if (categoryArray) {
        self.categoriesArray = [NSMutableArray arrayWithArray:categoryArray];
    }
    reloadCollectionView=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UICollectionViewFlowLayout *) getLayout{
    
    LXReorderableCollectionViewFlowLayout* flowLayout = [[LXReorderableCollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = GET_CELL_SIZE;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    return flowLayout;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.categoriesArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (HomeCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell = (HomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    
    cell.dataDict = [self createDictForIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    [cell reloadDataForTable];
    
//    if ([headerStr isEqualToString:@"Mobiles"])
//            cell.backgroundColor = [UIColor greenColor];
//    else if ([headerStr isEqualToString:@"Cars"])
//            cell.backgroundColor = [UIColor blueColor];
//    else if ([headerStr isEqualToString:@"Electronics"])
//        cell.backgroundColor = [UIColor redColor];

    return cell;
}


-(NSMutableDictionary*) createDictForIndexPath:(NSIndexPath*) idxPath{
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    DummyData *data = [[DummyData alloc] init];
    [dataDict setObject:[self.categoriesArray objectAtIndex:idxPath.row] forKey:@"header"];
    [dataDict setObject:[data getProductListForCategory:[self.categoriesArray objectAtIndex:idxPath.row] withSearchStr:searchStr] forKey:@"data"];
    return dataDict;
}


#pragma mark UICollectionViewFlowLayoutDelegates

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size = GET_CELL_SIZE;
    
    return size;
    
}


#pragma mark LXReordableDataSourceDelegates

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath{
    
    NSString *fromStr = [self.categoriesArray objectAtIndex:fromIndexPath.row];
    [self.categoriesArray removeObjectAtIndex:fromIndexPath.row];
    [self.categoriesArray insertObject:fromStr atIndex:toIndexPath.row];
    [self writeToUserDefaults];
}
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath{
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath{
    return YES;
}

#pragma mark - LXReorderableCollectionViewDelegateFlowLayout methods

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will begin drag");
}
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will end drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did end drag");
}

#pragma mark Search Bar delegates

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    searchStr = searchText;
    NSLog(@"%@",searchText);
    [self.homeCollectionView reloadData];
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 10.0;
}




//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;



@end
