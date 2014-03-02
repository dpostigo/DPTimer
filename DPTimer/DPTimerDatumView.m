//
// Created by Dani Postigo on 2/25/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <NSView-NewConstraints/NSView+NewConstraint.h>
#import <DPKit/NSShadow+DPKit.h>
#import <NSColor-BlendingUtils/NSColor+BlendingUtils.h>
#import "DPTimerDatumView.h"
#import "DPScrollView.h"
#import "DPTimerDatum.h"
#import "DPTimerDatumDrawingView.h"
#import "DPFlippedView.h"
#import "DPTimerBackgroundView.h"
#import "NSView+DPFrameUtils.h"

@implementation DPTimerDatumView

@synthesize datumView;
@synthesize scrollView;
@synthesize backgroundView;

- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {
        [self setup];
    }

    return self;
}


- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {
        [self setup];
    }

    return self;
}

- (void) setup {

    backgroundView = [[NSView alloc] initWithFrame: self.bounds];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: backgroundView];
    [backgroundView superConstrainWidth];
    [backgroundView superConstrainHeight];
    [backgroundView superConstrainCenterX];
    [backgroundView superConstrainCenterY];

    scrollView = [[DPScrollView alloc] initWithFrame: self.bounds];
    [self addSubview: scrollView];
    [scrollView superConstrainWidth];
    [scrollView superConstrainHeight];
    [scrollView superConstrainCenterX];
    [scrollView superConstrainCenterY];

    self.datumView.height = self.height;
    [scrollView.flippedView addSubview: self.datumView];
    [datumView superConstrainEdges];

    //    [self setupBackground];

}

- (void) setupBackground {

    NSColor *backgroundColor = [NSColor colorWithDeviceWhite: 0.1 alpha: 1.0];
    backgroundView.wantsLayer = YES;

    CALayer *layer = backgroundView.layer;
    layer.backgroundColor = backgroundColor.CGColor;
    layer.borderColor = [backgroundColor lighten: 0.1].CGColor;
    layer.borderWidth = 0.5;
    layer.cornerRadius = 3.0;
    self.shadow = [NSShadow shadowWithColor: [NSColor blackColor] radius: 1.0 offset: NSMakeSize(0, -1)];

}

- (DPTimerDatumDrawingView *) datumView {
    if (datumView == nil) {
        datumView = [[DPTimerDatumDrawingView alloc] init];
    }
    return datumView;
}


#pragma mark Getters / setters

- (NSFont *) font {
    return self.datumView.font;
}

- (void) setFont: (NSFont *) font {
    self.datumView.font = font;
}

- (DPTimerDatum *) datum {
    return self.datumView.datum;
}

- (void) setDatum: (DPTimerDatum *) datum {
    self.datumView.datum = datum;
}

- (void) setBackgroundView: (NSView *) backgroundView1 {
    if (backgroundView) {
        [backgroundView removeFromSuperview];
    }
    backgroundView = backgroundView1;

    if (backgroundView) {
        backgroundView.bounds = self.bounds;
        [self addSubview: backgroundView positioned: NSWindowBelow relativeTo: self.scrollView];
    }
}


@end