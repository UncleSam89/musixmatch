//
//  SongsTableViewController.h
//  musixmatch
//
//  Created by Samuele De Giuseppe on 28/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


@property NSMutableArray *tracks;

@end
