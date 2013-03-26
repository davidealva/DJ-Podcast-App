//
//  ThirdViewController.h
//  Podcast App
//
//  Created by David Alvarado on 3/12/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *urlList;
@property (strong, nonatomic) NSString *pass;
@property (strong, nonatomic) IBOutlet UITableView *smallTable;

@end
