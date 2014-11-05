//
//  Model.h
//  XMLOrJSON
//
//  Created by Mengying Xu on 14-11-4.
//  Copyright (c) 2014年 Crystal Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic,copy)NSString *aa;
@property (nonatomic,copy)NSString *b;
@property (nonatomic,copy)NSString *c;
@property (nonatomic,copy)NSString *d;
- (void)encodeFromDic:(NSDictionary*)dic;

@end
