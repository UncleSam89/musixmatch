//
//  SongsTableViewController.m
//  musixmatch
//
//  Created by Samuele De Giuseppe on 28/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import "SongsTableViewController.h"
#import "songCell.h"
#import "songDetails.h"
#import "QuartzCore/QuartzCore.h"

@interface SongsTableViewController ()

@end

@implementation SongsTableViewController
{
    bool lockResults;
}

@synthesize back;

- (void)viewDidLoad
{

    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    lockResults = false;
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (!lockResults)
    {
        [_tracks removeAllObjects];
        [self.tableView reloadData];
    }

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"songCell";
    
    songCell *cell = (songCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"songCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.back.layer.masksToBounds = YES;
    cell.back.layer.cornerRadius = 5.0f;
    cell.trackName.text = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"track"] ;
    cell.trackArtist.text = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"artist"] ;
    cell.trackAlbum.text = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"album"] ;
    cell.trackImage.image = [UIImage imageWithData: [[_tracks objectAtIndex:indexPath.row] valueForKey:@"img"]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSongDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        songDetails *destViewController = segue.destinationViewController;
        destViewController.s_trackName = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"track"] ;
        destViewController.s_artist = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"artist"];
        destViewController.s_album = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"album"] ;
        destViewController.s_id = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"id"] ;
        destViewController.s_img = [[_tracks objectAtIndex:indexPath.row] valueForKey:@"img"];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lockResults = true;
    [self performSegueWithIdentifier:@"toSongDetails" sender:nil];
}


@end
