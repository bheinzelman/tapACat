//
//  GameDataStore.h
//  tapACat
//
//  Created by Bert Heinzelman on 8/17/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameDataItem.h"

@interface GameDataStore : NSObject
@property (nonatomic) GameDataItem* stats;
-(BOOL)saveChanges;
@end
