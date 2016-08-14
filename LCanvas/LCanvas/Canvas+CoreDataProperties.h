//
//  Canvas+CoreDataProperties.h
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 16/4/16.
//  Copyright © 2016年 Yiwen Fu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Canvas.h"

NS_ASSUME_NONNULL_BEGIN

@interface Canvas (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *active_flag;
@property (nullable, nonatomic, retain) NSString *canvas_description;
@property (nullable, nonatomic, retain) NSString *canvas_id;
@property (nullable, nonatomic, retain) NSString *canvas_title;
@property (nullable, nonatomic, retain) NSDate *create_date;
@property (nullable, nonatomic, retain) NSString *create_user;
@property (nullable, nonatomic, retain) NSString *display_name;
@property (nullable, nonatomic, retain) NSString *editable_flag;
@property (nullable, nonatomic, retain) NSString *open_flag;
@property (nullable, nonatomic, retain) NSString *owner_user;
@property (nullable, nonatomic, retain) NSString *unique_id;
@property (nullable, nonatomic, retain) NSString *model_type;

@end

NS_ASSUME_NONNULL_END
