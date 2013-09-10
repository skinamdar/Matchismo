//
//  Deck.m
//  Test
//
//  Created by Syeda Inamdar on 8/20/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property(strong,nonatomic) NSMutableArray *cards; // of Card and can change array

@end
@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards)_cards=[[NSMutableArray alloc] init];
        return _cards;
}// lazy instantiation

- (void)addCard:(Card *) card atTop:(BOOL)atTop
{ // add self.card as a check?
  //  if (self.cards){
        if (atTop){
            [self.cards insertObject:card atIndex:0];
        }else {
            [self.cards addObject:card];
        }
    //}
}

-(Card *)drawRandomCard
{
    Card  *randomCard=nil;
    // nil doesn't point to anything. and local vars start at 0;
    
    if (self.cards.count){
        unsigned index=arc4random()% self.cards.count;
        randomCard=self.cards[index];
        [self.cards removeObjectAtIndex:index];
        
    }
    
    return randomCard;
    
    
}
@end
