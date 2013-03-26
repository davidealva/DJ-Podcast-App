//
//  FirstViewController.m
//  Podcast App
//
//  Created by David Alvarado on 3/7/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import "FirstViewController.h"
#import "AudioList.h"
#import "AudioViewController.h"
#import "UIImageView+WebCache.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>


@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize audioTable;
@synthesize listData1;
@synthesize listData2;
@synthesize passUrl;
@synthesize passDescription;
@synthesize passImage;
@synthesize passTitle;
@synthesize passRelease;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listData1 = [NSMutableArray array];
    listData2 = [NSMutableArray array];
    
    // Reachability notification
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(handleNetworkChange:) 
                                                 name: kReachabilityChangedNotification 
                                               object: nil];
    reachability = [Reachability reachabilityForInternetConnection];    
    [reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    if(remoteHostStatus == NotReachable) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Oops! We have a problem!" 
                                                         message:@"Please make sure you're connected to the internet"
                                                        delegate:self
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];

        [alert show];
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        [self setArray];
    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        [self setArray]; 
    }   
    
}

- (void)viewDidUnload
{
    [self setAudioTable:nil];
    [self setListData1:nil];
    [self setListData2:nil];
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([segmentedControl selectedSegmentIndex] == 0) {
        return [self.listData1 count];
    }else {
        return [self.listData2 count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
     // Configure the cell...

    if ([segmentedControl selectedSegmentIndex] == 0){
        AudioList *audioInfo =(AudioList*) [listData1 objectAtIndex:indexPath.row];
        
        [cell.imageView setImageWithURL:[NSURL URLWithString:audioInfo.imagePath]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", audioInfo.title];
        
        return cell;
        
    } else {
        
        AudioList *audioInfo =(AudioList*) [listData2 objectAtIndex:indexPath.row];

        [cell.imageView setImageWithURL:[NSURL URLWithString:audioInfo.imagePath]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", audioInfo.title];
    
        return cell;
        ;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAudio"])
    {   
        AudioViewController *audioView = [segue destinationViewController];
        if ([segmentedControl selectedSegmentIndex] == 0){
            [self cellPass1];
        } else {
            [self cellPass2];
        }
        
        //Pass variables to be used in Audio Detail View
        audioView.tracktitle = self.passTitle;
        audioView.description = self.passDescription;
        audioView.release = self.passRelease;
        audioView.imageurl = self.passImage;
        audioView.url = self.passUrl;
    }
}


- (IBAction)chooser:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [self.audioTable reloadData];
    }else {
        [self.audioTable reloadData];
    }
}

- (void) handleNetworkChange:(NSNotification *)notice
{
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        UIAlertView *alert = [[ UIAlertView alloc] initWithTitle:@"Oops! Connection Lost" 
                                                         message:@"Please make sure you're connected to the internet"
                                                        delegate:self
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
        [alert show];
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        [self setArray];
        [self.audioTable reloadData];

    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        [self setArray];
        [self.audioTable reloadData];
 
    }
}

- (void) setArray {
    NSArray *array1 = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:@"http://www.davidalvarado.com/stream/AudioList.plist"]];
    
    for (NSDictionary *d in array1) {
        AudioList *objAudioInfo = [AudioList alloc];
        
        NSString *strTemp = [d objectForKey:@"title"];
		objAudioInfo.title = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"releaseDate"];
        objAudioInfo.releaseDate = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"description"];
        objAudioInfo.description = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"imagePath"];
        objAudioInfo.imagePath = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"audioPath"];
        objAudioInfo.audioPath = [[NSString alloc] initWithString:strTemp];        
        
        [self.listData1 addObject:objAudioInfo];  
        
    }  
    
    NSArray *array2 = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:@"http://www.davidalvarado.com/stream/CDmix.plist"]];
    
    for (NSDictionary *d in array2) {
        AudioList *objAudioInfo = [AudioList alloc];
        
        NSString *strTemp = [d objectForKey:@"title"];
		objAudioInfo.title = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"releaseDate"];
        objAudioInfo.releaseDate = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"description"];
        objAudioInfo.description = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"imagePath"];
        objAudioInfo.imagePath = [[NSString alloc] initWithString:strTemp];
        
        strTemp = [d objectForKey:@"audioPath"];
        objAudioInfo.audioPath = [[NSString alloc] initWithString:strTemp];        
        
        [self.listData2 addObject:objAudioInfo];
        
    } 

}

- (void) cellPass1{
    
    NSInteger selectedIndex = [[self.audioTable indexPathForSelectedRow] row];
    AudioList *audioInfo =(AudioList*) [self.listData1 objectAtIndex:selectedIndex];
    self.passUrl = audioInfo.audioPath;
    self.passTitle = audioInfo.title;
    self.passDescription = audioInfo.description;
    self.passRelease = audioInfo.releaseDate;
    self.passImage = audioInfo.imagePath;
}

- (void) cellPass2{
    NSInteger selectedIndex = [[self.audioTable indexPathForSelectedRow] row];
    AudioList *audioInfo =(AudioList*) [self.listData2 objectAtIndex:selectedIndex];
    self.passUrl = audioInfo.audioPath;
    self.passTitle = audioInfo.title;
    self.passDescription = audioInfo.description;
    self.passRelease = audioInfo.releaseDate;
    self.passImage = audioInfo.imagePath;
    
}
@end
