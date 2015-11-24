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
@property (nonatomic, strong) NSData *final_img;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bck_label;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

-(void) createButtons;
-(void) closeGame;

@end
