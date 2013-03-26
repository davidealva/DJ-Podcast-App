//
//  FirstViewController.h
//  Podcast App
//
//  Created by David Alvarado on 3/7/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UISegmentedControl *segmentedControl;
    UIImageView *imageView;
    Reachability *reachability;

}

@property (strong, nonatomic) IBOutlet UITableView *audioTable;
@property (strong, nonatomic) NSMutableArray *listData1;
@property (strong, nonatomic) NSMutableArray *listData2;
@property (strong, nonatomic) NSString *passUrl;
@property (strong, nonatomic) NSString *passTitle;
@property (strong, nonatomic) NSString *passImage;
@property (strong, nonatomic) NSString *passDescription;
@property (strong, nonatomic) NSString *passRelease;



- (IBAction)chooser:(id)sender;
- (void) handleNetworkChange:(id)sender;
- (void) setArray;
@end
