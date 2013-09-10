//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Syeda Inamdar on 8/27/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject//specifies what the class is responsible for doing

//designated initializer (all depends on this) and is legally initialized when called 
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck; // never initilize old stuff

-(void)flipCardAtIndex:(NSUInteger) index;

-(Card *) cardAtIndex: (NSUInteger)index;

@property (nonatomic,readonly) int score; // so user can't alter score
@property(strong,nonatomic) NSString *result;



@end
