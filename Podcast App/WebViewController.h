//
//  WebViewController.h
//  MBDVideoTemplate
//
//  Created by David Alvarado on 2/15/12.
//  Copyright (c) 2012 __MadeByDiesel__.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface WebViewController: UIViewController <UIWebViewDelegate>
{
    
    IBOutlet UIWebView *outWebView;
    Reachability *reachability;
   
}

@property (strong, nonatomic) UIWebView *outWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) NSString *urlPass;



@end
