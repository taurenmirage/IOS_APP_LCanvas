//
//  Suggest+CoreDataProperties.m
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/1/15.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "Suggest+CoreDataProperties.h"

@implementation Suggest (CoreDataProperties)

+ (NSFetchRequest<Suggest *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Suggest"];
}

@dynamic suggest_id;
@dynamic content_type;
@dynamic priority;
@dynamic suggest_type;
@dynamic content;
@dynamic active_flag;

+ (NSString *)defaultSortAttribute {
    return @"suggest_id";
}

@end
