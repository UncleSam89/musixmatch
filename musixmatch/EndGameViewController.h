//
//  EndGameViewController.h
//  musixmatch
//
//  Created by Samuele De Giuseppe on 02/11/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreTotal;
@property (weak, nonatomic) IBOutlet UILabel *timeTotal;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *searchSongButton;

@property (weak, nonatomic) NSString *time;
@property (weak, nonatomic) NSString *score;


-(IBAction)searchAnotherSong:(id)sender;


@end
