//
//  AudioViewController.m
//  Podcast App
//
//  Created by David Alvarado on 3/9/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import "AudioViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>

@interface AudioViewController ()

@end

@implementation AudioViewController
@synthesize mixImage;
@synthesize mixTitle;
@synthesize releaseDate;
@synthesize mixDescription;
@synthesize url;
@synthesize MoviePlayerController;
@synthesize tracktitle;
@synthesize description ;
@synthesize imageurl;
@synthesize release; 

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mixTitle.text = tracktitle;
    self.releaseDate.text = release;
    self.mixDescription.text = description;
    
    UIImage *myImage = [[UIImage alloc] initWithData:
                       [NSData dataWithContentsOfURL:[NSURL URLWithString:imageurl]]];
    self.mixImage.image = myImage; 
}

- (void)viewDidUnload
{
    [self setMoviePlayerController:nil];
    [self setMixImage:nil];
    [self setMixTitle:nil];
    [self setReleaseDate:nil];
    [self setMixDescription:nil];
    [self setImageurl:nil];
    [self setDescription:nil];
    [self setRelease:nil];
    [self setReleaseDate:nil];
    [self setUrl:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)playAudio:(UIButton *)sender 
{   
    Reachability *r = [Reachability reachabilityWithHostName:@"m.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Cannot connect to internet" 
                                                         message:@"Please make sure you're connected to the internet"
                                                        delegate:self
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
    [alert show];
    } else {
            
    NSString *fullUrl = url;
    NSURL *path = [NSURL URLWithString:fullUrl];
    self.MoviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:path];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:self.MoviePlayerController];
    
    self.MoviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
    [self.MoviePlayerController play];
    [self.view addSubview:MoviePlayerController.view];

    [MoviePlayerController setFullscreen:YES animated:YES];
    }
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    
   MoviePlayerController= [notification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self      
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:MoviePlayerController];
    
    if ([MoviePlayerController
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [MoviePlayerController.view removeFromSuperview];
    }

}

- (IBAction)tweetbutton{
    Reachability *r = [Reachability reachabilityWithHostName:@"m.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Cannot connect to internet" 
                                                         message:@"Please make sure you're connected to the internet"
                                                        delegate:self
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
        [alert show];
    } else {
    NSString *tweetText = [[NSString alloc] initWithFormat:@"I'm listening to %@ Mix on the new David Alvarado iPhone App @djdavidalvarado", self.tracktitle];    
    TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];    
    [tweetSheet setInitialText:tweetText];    
    [tweetSheet addURL:[NSURL URLWithString:@"http://davidalvarado.com/iphoneapp"]];    
    [self presentModalViewController:tweetSheet animated:YES];
    }
}


@end
