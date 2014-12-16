//
//  NameScoreItem.h
//  NameScore
//
//  Created by Bert Heinzelman on 6/26/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameScoreItem : NSObject <NSCoding>

- (void)setName:(NSString *)name;
- (void)setScore:(int)score;
- (int)getScore;
- (NSString*)getName;


@end
