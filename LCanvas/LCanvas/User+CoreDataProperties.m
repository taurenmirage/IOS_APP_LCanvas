//
//  User+CoreDataProperties.m
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/21.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

@dynamic user_id;
@dynamic user_name;
@dynamic password;
@dynamic display_name;
@dynamic active_flag;

+ (NSString *)defaultSortAttribute {
    return @"user_id";
}

@end
