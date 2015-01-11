//
//  ViewController.m
//  TicTacToe
//
//  Created by Aaron Bradley on 1/8/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property CGPoint originalCenter;
@property CGPoint dragPoint;

@property NSTimer *gameTimer;
@property int gameTimerStatus;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;


@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.playerX = @"X";
    self.playerO = @"O";
    self.theCat = @"THE CAT";
    self.xWins = @"XXX";
    self.oWins = @"OOO";

//    [self resetTimer];
    self.winningCombinations = @"123_456_789_147_258_369_159_357";



    self.gameTimerStatus = 11;
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown:) userInfo:nil repeats:YES];

    self.labelArray = @[self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine];

    [self resetGame];

}

- (void) resetTimer {
    self.gameTimerStatus = 11;
    [self timerCountdown:self.gameTimer];
}

- (void) timerCountdown:(NSTimer *)timer {

    self.gameTimerStatus--;
    self.timerLabel.text = [NSString stringWithFormat:@"%d", self.gameTimerStatus];

    if (self.gameTimerStatus == 0) {
//        [self stopTimer:self.gameTimer];
        [self togglePlayer];
        [self resetTimer];
        NSLog(@"You took too long");
    }

}


- (void) stopTimer:(NSTimer *)stopTimer {

    [self.gameTimer invalidate];
    self.gameTimer = nil;

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
        self.dragPlay.text = self.playerX;

        self.playerColorToPlace = [UIColor blueColor];
        self.dragLabel.textColor = self.playerColorToPlace;

    } else {

        self.playerStringToPlace = self.playerO;
        self.dragPlay.text = self.playerO;

        self.playerColorToPlace = [UIColor redColor];
        self.dragLabel.textColor = self.playerColorToPlace;

    }

    return currentPlayer;
}


// TOGGLE BETWEEN PLAYERS

- (void) togglePlayer {

    if ([self.playerStringToPlace isEqualToString:self.playerX]) {

        [self makeCurrentPlayer:self.playerO];
        self.whichPlayerLabel.textColor = self.playerColorToPlace;
        self.dragLabel.textColor = self.playerColorToPlace;

    } else {

        [self makeCurrentPlayer:self.playerX];
        self.whichPlayerLabel.textColor = self.playerColorToPlace;
        self.dragLabel.textColor = self.playerColorToPlace;
    }
    [self resetTimer];

}


// DRAG X OR O LABEL, TOGGLE PLAYER, CHECK FOR WIN

- (IBAction)onLabelDrag:(UIPanGestureRecognizer *)sender {

    self.dragPoint = [sender locationInView:self.view];
    self.dragPlay.center = self.dragPoint;
    self.dragPlay.center = self.dragPoint;

    if (sender.state == UIGestureRecognizerStateEnded) {

        for (UILabel *label in self.labelArray) {

            if (CGRectContainsPoint(label.frame, self.dragPlay.center)) {
                label.text = self.playerStringToPlace;
                label.textColor = self.playerColorToPlace;

                [UIView animateWithDuration:.55f animations:^{

                    self.dragPlay.center = self.whichPlayerLabel.center;

                } completion:^(BOOL finished) {

                    if (finished) {

                        self.numberOfMovesMade++;

                        [self checkLabelsForWin:label.text label:label];
                        [self checkForWinner:self.winningCombinations];
                        [self togglePlayer];
                        
                        NSLog(@"%@", self.winningCombinations);
                    }
                }];
            }
        }
    }
}


//  WHEN A PLAYER TAPS AN X OR O

- (IBAction)onBoardLabelTapped:(UITapGestureRecognizer *)sender {

    self.touchLocation = [sender locationInView:self.view];
    [self findLabelUsingPoint:self.touchLocation];

    NSLog(@"%d", self.numberOfMovesMade);
    
}


// FIND THE POINT TAPPED, CHANGE IT'S LABEL TO CURRENT PLAYER'S CHAR, CALL checkLabelsForWins METHOD

- (void)findLabelUsingPoint:(CGPoint)point {

    for (UILabel *label in self.labelArray) {
        if ([label.text isEqualToString:@""]) {

            if (CGRectContainsPoint(label.frame, point)) {
                label.text = self.playerStringToPlace;
                label.textColor = self.playerColorToPlace;

                self.numberOfMovesMade++;

                [self checkLabelsForWin:label.text label:label];
                [self checkForWinner:self.winningCombinations];
                [self togglePlayer];

                NSLog(@"%@", self.winningCombinations);

            }
        }
    }
}


// CHECK LABELS FOR WINNING COMBINATIONS

- (NSString*)checkLabelsForWin:(NSString *)labelText label:(UILabel *)label {

        // A MILLION FREAKIN' IF STATMENTS...DIDN'T WANT TO DO IT THIS CRAPPY WAY, BUT OH WELL

        if (label == self.labelOne) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"1" withString:label.text];

        } else if ([label isEqual: self.labelTwo]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"2" withString:label.text];

        } else if ([label isEqual: self.labelThree]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"3" withString:label.text];

        } else if ([label isEqual: self.labelFour]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"4" withString:label.text];

        } else if ([label isEqual: self.labelFive]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"5" withString:label.text];

        } else if ([label isEqual: self.labelSix]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"6" withString:label.text];

        } else if ([label isEqual: self.labelSeven]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"7" withString:label.text];

        } else if ([label isEqual: self.labelEight]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"8" withString:label.text];

        } else if ([label isEqual: self.labelNine]) {
            self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"9" withString:label.text];

        }

    return self.winningCombinations;
}


// SEE IF SOMEBODY WONNNN

- (void)checkForWinner:(NSString *)whoWon {

    if ([whoWon containsString:self.xWins]) {
        [self displayWinner:self.playerX];

    } else if ([whoWon containsString:self.oWins]) {
        [self displayWinner:self.playerO];

    } else {

        if (self.numberOfMovesMade >= 9) {
            [self displayWinner:self.theCat];
        }
    }
    
}


// ALERT POP UP DISPLAYING THE WINNER

- (void)displayWinner:(NSString *)winner {
//    [self stopTimer:self.gameTimer];


    NSString *playerWinnerMessage = [NSString stringWithFormat:@"%@ WINS! AW YAYEAH!", winner];
    UIAlertView *winnerAlert = [[UIAlertView alloc] initWithTitle:playerWinnerMessage message:nil delegate:self cancelButtonTitle:@"New Game" otherButtonTitles: nil];

    [winnerAlert show];
//    [self resetGame];

}


// AND THEN WHEN THEY DISMISS THE ALERT

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self resetGame];

}


// RESET THE BOARD WHEN PLAYER TAPS THE NEW GAME BUTTON

- (IBAction)onNewGameButtonTapped:(UIButton *)sender {
    [self resetGame];
}


- (void) resetGame {


    self.numberOfMovesMade = 0;
    self.winningCombinations = @"123_456_789_147_258_369_159_357";

    for (UILabel *label in self.labelArray) {
        label.text = @"";
    }

    [self whoGoesFirst];
    [self resetTimer];



}


@end
