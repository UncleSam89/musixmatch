//
//  songCell.h
//  musixmatch
//
//  Created by Samuele De Giuseppe on 29/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface songCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *trackName;
@property (nonatomic, weak) IBOutlet UILabel *trackArtist;
@property (nonatomic, weak) IBOutlet UILabel *trackAlbum;
@property (nonatomic, weak) IBOutlet UIImageView *trackImage;
@property (weak, nonatomic) IBOutlet UILabel *back;

@end
