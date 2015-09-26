//
//  CategoryTableViewCell.h
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface CategoryTableViewCell : UITableViewCell

-(void) bindDataWith:(Product*) product;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timePlaceLabel;

@end
