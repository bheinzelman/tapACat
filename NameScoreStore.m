//
//  NameScoreStore.m
//  NameScore
//
//  Created by Bert Heinzelman on 6/26/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import "NameScoreStore.h"
#import "NameScoreItem.h"


@interface NameScoreStore ()
@property (nonatomic) NSMutableArray* highScores;
@end

@implementation NameScoreStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString* path = [self itemArchivePath];
        _highScores = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_highScores) {
            _highScores = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (BOOL)isFull
{
    if (self.highScores.count == 10) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)addNewScoreCheck:(int)score
{
    int i = 0;
    if (!(self.isFull)) {
        //[self removeWorstScore];
        return  YES;
    }
    while (i < 10) {
        NameScoreItem* x = _highScores[i];
        if (score > x.getScore) {
            //[self removeWorstScore];
            return YES;
        }
        i++;
    }
    return NO;
}

- (NameScoreItem*)addItem:(NameScoreItem*)nameScore

{
    if (!self.isFull) {
        [self.highScores addObject:nameScore];
        return nameScore;
    }
    return nil;
}

- (NameScoreItem*)getItemAtIndex:(int)index
{
    return self.highScores[index];
}

-(void)printScores
{
    int i = 0;
    while (i < self.highScores.count) {
        NameScoreItem* nameScore = self.highScores[i];
        NSLog(@"Name: %@ \n", nameScore.getName);
        NSLog(@"Score: %i \n",nameScore.getScore);
        i++;
    }
}

- (void)removeWorstScore
{
    NameScoreItem* least = self.highScores[0];
    int i = 1;
    while (i < self.highScores.count) {
        NameScoreItem* item = self.highScores[i];
        if ([least getScore] > [item getScore]) {
            least = item;
        }
        i++;
    }
    [self.highScores removeObject:least];
}

- (NSUInteger)count
{
    return [self.highScores count];
}



- (NSString*)itemArchivePath
{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories firstObject];

    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}


-(BOOL)saveChanges
{
    NSString* path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.highScores toFile:path];
}
@end
