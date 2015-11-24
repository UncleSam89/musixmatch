//
//  PlayViewController.m
//  musixmatch
//
//  Created by Samuele De Giuseppe on 30/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import "PlayViewController.h"
#import "EndGameViewController.h"

@interface PlayViewController ()

@end
@implementation PlayViewController
{
    NSInteger counter, score;
    NSMutableArray *rndP;
    int seconds;
    int minutes;
    NSTimer *t;
    int pivot;

    NSMutableArray *currentWordsBackUp;
}
@synthesize currentWords;
@synthesize currentButtons;
@synthesize scoreLabel;
@synthesize timeLabel;
@synthesize final_img;
@synthesize bck_label;
@synthesize progressBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    [bck_label setBackgroundColor:[[UIColor colorWithPatternImage:[UIImage imageWithData:final_img]] colorWithAlphaComponent:0.5f]];
    progressBar.progress = 0.0f;
    [progressBar setTransform:CGAffineTransformMakeScale(1.0, 3.0)];
    seconds = 0;
    minutes = 0;
    counter = 0;
    score = 0;
    currentButtons = [[NSMutableArray alloc] init];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    currentWordsBackUp = [[NSMutableArray alloc] initWithArray:currentWords copyItems:YES];
    t=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimer) userInfo:nil repeats:YES];
    
    [self createButtons];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    currentWords = [[NSMutableArray alloc] initWithArray:currentWordsBackUp copyItems:YES];
    for(UIButton *b in currentButtons)
        [b removeFromSuperview];
    [self reloadInputViews];

}



-(void)showTimer{

    seconds++;
    if(seconds>=59)
    {
        seconds=0;
        minutes++;
    }
    
    timeLabel.text=[NSString stringWithFormat:@" %d:%02d ",minutes,seconds];
 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)createButtons
{
    
    if([currentWords count] <= 0)
    {
        [self closeGame];
        return;
    }
    
    if([currentButtons count] > 0)
    {
        for(UIButton *b in currentButtons)
            [b removeFromSuperview];
    }
    
    counter =[currentWords count] < 5 ? [currentWords count] : 5;
    rndP = [[NSMutableArray alloc] init];

    for(int i = 0; i < counter;i++)
    {
        NSNumber *n = [NSNumber numberWithLong:arc4random_uniform((u_int32_t)counter)];
        while([rndP containsObject:n])
            n = [NSNumber numberWithLong:arc4random_uniform((u_int32_t)counter)];
        [rndP addObject:n];
   
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:currentWords[i] forState:UIControlStateNormal];
        [button sizeToFit];
        int v = ((int)[n intValue]*70)+200;
        
        button.frame = CGRectMake(0,0,100,40);
        button.center = CGPointMake(320/2, v);
        button.layer.cornerRadius = 5;
        button.clipsToBounds = YES;
        [button.layer setBorderWidth:1.0];
        [button.layer setBorderColor:[[UIColor orangeColor] CGColor]];
        [button setBackgroundColor:[UIColor blackColor]];

        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [currentButtons addObject:button];

        [self.view addSubview:button];
    }
    
}




- (void)buttonPressed:(UIButton *)button {
    
    
    if(button.titleLabel.text ==currentWords[0])
    {
        [currentWords removeObjectAtIndex:0];
        counter--;
        [button setBackgroundColor:[UIColor orangeColor ]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        score++;
    }
    else
    {
        if(score != 0) score--;
    }
    
    scoreLabel.text = [NSString stringWithFormat:@"%02ld",(long)score];
    
    float cap = [currentWordsBackUp count];
    float current = [currentWords count];
    progressBar.progress = 1.0f - (current/cap);

    
    if(!counter)
    {
        [self closeGame];
        [self createButtons];
    }
}


-(void) closeGame
{
    [t invalidate];
    t = nil;
    [self performSegueWithIdentifier:@"endGame" sender:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"endGame"]) {
        EndGameViewController *destViewController = segue.destinationViewController;
        destViewController.score = scoreLabel.text;
        destViewController.time = timeLabel.text;
        destViewController.bck_img = final_img;
    }
}
 

@end
