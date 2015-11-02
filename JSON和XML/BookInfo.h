//
//  BookInfo.h
//  JSON和XML
//
//  Created by RenSihao on 15/10/29.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookInfo : NSObject


@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *price;
@end
