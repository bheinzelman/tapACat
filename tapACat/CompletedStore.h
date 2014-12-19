//
//  CompletedStore.h
//  tapACat
//
//  Created by Bert Heinzelman on 8/5/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompletedItem.h"

@interface CompletedStore : NSObject
- (BOOL)saveChanges;
- (CompletedItem*)getItemAtIndex:(int)index;
- (NSUInteger)count;
- (void)addItemAtIndex:(int)index item:(CompletedItem*) item;
@end
