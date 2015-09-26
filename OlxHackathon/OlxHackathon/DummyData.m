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
    NSArray *dataArray = [self bindDataForCategory:catStr];
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

-(NSArray*) bindDataForCategory:(NSString*)category{
    NSMutableArray *repo = [[NSMutableArray alloc] init];
    Product *product1 = [[Product alloc] init];
    Product *product2 = [[Product alloc] init];
    
    if ([category isEqualToString:@"Mobiles"]) {
        product1.title=@"Samsung Duos";
        product1.price=@"Rs. 10,000";
        product1.timePlace=@"02:08 pm in Gurgaon";
        
        product2.title=@"HTC One X";
        product2.price=@"Rs. 12,000";
        product2.timePlace=@"01:08 am in Mumbai";

    }
    if ([category isEqualToString:@"Cars"]) {
        product1.title=@"Ford Figo";
        product1.price=@"Rs. 1,00,000";
        product1.timePlace=@"02:18 pm in Gurgaon";
        
        product2.title=@"Honda City";
        product2.price=@"Rs. 1,20,000";
        product2.timePlace=@"00:08 am in Mumbai";
        
    }
    if ([category isEqualToString:@"Electronics"]) {
        product1.title=@"Washing Machine";
        product1.price=@"Rs. 11,100";
        product1.timePlace=@"10:01 am in Pune";
        
        product2.title=@"Kelvinator fridge";
        product2.price=@"Rs. 5,000";
        product2.timePlace=@"01:08 am in Mumbai";
        
    }
    
    for (int i=0;i<6;i++) {
        [repo addObject:product1];
        [repo addObject:product2];
    }
    return repo;
    
}

-(NSArray*) searchForKeyWord:(NSString*) keyWord inArray:(NSArray*)dataArray{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    for (Product *product in dataArray) {
        if (([product.title rangeOfString:keyWord options:NSCaseInsensitiveSearch].location == NSNotFound)) {
            
            
            
        } else {
            [responseArray addObject:product];
        }
    }
    return responseArray;
}



@end
