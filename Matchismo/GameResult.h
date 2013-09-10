//
//  GameResult.h
//  Matchismo
//
//  Created by Syeda Inamdar on 9/5/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

-(NSArray *)allGameResults; // ofGameResult

@property (readonly, nonatomic) NSDate *start;
@property (readonly,nonatomic) NSDate *end;
@property (nonatomic) NSTimeInterval duration;
@property(nonatomic) int score;



@end
