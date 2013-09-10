//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Syeda Inamdar on 8/20/13.
//  Copyright (c) 2013 Syeda Inamdar. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

#import "PlayingCard.h"
#import "GameResult.h"

@interface CardGameViewController ()//private
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//outlet connection is automatically strong because view points strongly to buttons inside array, but not points to aray itself(only controller will) and don't use o.c. if order matters
@property(strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel; //prints resutls on screen
@property (nonatomic) UIImage *cardBackImage ;
@property (strong,nonatomic) GameResult *gameResult;

@end

@implementation CardGameViewController
-(GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc ] init];
    return _gameResult; 
   
}



- (IBAction)cardBackColorControl:(UISegmentedControl *)sender;
{
    if (sender.selectedSegmentIndex==0){
        NSLog(@"index 0");
        self.cardBackImage=[UIImage imageNamed:@"redCardBack.jpg"];
        [self updateUI];

        
    }
    if (sender.selectedSegmentIndex==1){
        NSLog(@"index 1");
        self.cardBackImage=[UIImage imageNamed:@"blueCardBack.jpg"];
        [self updateUI];

    }

    
    
}

- (IBAction)dealButton:(UIButton *)sender // resets the game
{
    sender.selected=!sender.isSelected;
    
    //self.game.result=@" ";
    
    self.game=nil;
    self.gameResult=nil;
    self.flipCount=0;
    [self updateUI];
    self.resultLabel.text=[NSString stringWithFormat:@"Result"];

    

   
    
    
    
    
}


-(CardMatchingGame *) game{
    if (!_game) _game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    return _game; // not self.deck b/c not use deck, just use model to deal w/ it.
}


-(void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons=cardButtons;//setter because @property
    [self updateUI]; // match the model
}

-(void)updateUI{ // makes ui look like the model
    for (UIButton *cardButton in self.cardButtons){
        Card *card =[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]]; // array of buttons maps to card index
        
       

        cardButton.selected=card.isFaceUp;
        cardButton.enabled =!card.isUnplayable;
        // transparent if unplayable 
        cardButton.alpha=(card.isUnplayable ? 0.3 : 1.0);
        
        if(!cardButton.isSelected){ // new cardBack image
         //   UIImage *cardBackImage=[UIImage imageNamed:@"blueCardBack.jpg"];
            [cardButton setImage:self.cardBackImage forState:UIControlStateNormal];
        }
        else{
            [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected];
            [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateDisabled];
            [cardButton setTitle:card.contents forState:UIControlStateSelected];
            [cardButton setTitle:card.contents forState:UIControlStateSelected| UIControlStateDisabled];
            
        }
        
        
        
        self.resultLabel.text=[NSString stringWithFormat:@"Flipped up: %@ ",self.game.result];
       
    }
    self.scoreLabel.text=[NSString stringWithFormat: @"Score : %d", self.game.score];
    
    
}


-(void)setFlipCount:(int)flipCount // used internally and not on model 
{
    _flipCount=flipCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d",self.flipCount];
    self.gameResult.score=self.game.score;
}
// return type void w/ one argument as the buton 
- (IBAction)flipCard:(UIButton *)sender
{
    /*if (sender.isSelected) {
        sender.selected=NO;
    } else {
        sender.selected=YES; 
    }
    */
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]]; // 0 to 12
    self.flipCount++; // gettr and setter in one line
    [self updateUI];
}


@end

