//
//  HelpViewController.m
//  TicTacToe
//
//  Created by Aaron Bradley on 1/10/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHelp];




}

- (void)loadHelp {
    NSURL *loadHelpURL = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Tic-tac-toe"];
    NSURLRequest *helpRequest = [NSURLRequest requestWithURL:loadHelpURL];
    [self.webView loadRequest:helpRequest];


}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activitySpinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activitySpinner stopAnimating];
}
@end
