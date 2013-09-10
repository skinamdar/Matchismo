//
//  PlayingCardDeck.m
//  Test
//
//  Created by Syeda Inamdar on 8/20/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck
// id means pointer to object to any class
// have initilizers return id
- (id)init
{
    self=[super init];
    //superclass allowed to return nill if not initialize
    
    if(self){
        //initializes the class
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank=1; rank<=[PlayingCard maxRank]; rank++){
                PlayingCard *card=[[PlayingCard alloc] init];
                card.rank=rank;
                card.suit=suit;
                [self addCard:card atTop:YES];
                
                
            }
        }
        
        
    }
    
    return self;
    
}

@end

