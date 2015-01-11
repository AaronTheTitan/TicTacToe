//
//  ViewController.m
//  TicTacToe
//
//  Created by Aaron Bradley on 1/8/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>


@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

//    self.winningCombinations = @"123_456_789_147_258_369_159_357";
    self.playerX = @"X";
    self.playerO = @"O";
    self.theCat = @"THE CAT";
    self.xWins = @"XXX";
    self.oWins = @"OOO";

    self.labelArray = @[self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine];

    [self labelLocations];
//    [self whoGoesFirst];
    [self resetGame];

}


- (void)labelLocations {

    self.labelOneLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelOne.frame.origin]);
    self.labelTwoLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelTwo.frame.origin]);
    self.labelThreeLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelThree.frame.origin]);
    self.labelFourLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelThree.frame.origin]);
    self.labelFiveLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelFive.frame.origin]);
    self.labelSixLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelSix.frame.origin]);
    self.labelSevenLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelSeven.frame.origin]);
    self.labelEightLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelEight.frame.origin]);
    self.labelNineLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.labelNine.frame.origin]);

    self.whichPlayerLabelLocation = NSStringFromCGPoint([self findLabelUsingPoint:self.whichPlayerLabel.frame.origin]);

}



// RESET THE BOARD WHEN PLAYER TAPS THE NEW GAME BUTTON

- (IBAction)onNewGameButtonTapped:(UIButton *)sender {

    [self resetGame];

//    [self whoGoesFirst];
//    self.winningCombinations = @"123_456_789_147_258_369_159_357";
//
//    for (UILabel *label in self.labelArray) {
//        label.text = @"";
//    }
}


// FLIP A COIN TO SEE WHO GOES FIRST
- (NSString *)whoGoesFirst {
    self.coinFlip = arc4random_uniform(2);

    if (self.coinFlip == 1) {
        [self makeCurrentPlayer:self.playerX];

    } else {
        [self makeCurrentPlayer:self.playerO];
    }
    self.whichPlayerLabel.textColor = self.playerColorToPlace;

    return self.playerStringToPlace;
}



// GET ARGUMENT FOR CURRENT PLAYER AND SET THE BOARD FOR THAT PLAYER
- (NSString *)makeCurrentPlayer:(NSString *)currentPlayer {

    if ([currentPlayer isEqualToString:self.playerX]) {

        self.playerStringToPlace = self.playerX;
        self.whichPlayerLabel.text = self.playerX;
        self.playerColorToPlace = [UIColor blueColor];

    } else {

        self.playerStringToPlace = self.playerO;
        self.whichPlayerLabel.text = self.playerO;
        self.playerColorToPlace = [UIColor redColor];

    }

    return currentPlayer;
}


// TOGGLE BETWEEN PLAYERS
- (void) togglePlayer {

    if ([self.playerStringToPlace isEqualToString:self.playerX]) {
        [self makeCurrentPlayer:self.playerO];
        self.whichPlayerLabel.textColor = self.playerColorToPlace;


    } else {
        [self makeCurrentPlayer:self.playerX];
        self.whichPlayerLabel.textColor = self.playerColorToPlace;

    }
}


- (IBAction)onBoardLabelTapped:(UITapGestureRecognizer *)sender {

    self.touchLocation = [sender locationInView:self.view];
    [self findLabelUsingPoint:self.touchLocation];

    self.numberOfMovesMade++;
    NSLog(@"%d", self.numberOfMovesMade);
    
}


// Find point of tapped square, convert to string location, send string as argument to checkForWinner method
- (CGPoint)findLabelUsingPoint:(CGPoint)point {

    for (UILabel *label in self.labelArray) {
        if ([label.text isEqualToString:@""]) {

            if (CGRectContainsPoint(label.frame, point)) {
                label.text = self.playerStringToPlace;
                label.textColor = self.playerColorToPlace;


                [self checkLabels:label.text label:label];
                NSLog(@"%@", self.winningCombinations);

                [self togglePlayer];

                //SENDING THE POINT AS A STRING TO checkForWinner
//                [self checkTappedPoint:NSStringFromCGPoint([self findLabelUsingPoint:label.frame.origin])];
            }
        }
    }

    return point;

}


// SEE IF SOMEBODY WONNNN

- (void)checkForWinner:(NSString *)whoWon {

    if ([whoWon containsString:self.xWins]) {
        [self displayWinner:self.playerX];

    } else if ([whoWon containsString:self.oWins]) {
        [self displayWinner:self.playerO];

    } else if ((self.numberOfMovesMade > 8) && (![whoWon containsString:self.xWins] || ![whoWon containsString:self.oWins])) {
        [self displayWinner:self.theCat];
        NSLog(@"%@ wins", self.theCat);

    }

}


// ALERT POP UP DISPLAYING THE WINNER

- (void)displayWinner:(NSString *)winner {

    NSString *playerWinnerMessage = [NSString stringWithFormat:@"%@ WINS! AWWWW YAAAAYYEEAA!", winner];
    UIAlertView *winnerAlert = [[UIAlertView alloc] initWithTitle:playerWinnerMessage message:nil delegate:self cancelButtonTitle:@"New Game" otherButtonTitles: nil];

    [winnerAlert show];

}

// AND THEN WHEN THEY DISMISS THE ALERT

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self resetGame];
}




// CHECK LABELS FOR WINNING COMBINATIONS

- (NSString *)checkLabels:(NSString *)labelText label:(UILabel *)label {

    NSLog(@"Current label is %@", labelText);


    if ([labelText isEqualToString:self.playerX]) {
        NSLog(@"playerX");

        // A MILLION FREAKIN' IF STATMENTS...DIDN'T WANT TO DO IT THIS CRAPPY WAY, BUT OH WELL

        if ([label isEqual: self.labelOne]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"1" withString:self.playerX];

        } else if ([label isEqual: self.labelTwo]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"2" withString:self.playerX];

        } else if ([label isEqual: self.labelThree]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"3" withString:self.playerX];

        } else if ([label isEqual: self.labelFour]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"4" withString:self.playerX];

        } else if ([label isEqual: self.labelFive]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"5" withString:self.playerX];

        } else if ([label isEqual: self.labelSix]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"6" withString:self.playerX];

        } else if ([label isEqual: self.labelSeven]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"7" withString:self.playerX];

        } else if ([label isEqual: self.labelEight]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"8" withString:self.playerX];

        } else if ([label isEqual: self.labelNine]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"9" withString:self.playerX];

        }


    } else if ([labelText isEqualToString:self.playerO]) {
        NSLog(@"playerO");

        if ([label isEqual: self.labelOne]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"1" withString:self.playerO];

        } else if ([label isEqual: self.labelTwo]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"2" withString:self.playerO];

        } else if ([label isEqual: self.labelThree]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"3" withString:self.playerO];

        } else if ([label isEqual: self.labelFour]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"4" withString:self.playerO];

        } else if ([label isEqual: self.labelFive]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"5" withString:self.playerO];

        } else if ([label isEqual: self.labelSix]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"6" withString:self.playerO];

        } else if ([label isEqual: self.labelSeven]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"7" withString:self.playerO];

        } else if ([label isEqual: self.labelEight]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"8" withString:self.playerO];
            
        } else if ([label isEqual: self.labelNine]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"8" withString:self.playerO];

        }


    } else {
        NSLog(@"Noboddyyy");

    }

    [self checkForWinner:self.winningCombinations];
    return self.winningCombinations;
}

- (void) resetGame {

    self.numberOfMovesMade = 0;
    self.winningCombinations = @"123_456_789_147_258_369_159_357";

    for (UILabel *label in self.labelArray) {
        label.text = @"";
    }

    [self whoGoesFirst];

}


@end
