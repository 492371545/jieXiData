
//
//  Model.m
//  XMLOrJSON
//
//  Created by Mengying Xu on 14-11-4.
//  Copyright (c) 2014年 Crystal Xu. All rights reserved.
//

#import "Model.h"

@implementation Model

- (void)encodeFromDic:(NSDictionary*)dic
{
    self.aa = [dic objectForKey:@"aa"];
    self.b = [dic objectForKey:@"b"];
    self.c = [dic objectForKey:@"c"];
    self.d = [dic objectForKey:@"d"];

}

@end
