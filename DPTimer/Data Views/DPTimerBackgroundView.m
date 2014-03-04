//
// Created by Dani Postigo on 2/26/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import "DPTimerBackgroundView.h"

@implementation DPTimerBackgroundView

- (void) drawRect: (NSRect) dirtyRect {
    //    [super drawRect: dirtyRect];
    [[NSColor blackColor] set];
    NSRectFill(self.bounds);
}


@end