//
//  songCell.m
//  musixmatch
//
//  Created by Samuele De Giuseppe on 29/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import "songCell.h"

@implementation songCell

@synthesize trackName = _trackName;
@synthesize trackArtist = _trackArtist;
@synthesize trackAlbum = _trackAlbum;
@synthesize trackImage = _trackImage;
@synthesize back;

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
