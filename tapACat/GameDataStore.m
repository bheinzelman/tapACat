//
//  GameDataStore.m
//  tapACat
//
//  Created by Bert Heinzelman on 8/17/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import "GameDataStore.h"
#import "GameDataItem.h"

@implementation GameDataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString* path = [self itemArchivePath];
        _stats = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_stats) {
            _stats = [[GameDataItem alloc] init];
        }
    }
    return self;
}

- (NSString*)itemArchivePath
{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"STATS.archive"];
}


-(BOOL)saveChanges
{
    NSString* path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.stats toFile:path];
}
@end
