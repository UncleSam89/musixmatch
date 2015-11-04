//
//  songDetails.h
//  musixmatch
//
//  Created by Samuele De Giuseppe on 29/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface songDetails : UIViewController

@property (nonatomic, strong) NSString *s_trackName;
@property (nonatomic, strong) NSString *s_album;
@property (nonatomic, strong) NSString *s_artist;
@property (nonatomic, strong) NSString *s_id;
@property (nonatomic, strong) NSString *s_lyrics;
@property (nonatomic, strong) NSData *s_img;
@property (nonatomic, strong) NSMutableArray *splittedText;

-(void) retrieveLyrics;
- (IBAction) startGame;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *trackName;
@property (weak, nonatomic) IBOutlet UILabel *album;
@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (strong, nonatomic) IBOutlet UIView *difficultyLabel;

@end
