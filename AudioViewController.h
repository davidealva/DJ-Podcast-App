//
//  AudioViewController.h
//  Podcast App
//
//  Created by David Alvarado on 3/9/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <Twitter/Twitter.h>
#import "Reachability.h"



@interface AudioViewController : UIViewController 
{
    MPMoviePlayerController *MoviePlayerController;
    Reachability *reachability;

}

@property (strong, nonatomic) MPMoviePlayerController *MoviePlayerController;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *tracktitle;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *imageurl;
@property (strong, nonatomic) NSString *release;
@property (strong, nonatomic) IBOutlet UIImageView *mixImage;
@property (strong, nonatomic) IBOutlet UILabel *mixTitle;
@property (strong, nonatomic) IBOutlet UILabel *releaseDate;
@property (strong, nonatomic) IBOutlet UITextView *mixDescription;


- (IBAction)playAudio:(UIButton *)sender;
- (IBAction)tweetbutton;


@end
