//
//  WebViewController.m
//  MBDVideoTemplate
//
//  Created by David Alvarado on 2/15/12.
//  Copyright (c) 2012 __MadeByDiesel__.  All rights reserved.
//

#import "WebViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>

@implementation WebViewController
@synthesize outWebView;
@synthesize activity;
@synthesize urlPass;



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
        
    NSString *fullURL = urlPass; 
    NSURL *url = [NSURL URLWithString:fullURL]; 
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url]; 
    [outWebView loadRequest:requestObj];

}


- (void)viewDidUnload
{
    [self setOutWebView:nil];
    [self setUrlPass:nil];
    [self setActivity:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView 
{
	activity.hidden = YES;
	[activity stopAnimating];  
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{     
	activity.hidden = NO;
	[activity startAnimating];     
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	activity.hidden = YES;
	[activity stopAnimating];
}

- (void)viewWillAppear:(BOOL)animated
{
    Reachability *r = [Reachability reachabilityWithHostName:@"m.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Oops! Cannot connect to internet" 
                                                         message:@"Please make sure you're connected to the internet"
                                                        delegate:self
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
