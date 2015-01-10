//
//  ViewController.m
//  TicTacToe
//
//  Created by Aaron Bradley on 1/8/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelOne;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) IBOutlet UILabel *labelFour;
@property (strong, nonatomic) IBOutlet UILabel *labelFive;
@property (strong, nonatomic) IBOutlet UILabel *labelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UILabel *labelEight;
@property (strong, nonatomic) IBOutlet UILabel *labelNine;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@property NSString *whoWon;

@property NSString *playerX;
@property NSString *playerO;
@property NSString *playerStringToPlace;
@property UIColor *playerColorToPlace;
@property UIColor *resetLabelColors;

@property int coinFlip;

@property NSArray *labelArray;
@property NSArray *labelLocationArray;
@property CGPoint touchLocation;

@property NSString *labelOneLocation;
@property NSString *labelTwoLocation;
@property NSString *labelThreeLocation;
@property NSString *labelFourLocation;
@property NSString *labelFiveLocation;
@property NSString *labelSixLocation;
@property NSString *labelSevenLocation;
@property NSString *labelEightLocation;
@property NSString *labelNineLocation;
@property NSString *whichPlayerLabelLocation;


@property NSMutableArray *xMovesArray;
@property NSMutableArray *oMovesArray;

@property NSArray *winningComboOne;
@property NSArray *winningComboTwo;
@property NSArray *winningComboThree;
@property NSArray *winningComboFour;
@property NSArray *winningComboFive;
@property NSArray *winningComboSix;
@property NSArray *winningComboSeven;
@property NSArray *winningComboEight;

@property NSArray *winningComboArray;




@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.playerX = @"X";
    self.playerO = @"O";

    [self labelLocations];
    [self winningCombinations];
    self.resetLabelColors = [UIColor whiteColor];

    self.labelArray = @[self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine];

    [self whoGoesFirst];

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

- (void) winningCombinations {

    self.winningComboOne = @[self.labelOneLocation, self.labelTwoLocation,self.labelThreeLocation];
    self.winningComboTwo = @[self.labelFourLocation, self.labelFiveLocation, self.labelSixLocation];
    self.winningComboThree = @[self.labelSevenLocation, self.labelEightLocation, self.labelNineLocation];
    self.winningComboFour = @[self.labelOneLocation, self.labelFourLocation, self.labelSevenLocation];
    self.winningComboFive = @[self.labelTwo, self.labelFiveLocation, self.labelEightLocation];
    self.winningComboSix = @[self.labelThreeLocation, self.labelSixLocation, self.labelNineLocation];
    self.winningComboSeven = @[self.labelOneLocation, self.labelFiveLocation, self.labelNineLocation];
    self.winningComboEight = @[self.labelThreeLocation, self.labelFiveLocation, self.labelSevenLocation];

    self.winningComboArray = @[self.winningComboOne, self.winningComboTwo, self.winningComboThree, self.winningComboFour, self.winningComboFive, self.winningComboSix, self.winningComboSeven, self.winningComboEight];

}


// FLIP A COIN TO SEE WHO GOES FIRST
- (NSString *)whoGoesFirst{
    self.coinFlip = arc4random_uniform(2);

    if (self.coinFlip == 1) {
        [self makeCurrentPlayer:self.playerX];

    } else {
        [self makeCurrentPlayer:self.playerO];
    }
    self.whichPlayerLabel.backgroundColor = self.playerColorToPlace;

    return self.playerStringToPlace;
}



// GET ARGUMENT FOR CURRENT PLAYER AND SET THE BOARD FOR THAT PLAYER
- (NSString *)makeCurrentPlayer:currentPlayer {
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
        self.whichPlayerLabel.backgroundColor = self.playerColorToPlace;


    } else {
        [self makeCurrentPlayer:self.playerX];
        self.whichPlayerLabel.backgroundColor = self.playerColorToPlace;

    }
}


- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender {

    self.touchLocation = [sender locationInView:self.view];
    [self findLabelUsingPoint:self.touchLocation];
    
}


// Find point of tapped square, convert to string location, send string as argument to checkForWinner method
- (CGPoint)findLabelUsingPoint:(CGPoint)point {

    for (UILabel *label in self.labelArray) {
        if ([label.text isEqualToString:@""]) {

            if (CGRectContainsPoint(label.frame, self.touchLocation)) {
                label.text = self.playerStringToPlace;
                label.backgroundColor = self.playerColorToPlace;

//                [self findLabelUsingPoint:label.frame.origin];
//                NSLog(@"Label Location is %@", NSStringFromCGPoint([self findLabelUsingPoint:label.frame.origin]));

                [self togglePlayer];

                //SENDING THE POINT AS A STRING TO checkForWinner
                [self checkForWinner:NSStringFromCGPoint([self findLabelUsingPoint:label.frame.origin])];
            }
        }
    }


    // add a point to an NSMutable array
    return point;

}


// Take incoming string location parameter, check to see if it matches a point location for an X or O
- (void)checkForWinner:(NSString *)labelPoint {
    NSLog(@"Label Location is %@", labelPoint);


//    for (UILabel *label in self.labelArray) {
//        if ([label.text isEqualToString:self.playerX]) {
//            if ([labelPoint isEqualToString:]) {
//
//            }
//        }
//    }
}






////    if (//there is a winner) {
////        [self displayWinner];
////    }
//}


- (void)displayWinner {

    NSString *winner;
    NSString *winnerMessage = [NSString stringWithFormat:@"%@ WINS! AWWWW YAAAAYYEEAA!", winner];

    UIAlertView *winnerAlert = [[UIAlertView alloc] initWithTitle:winnerMessage message:nil delegate:self cancelButtonTitle:@"Thanks!" otherButtonTitles: nil];

    [winnerAlert show];
}


- (IBAction)onNewGameButtonTapped:(UIButton *)sender {

        for (UILabel *label in self.labelArray) {
            label.text = @"";
            label.backgroundColor = self.resetLabelColors;
    }

    [self whoGoesFirst];
}

@end
