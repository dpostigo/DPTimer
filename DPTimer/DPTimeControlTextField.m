//
// Created by Dani Postigo on 1/29/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import "DPTimeControlTextField.h"

@implementation DPTimeControlTextField

@synthesize toggleButton;


#pragma mark Toggle

- (void) setToggleButton: (NSButton *) toggleButton1 {
    toggleButton = toggleButton1;
    [self updateTitles];
}

- (void) setStartTitle: (NSString *) startTitle1 {
    startTitle = [startTitle1 mutableCopy];
    [self updateTitles];
}

- (void) setStopTitle: (NSString *) stopTitle1 {
    stopTitle = [stopTitle1 mutableCopy];
    [self updateTitles];
}


- (void) start {
    [super start];
    [self updateTitles];
}

- (void) pause {
    [super pause];
    toggleButton.title = self.startTitle;
    [self updateTitles];
}


- (void) updateTitles {
    if (toggleButton) {
        toggleButton.title = self.currentTitle;
        toggleButton.target = self;
        toggleButton.action = @selector(toggle:);
    }

}

#pragma mark Getters


- (NSString *) currentTitle {
    return self.isRunning ? self.stopTitle : self.startTitle;
}

- (NSString *) startTitle {
    if (startTitle == nil) startTitle = @"Start";
    return startTitle;
}

- (NSString *) stopTitle {
    if (stopTitle == nil) stopTitle = @"Pause";
    return stopTitle;
}


@end