//
//  Share+CoreDataProperties.m
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/3/5.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "Share+CoreDataProperties.h"

@implementation Share (CoreDataProperties)

+ (NSFetchRequest<Share *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Share"];
}

@dynamic canvas_id;
@dynamic canvas_description;
@dynamic model_type;
@dynamic owner_user;
@dynamic canvas_title;

+ (NSString *)defaultSortAttribute {
    return @"canvas_id";
}

@end
