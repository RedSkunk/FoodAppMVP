//
//  StoryboardList.m
//  TamiUI
//
//  Created by Roman Mironenko on 2016-07-06.
//  Copyright © 2016 Charles Wen1. All rights reserved.
//

#import "StoryboardList.h"
#import "GlobalConstants.h"

@implementation StoryboardList

+ (UIStoryboard *)mainStoryboard {
    static UIStoryboard *mainStoryboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainStoryboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil];
    });
    return mainStoryboard;
}


@end
