//
//  HomeCollectionViewCell.h
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UITableView *categoryTableView;
@property (strong,nonatomic) NSDictionary *dataDict;
-(void) reloadDataForTable;


@end
