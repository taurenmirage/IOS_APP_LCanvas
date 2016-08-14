//
//  Content+CoreDataProperties.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/21.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Content.h"

NS_ASSUME_NONNULL_BEGIN

@interface Content (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content_id;
@property (nullable, nonatomic, retain) NSString *content_type;
@property (nullable, nonatomic, retain) NSString *canvas_id;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSString *active_flag;
@property (nullable, nonatomic, retain) NSString *create_user;
@property (nullable, nonatomic, retain) NSDate *create_date;
@property (nullable, nonatomic, retain) NSString *display_name;

@end

NS_ASSUME_NONNULL_END
