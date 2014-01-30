//
//  Person.h
//  FootBook
//
//  Created by Stephen Compton on 1/29/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Profile;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *profile;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addProfileObject:(Profile *)value;
- (void)removeProfileObject:(Profile *)value;
- (void)addProfile:(NSSet *)values;
- (void)removeProfile:(NSSet *)values;

@end
