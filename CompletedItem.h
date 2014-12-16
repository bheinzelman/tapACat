//
//  CompletedItem.h
//  tapACat
//
//  Created by Bert Heinzelman on 8/5/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompletedItem: NSObject <NSCoding>
- (BOOL)getBOOL;
- (void)setTRUE;
- (NSString*)getTitle;
- (NSString*)getDescription;
- (void)setTitle:(NSString*)theTitle;
- (void)setDescription:(NSString*)description;

@end