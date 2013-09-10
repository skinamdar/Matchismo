//
//  PlayingCard.m
//  Test
//
//  Created by Syeda Inamdar on 8/20/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import "PlayingCard.h"
 
@implementation PlayingCard
-(int)match:(NSArray *) otherCards{
    int score=0;
    
    if ([otherCards count] == 1)//match against once other card
    {
        id otherCard=[otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]){
            PlayingCard *otherPlayingCard=(PlayingCard *)otherCard;
            if ([otherPlayingCard.suit isEqualToString:self.suit]){
                score =1;
            }else if (otherPlayingCard.rank==self.rank){
                score=4; 
            }
        }
    }
    return score; // default is return 0 if it doesn't match suit/rank/class
}


- (NSString *) contents
{
    // returns A of hearts
    //@[] makes array onthe fly
    //all objects in objC is allocated on the heap
    NSArray *rankStrings=@[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    
    // not very effective
    //return[NSString stringWithFormat:@"%d%@",self.rank,self.suit]; //@ prints object
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit; // b/c we provide setter and getter
+ (NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

// - sent to instance card
// object method sent to the class through + for utility method/allocae initialize a certain way.

- (void)setSuit:(NSString *) suit
{// not open square bracket pointer for object
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit=suit;
    }
}
- (NSString *) suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank {return [self rankStrings].count -1;}
- (void)setRank:(NSUInteger)rank
{
    if(rank<=[PlayingCard maxRank]) {
        _rank=rank;
    }
}

@end
