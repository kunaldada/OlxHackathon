//
//  HomeViewController.h
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    eMobile = 0,
    eCars,
    eElectronics
} CategoryType;

@interface HomeViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;
@property (strong,nonatomic) NSMutableArray *categoriesArray;
@end
