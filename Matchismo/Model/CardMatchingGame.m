//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Syeda Inamdar on 8/27/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
//class extension b/c private property
@property(strong,nonatomic) NSMutableArray *cards; // class Card objects in array
@property(nonatomic) int score; // setter generated
//@property(strong,nonatomic) NSString *result;

@end

@implementation CardMatchingGame

//lazy instantiation 
-(NSMutableArray *) cards{
    if (!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self =[super init]; // check for nil 
    if (self){ // why count not work here?
        for (int i=0; i <count; i++){
            Card *card =[deck drawRandomCard];
            if (!card){
                self=nil;
            } else {
                self.cards[i] = card;
            }
        }
        
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{   // if                             do                   else 
    return (index<self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4 // hwk try to by configurable if want 
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

//guts of card matching game
- (void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable){
        if (!card.isFaceUp){ // make sure card is faced up to check 
            // see if flipping this card creates a match
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]]; // @[] is array
                    if (matchScore){
                        card.unplayable= YES; // faceup
                        otherCard.unplayable=YES; // faceup
                        self.score+=matchScore * MATCH_BONUS;
                       // self.resultLabel.text=[NSString stringWithFormat:@"Flipped up: %@ ",self.cards.contents];
                    } else {
                        otherCard.faceUp=NO; // turn facedown
                        self.score-=MISMATCH_PENALTY;
                    }
                    
                }
            }
            self.score -= FLIP_COST;
        }
         card.faceUp=!card.isFaceUp;
        self.result=card.contents;
    }
    
    
}




@end
