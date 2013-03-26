//
//  ThirdViewController.m
//  Podcast App
//
//  Created by David Alvarado on 3/12/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import "ThirdViewController.h"
#import "WebViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize urlList;  
@synthesize pass;
@synthesize smallTable;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Twitter", @"Name", @"http://twitter.com/djdavidalvarado", @"Url",@"twitter.png", @"Image", nil];
    NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Facebook", @"Name", @"http://www.facebook.com/pages/David-Alvarado/319335235150", @"Url", @"FaceBook.png", @"Image", nil];
    NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Beatport", @"Name", @"http://www.beatport.com/artist/david-alvarado/57", @"Url", @"beatport.png", @"Image", nil];
    NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Soundcloud", @"Name", @"http://soundcloud.com/davidalvarado", @"Url", @"soundcloud.png", @"Image", nil];
    NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Myspace", @"Name", @"http://www.myspace.com/davidalvarado", @"Url", @"MySpace.png", @"Image", nil];
    NSDictionary *row6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Website", @"Name", @"http://www.davidalvarado.com", @"Url", @"wordpress.png", @"Image", nil];
    NSDictionary *row7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Email", @"Name", @"mailto:info@davidalvarado.com", @"Url", @"email.png", @"Image", nil];
    
    self.urlList = [[NSArray alloc] initWithObjects:row1,row2, row3, row4, row5, row6, row7, nil];
}

- (void)viewDidUnload
{
    [self setUrlList:nil];
    [self setPass:nil];
    [self setSmallTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [urlList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.urlList objectAtIndex:row];
    
    NSString *imgName = [rowData objectForKey:@"Image"];    
    UIImage *image = [UIImage imageNamed:imgName];
    cell.imageView.image = image;
    
    cell.textLabel.text = [rowData objectForKey:@"Name"];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    WebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"Web"];
    
    // Pass the selected object to the new view controller.
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.urlList objectAtIndex:row];
    pass = [rowData objectForKey:@"Url"];
    
    webView.urlPass = pass;
    [self.navigationController pushViewController:webView animated:YES];    
}

@end
