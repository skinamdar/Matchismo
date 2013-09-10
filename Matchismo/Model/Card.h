//
//  Card.h
//  Test
//
//  Created by Syeda Inamdar on 8/20/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;

@property (nonatomic,getter = isFaceUp) BOOL faceUp;
@property (nonatomic,getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
