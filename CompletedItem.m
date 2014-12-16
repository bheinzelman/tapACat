//
//  CompletedItem.m
//  tapACat
//
//  Created by Bert Heinzelman on 8/5/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import "CompletedItem.h"

@interface CompletedItem()
@property (nonatomic) BOOL completed;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* theDescription;
@end

@implementation CompletedItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _completed = NO;
    }
    return self;
}

- (BOOL)getBOOL
{
    return self.completed;
}

- (NSString*)getTitle
{
    return self.title;
}

- (NSString*)getDescription
{
    return self.theDescription;
}

- (void)setTRUE
{
    _completed = YES;
}

- (void)setDescription:(NSString*)description
{
    _theDescription = description;
}

- (void)setTitle:(NSString *)theTitle
{
    _title = theTitle;
}



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.completed forKey:@"completed"];
    [aCoder encodeObject:self.theDescription forKey:@"theDescription"];
    [aCoder encodeObject:self.title forKey:@"title"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _completed = [aDecoder decodeBoolForKey:@"completed"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _theDescription = [aDecoder decodeObjectForKey:@"theDescription"];
    }
    return self;
}



@end