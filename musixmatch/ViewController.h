//
//  ViewController.h
//  musixmatch
//
//  Created by Samuele De Giuseppe on 28/10/15.
//  Copyright © 2015 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


-(IBAction)searchSong;

- (int) getDataFrom:(NSString *)url;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITextField *textSearchField;
@property (weak, nonatomic) IBOutlet UILabel *image_label;



@end

