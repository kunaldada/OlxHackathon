//
//  DummyData.h
//  OlxHackathon
//
//  Created by Kunal Chelani on 9/26/15.
//  Copyright (c) 2015 til. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DummyData : NSObject


-(NSArray*) getProductListForCategory:(NSString*) catStr;

-(NSArray*) getProductListForCategory:(NSString*) catStr withSearchStr:(NSString*)searchStr;


@end
