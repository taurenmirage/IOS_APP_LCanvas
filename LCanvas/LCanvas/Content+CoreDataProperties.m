//
//  Content+CoreDataProperties.m
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/21.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Content+CoreDataProperties.h"

@implementation Content (CoreDataProperties)

@dynamic content_id;
@dynamic content_type;
@dynamic canvas_id;
@dynamic content;
@dynamic active_flag;
@dynamic create_user;
@dynamic create_date;
@dynamic display_name;

+ (NSString *)defaultSortAttribute {
    return @"content_id";
}

@end
