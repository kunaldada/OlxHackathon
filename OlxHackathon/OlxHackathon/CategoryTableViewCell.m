//
//  CategoryTableViewCell.m
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) bindDataWith:(Product*) product{
    
    self.titleLabel.text=product.title;
    self.priceLabel.text =product.price;
    self.timePlaceLabel.text=product.timePlace;
    
}


@end
