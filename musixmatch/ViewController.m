//
//  ViewController.m
//  musixmatch
//
//  Created by Samuele De Giuseppe on 28/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import "ViewController.h"
#import "SongsTableViewController.h"

@interface ViewController ()

@end


@implementation ViewController
{
    NSMutableArray *tracks;
    UIActivityIndicatorView *spinner;

}

@synthesize  searchButton;
@synthesize textSearchField;

- (void)viewDidLoad {
    [super viewDidLoad];
    tracks = [[NSMutableArray alloc] init];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 380);
    spinner.tag = 12;
    [self.view addSubview:spinner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(IBAction)searchSong
{
   
    [spinner startAnimating];
    [searchButton setEnabled:false];
    [textSearchField setEnabled:false];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
      
        NSString *url = [NSString stringWithFormat:@"http://api.musixmatch.com/ws/1.1/track.search?q=%@&page_size=20&has_lyrics=1&apikey=2ed34217a2baa214a51e21706b43496c", textSearchField.text];
        
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        int res = [self getDataFrom:url];
                // do any UI stuff on the main UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(res == 0)
            {
            
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Search error"
                                              message:@"No song found"
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
                [self performSegueWithIdentifier:@"toResults" sender:nil];
            }

            [spinner stopAnimating];
            [searchButton setEnabled:true];
            [textSearchField setEnabled:true];

        });
        
    });
    
    
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
        if([[results valueForKeyPath:@"message.body.track_list"] count] <= 0) return 0;

        for (id track in [results valueForKeyPath:@"message.body.track_list"])
        {

            NSMutableDictionary *s_track = [[NSMutableDictionary alloc] init];

            
            [s_track setObject:[track valueForKeyPath:@"track.track_id"] forKey:@"id"];
            [s_track setObject:[track valueForKeyPath:@"track.artist_name"] forKey:@"artist"];
            [s_track setObject:[track valueForKeyPath:@"track.track_name"] forKey:@"track"];
            [s_track setObject:[track valueForKeyPath:@"track.album_name"] forKey:@"album"];
        
            NSURL *imageUrl;
            if(![[track valueForKeyPath:@"track.album_coverart_500x500"]  isEqual: @""])
                imageUrl =[NSURL URLWithString:[track valueForKeyPath:@"track.album_coverart_500x500"]];
            else if(![[track valueForKeyPath:@"track.album_coverart_350x350"]  isEqual: @""])
                imageUrl =[NSURL URLWithString:[track valueForKeyPath:@"track.album_coverart_350x350"]];
            else if(![[track valueForKeyPath:@"track.album_coverart_100x100"]  isEqual: @""])
                imageUrl =[NSURL URLWithString:[track valueForKeyPath:@"track.album_coverart_100x100"]];
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL:imageUrl];
            [s_track setObject:imageData forKey:@"img"];
            
            [tracks addObject:s_track];
 
        }
        
    }
    
    return 1;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toResults"]) {
        SongsTableViewController *destViewController = segue.destinationViewController;
        destViewController.tracks = tracks;
    }
}

@end
