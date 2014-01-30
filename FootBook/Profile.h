//
//  Profile.h
//  FootBook
//
//  Created by Stephen Compton on 1/29/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * hairiness;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) Person *person;

@end
