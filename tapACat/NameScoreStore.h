//
//  NameScoreStore.h
//  NameScore
//
//  Created by Bert Heinzelman on 6/26/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NameScoreItem.h"


@interface NameScoreStore : NSObject


- (BOOL)saveChanges;
- (BOOL)addNewScoreCheck: (int) score;
- (BOOL)isFull;
- (NameScoreItem*)addItem:(NameScoreItem*)nameScore;
- (NameScoreItem*)getItemAtIndex: (int)index;
- (void)printScores;
- (void)removeWorstScore;
- (NSUInteger)count;
@end
