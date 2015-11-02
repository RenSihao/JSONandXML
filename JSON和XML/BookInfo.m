//
//  BookInfo.m
//  JSON和XML
//
//  Created by RenSihao on 15/10/29.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "BookInfo.h"

@implementation BookInfo

-(NSString *)description
{
    return [NSString stringWithFormat:@"category:%@ title:%@ lang:%@ author:%@ year:%@ price:%@", _category, _title, _lang, _author, _year, _price];
}
@end
