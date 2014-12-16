//
//  NameScoreItem.m
//  NameScore
//
//  Created by Bert Heinzelman on 6/26/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import "NameScoreItem.h"

@interface NameScoreItem()
@property (nonatomic) NSString* name;
@property (nonatomic) int score;
@end

@implementation NameScoreItem

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return  self;
}

- (void)setName:(NSString *)name
{
    _name = name;
}

- (void)setScore:(int)score
{
    _score = score;
}

- (int)getScore
{
    return self.score;
}

- (NSString*)getName
{
    if (self.name != nil) {
        return self.name;
    }
    return  nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.score forKey:@"score"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _score = [aDecoder decodeIntForKey:@"score"];
        _name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
