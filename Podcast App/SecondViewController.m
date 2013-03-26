//
//  SecondViewController.m
//  Podcast App
//
//  Created by David Alvarado on 3/7/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize bioView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *strPath = [[NSBundle mainBundle] resourcePath];
	strPath = [strPath stringByAppendingPathComponent:@"dabio.html"]; 
	NSURL *oURL = [NSURL fileURLWithPath:strPath];
	NSURLRequest* oReq = [NSURLRequest requestWithURL:oURL];
	[bioView loadRequest:oReq];
}

- (void)viewDidUnload
{
    [self setBioView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
