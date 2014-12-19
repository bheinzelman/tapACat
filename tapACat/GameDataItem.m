//
//  GameDataItem.m
//  tapACat
//
//  Created by Bert Heinzelman on 8/17/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import "GameDataItem.h"


@interface GameDataItem()
@property (nonatomic) int gamesPlayed;
@property (nonatomic) int catsTapped;
@property (nonatomic) int dogsTapped;
@end

@implementation GameDataItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gamesPlayed = 0;
        _catsTapped = 0;
        _dogsTapped = 0;
    }
    return self;
}

- (void)addScore:(int)newScore
{
    
    self.catsTapped +=newScore;
}

- (void)dogTapped
{
    self.dogsTapped++;
}

- (void)gamePlayed
{
    self.gamesPlayed++;
}

- (int)getCatsTapped
{
    return self.catsTapped;
}

- (int)getDogsTapped
{
    return self.dogsTapped;
}

- (int)getGamesPlayed
{
    return self.gamesPlayed;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.gamesPlayed forKey:@"gamesPlayed"];
    [aCoder encodeInt:self.catsTapped forKey:@"catsTapped"];
    [aCoder encodeInt:self.dogsTapped forKey:@"dogsTapped"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _gamesPlayed = [aDecoder decodeIntForKey:@"gamesPlayed"];
        _catsTapped = [aDecoder decodeIntForKey:@"catsTapped"];
        _dogsTapped = [aDecoder decodeIntForKey:@"dogsTapped"];
    }
    return self;
}

@end
