//
//  Canvas+CoreDataProperties.m
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 16/4/16.
//  Copyright © 2016年 Yiwen Fu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Canvas+CoreDataProperties.h"

@implementation Canvas (CoreDataProperties)

@dynamic active_flag;
@dynamic canvas_description;
@dynamic canvas_id;
@dynamic canvas_title;
@dynamic create_date;
@dynamic create_user;
@dynamic display_name;
@dynamic editable_flag;
@dynamic open_flag;
@dynamic owner_user;
@dynamic unique_id;
@dynamic model_type;

+ (NSString *)defaultSortAttribute {
    return @"canvas_id";
}

@end
