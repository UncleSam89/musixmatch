//
//  PlayViewController.h
//  musixmatch
//
//  Created by Samuele De Giuseppe on 30/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *currentWords;
@property (nonatomic, strong) NSMutableArray *currentButtons;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

-(void) createButtons;
-(void) closeGame;

@end
