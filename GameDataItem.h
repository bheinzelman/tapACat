//
//  GameDataItem.h
//  tapACat
//
//  Created by Bert Heinzelman on 8/17/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDataItem : NSObject <NSCoding>
- (void)addScore:(int)newScore;
- (void)dogTapped;
- (void)gamePlayed;
- (int)getCatsTapped;
- (int)getGamesPlayed;
- (int)getDogsTapped;

@end
