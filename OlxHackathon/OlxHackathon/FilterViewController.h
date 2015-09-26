//
//  FilterViewController.h
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol categoryChanged <NSObject>

-(void) reloadForNewCategoriesWithCategoryArray:(NSArray*) categoryArray;

@end


@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (weak,nonatomic) id<categoryChanged> changedDelegate;
@end
