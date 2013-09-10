//
//  GameResult.m
//  Matchismo
//
//  Created by Syeda Inamdar on 9/5/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
// part of controler class 

#import "GameResult.h"

@interface GameResult()
@property(readwrite,nonatomic) NSDate *start; // internally set 
@property (readwrite,nonatomic) NSDate *end;
@end

@implementation GameResult
// designated initliziaer

#define ALL_RESULTS_KEY @"GameResult_ALL" // DIRECTLY STORE INTO NSUSER DEFAULTS 
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"

+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}


//convenience initlizaizer
- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}

-(void)synchronize // not a property list
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults=[[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy]; // c/ when pull something otu of userdefault, it's immutable when pull out so need tomake mutable copy since anna update tit
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults=[[NSMutableDictionary alloc] init];
    mutableGameResultsFromUserDefaults[[self.start description]]=[self asPropertyList]; // turns game result into property list
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize]; // make mutable copy/modify/synchronize
    //nsuserdefautlis for own app only 
}


-(id)asPropertyList // b/c can chang in teh future the id
{
    return @{START_KEY: self.start, END_KEY : self.end, SCORE_KEY: @(self.score)}; // define a dictionary AND CAN'T PUT INT DIRECTLY BECAUSE NEED OT MAKE ANUBMER BOU TOF IT
}

-(id) init 
{
    self = [super init]; 
    if (self){
        _start=[NSDate date]; // now
        _end=_start; // not saying self.start = / / not calling the setter because if in initializer,then shouldn't be calling setters and getters nd because assume setters and getters are already fully initialized. so don't call them in it. 
    }
    return self;
}

-(NSTimeInterval) duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

-(void)setScore:(int)score
{
    _score=score;
    self.end=[NSDate date]; // don't use _self because it's a setter as use setter of another property
    [self synchronize];
}

@end
