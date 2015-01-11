//
//  ViewController.h
//  TicTacToe
//
//  Created by Aaron Bradley on 1/8/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


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
@property (strong, nonatomic) IBOutlet UILabel *dragLabel;

@property (strong, nonatomic) IBOutlet UILabel *dragPlay;


@property (nonatomic)  NSString *whoWon;

@property NSString *playerX;
@property NSString *playerO;
@property NSString *theCat;
@property NSString *playerStringToPlace;
@property UIColor *playerColorToPlace;


@property int coinFlip;
@property int numberOfMovesMade;

@property NSArray *labelArray;
@property CGPoint touchLocation;

@property NSString *xWins;
@property NSString *oWins;

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

@property NSString *winningCombinations;

@end

