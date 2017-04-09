//
//  Share+CoreDataProperties.h
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/3/5.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "Share+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Share (CoreDataProperties)

+ (NSFetchRequest<Share *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *canvas_id;
@property (nullable, nonatomic, copy) NSString *canvas_description;
@property (nullable, nonatomic, copy) NSString *model_type;
@property (nullable, nonatomic, copy) NSString *owner_user;
@property (nullable, nonatomic, copy) NSString *canvas_title;

@end

NS_ASSUME_NONNULL_END
