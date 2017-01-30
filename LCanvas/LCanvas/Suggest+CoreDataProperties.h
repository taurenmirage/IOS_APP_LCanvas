//
//  Suggest+CoreDataProperties.h
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/1/15.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "Suggest+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Suggest (CoreDataProperties)

+ (NSFetchRequest<Suggest *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *suggest_id;
@property (nullable, nonatomic, copy) NSString *content_type;
@property (nullable, nonatomic, copy) NSString *priority;
@property (nullable, nonatomic, copy) NSString *suggest_type;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *active_flag;

@end

NS_ASSUME_NONNULL_END
