//
// Created by Dani Postigo on 2/26/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <NSView-NewConstraints/NSView+NewConstraint.h>
#import <DPKit/NSMutableAttributedString+DPKit.h>
#import "DPTimerDatumInfoView.h"
#import "DPTimerDatum.h"

@implementation DPTimerDatumInfoView

@synthesize textField;

@synthesize datum;

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

    textField = [[NSTextField alloc] initWithFrame: NSMakeRect(0, 0, 100, 100)];
    textField.stringValue = @"";
    [textField setBordered: NO];
    [textField setEditable: NO];
    [textField setDrawsBackground: NO];
    textField.textColor = [NSColor whiteColor];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.font = [NSFont systemFontOfSize: 9.0];
    [self addSubview: textField];
    [textField superConstrainWithInsets: NSEdgeInsetsMake(10, 0, 10, 10)];
    [textField sizeToFit];

}


- (void) setDatum: (DPTimerDatum *) datum1 {
    datum = datum1;

    if (datum) {
        double numHours = round(datum.interval) / 3600;
        double remainder = fmod(round(datum.interval), 3600);
        NSString *format = remainder > 0.01 ? @"%.1f hours" : @"%.0f hours";
        textField.stringValue = [[NSString stringWithFormat: format, numHours] uppercaseString];
    } else {
        textField.stringValue = @"";
    }

    //    [textField sizeToFit];
    //    [self setNeedsDisplay: YES];
}


- (void) drawRect: (NSRect) dirtyRect {
    //
    //    [NSGraphicsContext saveGraphicsState];
    //    [[NSColor blueColor] set];
    //    NSRectFill(self.bounds);
    //    [NSGraphicsContext restoreGraphicsState];
}


@end