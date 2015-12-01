//
//  songDetails.m
//  musixmatch
//
//  Created by Samuele De Giuseppe on 29/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import "songDetails.h"
#import "PlayViewController.h"

@interface songDetails ()

@end

@implementation songDetails
{
    int res;
    CGFloat width;
}

@synthesize img;
@synthesize trackName;
@synthesize album;
@synthesize artist;
@synthesize play;
@synthesize s_album;
@synthesize s_trackName;
@synthesize s_artist;
@synthesize s_img;
@synthesize s_lyrics;
@synthesize s_id;
@synthesize splittedText;
@synthesize cover;

- (void)viewDidLoad {
    
    
    splittedText = [[NSMutableArray alloc] init];
    img.image = [UIImage imageWithData:s_img];
    album.text = s_album;
    artist.text = s_artist;
    trackName.text=s_trackName;
    
    //cover.layer.masksToBounds = YES;
    //cover.layer.cornerRadius = 5.0f;
    [self retrieveLyrics];
    [self getDifficulty];
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




- (void)retrieveLyrics
{
    NSString *url = [NSString stringWithFormat:@"http://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=%@&apikey=2ed34217a2baa214a51e21706b43496c", s_id];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    res = [self getDataFrom:url];
    

}



- (void)getDifficulty
{
   
    CGFloat centerx = CGRectGetWidth(self.view.bounds)/2;
    CGFloat centery = CGRectGetMidY(cover.frame) - 7;
    
    
    UIView *circleView1 = [[UIView alloc] initWithFrame:CGRectMake(centerx-35, centery, 14.0, 14.0)];
    UIView *circleView2 = [[UIView alloc] initWithFrame:CGRectMake(centerx-7, centery, 14.0, 14.0)];
    UIView *circleView3 = [[UIView alloc] initWithFrame:CGRectMake(centerx+20, centery, 14.0, 14.0)];
        
    
    [circleView1.layer setCornerRadius:7.5];
    [circleView2.layer setCornerRadius:7.5];
    [circleView3.layer setCornerRadius:7.5];

    if(res == 0 || [s_lyrics length] == 0 || [s_lyrics  isEqual: @"instrumental"])
    {
        [circleView1 setBackgroundColor:[UIColor whiteColor]];
        [circleView2 setBackgroundColor:[UIColor whiteColor]];
        [circleView3 setBackgroundColor:[UIColor whiteColor]];

       
    }
    else
    {
        
        splittedText =(NSMutableArray*) [s_lyrics componentsSeparatedByCharactersInSet:
                        [NSCharacterSet characterSetWithCharactersInString:@"-/,;.!?\n "]];
        
        [splittedText removeObject:@""];
        
        //rimuovi didascalia finale per l'utilizzo non commerciale
        for(int i= 0; i <9; i++)
            [splittedText removeObjectAtIndex:[splittedText count] - 1];
        
        
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:splittedText];
        
        [circleView1 setBackgroundColor:[UIColor greenColor]];
        [circleView2 setBackgroundColor:[UIColor greenColor]];
        [circleView3 setBackgroundColor:[UIColor greenColor]];
        
        if([orderedSet count] > 50)
        {
            [circleView1 setBackgroundColor:[UIColor yellowColor]];
            [circleView2 setBackgroundColor:[UIColor yellowColor]];
            [circleView3 setBackgroundColor:[UIColor yellowColor]];
        }
        if([orderedSet count] > 100)
        {
            [circleView1 setBackgroundColor:[UIColor redColor]];
            [circleView2 setBackgroundColor:[UIColor redColor]];
            [circleView3 setBackgroundColor:[UIColor redColor]];
        }

    }
    [self.view addSubview:circleView1];
    [self.view addSubview:circleView2];
    [self.view addSubview:circleView3];

}

- (IBAction) startGame
{
    if(res == 0 || [s_lyrics length] == 0 || [s_lyrics  isEqual: @"instrumental"])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Song error"
                                      message:@"Selected song has no lyrics"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];

    }
    else
    {
        [self performSegueWithIdentifier:@"toPlay" sender:nil];
    }
}


- (int) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;

    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    id object = [NSJSONSerialization
                 JSONObjectWithData:oResponseData
                 options:0
                 error:&error];

    if(error)
    {
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return 0;
    }

    
    if([object isKindOfClass:[NSDictionary class]])
    {

        NSDictionary *results = object;
        s_lyrics = [[results valueForKeyPath:@"message.body.lyrics.lyrics_body"] lowercaseString];
        return 1;
    }
    
    return 0;
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toPlay"]) {
        PlayViewController *destViewController = segue.destinationViewController;
        destViewController.currentWords = splittedText;
        destViewController.final_img = s_img;
    }
}

@end
