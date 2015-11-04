//
//  EndGameViewController.m
//  musixmatch
//
//  Created by Samuele De Giuseppe on 02/11/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import "EndGameViewController.h"

@interface EndGameViewController ()

@end

@implementation EndGameViewController
@synthesize playAgainButton;
@synthesize searchSongButton;
@synthesize scoreTotal;
@synthesize timeTotal;
@synthesize time;
@synthesize score;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    timeTotal.text = time;
    scoreTotal.text = score;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(IBAction)searchAnotherSong:(id)sender
{
    [self performSegueWithIdentifier:@"searchSong" sender:nil];
}




@end
