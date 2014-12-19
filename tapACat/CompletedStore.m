//
//  CompletedStore.m
//  tapACat
//
//  Created by Bert Heinzelman on 8/5/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import "CompletedStore.h"

@interface CompletedStore()
@property (nonatomic) NSMutableArray* completedArray;
@end

@implementation CompletedStore

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSString* path = [self itemArchivePath];
        _completedArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_completedArray)
        {
            NSMutableArray* temp = [[NSMutableArray alloc] init];
            CompletedItem* acheivement1 = [[CompletedItem alloc] init];
            [acheivement1 setTitle:@"Wolf Pack"];
            [acheivement1 setDescription:@"Reach Level 5"];
            [temp addObject:acheivement1];
            CompletedItem* acheivement2 = [[CompletedItem alloc] init];
            [acheivement2 setTitle:@"Nine Lives"];
            [acheivement2 setDescription:@"Reach Level 9"];
            [temp addObject:acheivement2];
            CompletedItem* acheivement3 = [[CompletedItem alloc] init];
            [acheivement3 setTitle:@"Dog Gone It"];
            [acheivement3 setDescription:@"Reach Level 12"];
            [temp addObject:acheivement3];
            CompletedItem* acheivement4 = [[CompletedItem alloc] init];
            [acheivement4 setTitle:@"Cat Tapper"];
            [acheivement4 setDescription:@"Tap 100 Cats in one Game"];
            [temp addObject:acheivement4];
            CompletedItem* acheivement5 = [[CompletedItem alloc] init];
            [acheivement5 setTitle:@"Silver Cat Tapper"];
            [acheivement5 setDescription:@"Tap 250 Cats in one Game"];
            [temp addObject:acheivement5];
            CompletedItem* acheivement6 = [[CompletedItem alloc] init];
            [acheivement6 setTitle:@"Gold Cat Tapper"];
            [acheivement6 setDescription:@"Tap 500 Cats in one Game"];
            [temp addObject:acheivement6];
            CompletedItem* acheivement7 = [[CompletedItem alloc] init];
            [acheivement7 setTitle:@"Platnum Cat Tapper"];
            [acheivement7 setDescription:@"Tap 750 Cats in one Game"];
            [temp addObject:acheivement7];
            CompletedItem* acheivement8 = [[CompletedItem alloc] init];
            [acheivement8 setTitle:@"You've Got to be Kitten Me"];
            [acheivement8 setDescription:@"Tap 5000 Cats Total"];
            [temp addObject:acheivement8];
            CompletedItem* acheivement9 = [[CompletedItem alloc] init];
            [acheivement9 setTitle:@"tapACat Master"];
            [acheivement9 setDescription:@"Tap 10,000 Cats Total"];
            [temp addObject:acheivement9];
            CompletedItem* achievement10 = [[CompletedItem alloc] init];
            [achievement10 setTitle:@"You have been Woofed"];
            [achievement10 setDescription:@"Tap 100 Dogs Total"];
            [temp addObject:achievement10];
            CompletedItem* achievement11 = [[CompletedItem alloc] init];
            [achievement11 setTitle:@"Bow Wow"];
            [achievement11 setDescription:@"Tap 1000 Dogs"];
            [temp addObject:achievement11];
            CompletedItem* achievement12 = [[CompletedItem alloc] init];
            [achievement12 setTitle:@"Master of Games"];
            [achievement12 setDescription:@"Play 1000 Games"];
            [temp addObject:achievement12];
            _completedArray = temp;
            [self saveChanges];
            
        }
    }
    return self;
}

- (CompletedItem*)getItemAtIndex:(int)index
{
    CompletedItem* theItem = self.completedArray[index];
    return theItem;
}


- (void)addItemAtIndex:(int)index item:(CompletedItem*) item
{
    self.completedArray[index] = item;
}


- (NSString*)itemArchivePath
{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"BOOLS.archive"];
}


-(BOOL)saveChanges
{
    NSString* path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.completedArray toFile:path];
}

- (NSUInteger)count
{
    return [self.completedArray count];
}

@end
