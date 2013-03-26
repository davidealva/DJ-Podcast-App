//
//  AudioList.h
//  Podcast App
//
//  Created by David Alvarado on 3/8/12.
//  Copyright (c) 2012 __MadeByDiesel__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioList : NSObject
{
    NSString *title;
    NSString *description;
    NSString *releaseDate;
    NSString *imagePath;
    NSString *audioPath;
}

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *releaseDate;
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSString *audioPath;



@end
