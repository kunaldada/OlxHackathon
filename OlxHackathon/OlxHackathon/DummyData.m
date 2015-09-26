//
//  DummyData.m
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import "DummyData.h"
#import "Product.h"
@implementation DummyData

-(NSArray*) getProductListForCategory:(NSString*) catStr withSearchStr:(NSString*)searchStr{
    
//    NSArray *dataDict = [self fetchDictForKey:catStr];
    NSArray *dataArray = [self bindData];
    if (![searchStr isEqualToString:@""]) {
        dataArray = [self searchForKeyWord:searchStr inArray:dataArray];
    }
    return dataArray;
}


//-(NSArray*) fetchDictForKey: (NSString*) akey
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"DummyData" ofType:@"plist"];
//    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
//    NSArray *dataDict = [myDictionary objectForKey:akey];
//    return dataDict;
//}

-(NSArray*) bindData{
    NSMutableArray *repo = [[NSMutableArray alloc] init];
    for (int i=0;i<10;i++) {
        
        Product *product = [[Product alloc] init];
        product.title=@"Samsung";
        product.price=@"Rs. 1,000";
        product.timePlace=@"02:08 pm in Gurgaon";
        [repo addObject:product];
    }
    return repo;
    
}

-(NSArray*) searchForKeyWord:(NSString*) keyWord inArray:(NSArray*)dataArray{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    for (Product *product in dataArray) {
        if (([product.title rangeOfString:keyWord].location == NSNotFound)) {
            
        } else {
            [responseArray addObject:product];
        }
    }
    return responseArray;
}



@end
