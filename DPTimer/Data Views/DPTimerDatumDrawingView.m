//
// Created by Dani Postigo on 2/21/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <DPKit/NSMutableAttributedString+DPKit.h>
#import <NSDate-Extensions/NSDate-Utilities.h>
#import <AppKit/AppKit.h>
#import <NSColor-BlendingUtils/NSColor+BlendingUtils.h>
#import <NSColor-Crayola/NSColor+Crayola.h>
#import <NSView-NewConstraints/NSView+NewConstraint.h>
#import "DPTimerDatumDrawingView.h"
#import "DPTimerDatum.h"
#import "NSBezierPath+RoundedCorners.h"
#import "NSView+SiblingConstraints.h"
#import "DPTimerDatumInfoView.h"


#import "NSView+DPFrameUtils.h"

@implementation DPTimerDatumDrawingView

@synthesize font;
@synthesize datum;
@synthesize formatter;

@synthesize minimumTickSpacing;
@synthesize minorTickColor;
@synthesize minorTickHeight;
@synthesize tickHeight;
@synthesize tickOffset;
@synthesize tickSpacing;
@synthesize tickStartTime;
@synthesize tickStopTime;
@synthesize labelAlignment;
@synthesize labelColor;
@synthesize labelDateFormatter;
@synthesize labelInterval;
@synthesize drawsAxis;
@synthesize viewInsets;
@synthesize datumHeight;
@synthesize datumInsets;

@synthesize trackingAreas;

@synthesize lastPoint;

@synthesize datumColor;

@synthesize datumBorderColor;

@synthesize selectedDatum;

@synthesize infoView;

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


- (void) setDatum: (DPTimerDatum *) datum1 {
    if (datum != datum1) {
        datum = datum1;

        if (self.tickSpacing > 0) {
            self.width = self.viewWidth;
        }
    }
}


- (void) setup {

    infoView = [[DPTimerDatumInfoView alloc] initWithFrame: self.bounds];
    infoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: infoView];

    minimumTickSpacing = 30.0;
    tickSpacing = 40.0;
    //    datumColor = [NSColor crayolaEmeraldColor];
    datumColor = [NSColor crayolaBananaColor];
    datumBorderColor = [datumColor lighten: 0.2];
    datumHeight = 20;
    datumInsets = NSEdgeInsetsMake(0, 0, 10, 0);

    labelColor = self.minorTickColor;
    tickOffset = NSMakeSize(0, 0);
    viewInsets = NSEdgeInsetsMake(10, 10, 10, 10);

    self.tickHeight = 5;
    self.tickOffset = NSMakeSize(0, 0);
    self.tickSpacing = 60.0;
    self.minorTickHeight = 8;

    self.labelAlignment = NSCenterTextAlignment;

    self.infoView.textField.font = self.font;
    self.infoView.textField.textColor = self.labelColor;

}

- (void) drawRect: (NSRect) dirtyRect {

    //    [[NSColor grayColor] set];
    //    NSFrameRectWithWidth(self.drawingRect, 0.5);

    //    [self drawHourMarks];
    //    [self drawDatum];
    //
    //    [self drawFakeMarks];
    //
    //    [[NSColor whiteColor] set];
    //    NSFrameRectWithWidth(self.graphRect, 0.5);



    // Ticks
    //    [[NSColor blueColor] set];
    //    NSFrameRectWithWidth(self.ticksRect, 0.5);

    for (int j = 0; j < self.numberOfTicks; j++) {
        NSRect tickRect = [self rectForTickNumber: j];
        [self.tickColor set];
        NSRectFill(tickRect);

        for (int k = 0; k < self.numberOfMinorTicksPerTick; k++) {
            NSRect minorTickRect = [self rectForTickNumber: k];
            minorTickRect.origin.x = tickRect.origin.x + [self widthForInterval: self.minorTickInterval];
            minorTickRect.size.height = self.minorTickHeight;

            [self.minorTickColor set];
            NSRectFill(minorTickRect);
        }
    }

    if (self.drawsAxis) {
        NSRect tickStrip = self.ticksRect;
        tickStrip.size.height = 0.5;
        [self.tickColor set];
        NSRectFill(tickStrip);
    }


    // Labels
    NSRect masterTextRect = self.textRect;
    //    [[NSColor yellowColor] set];
    //    NSFrameRectWithWidth(masterTextRect, 0.5);

    for (int a = 0; a < self.numberOfLabels; a++) {
        NSRect tickRect = [self rectForTickNumber: a];
        NSDate *tickDate = [self.tickStartTime dateByAddingTimeInterval: (self.labelInterval * a)];
        NSString *labelString = [self.labelDateFormatter stringFromDate: tickDate];
        NSAttributedString *string = [self attributedStringForLabel: labelString];


        CGFloat labelX = tickRect.origin.x;

        if (self.labelAlignment == NSRightTextAlignment) {
            labelX -= string.size.width;
        } else if (self.labelAlignment == NSCenterTextAlignment) {
            labelX -= (string.size.width / 2);
        }

        NSRect textRect = NSMakeRect(labelX, masterTextRect.origin.y, string.size.width, string.size.height);
        [string drawInRect: textRect];
    }

    //    [[NSColor redColor] set];
    //    NSFrameRectWithWidth(self.datumsRect, 0.5);

    if (self.datum) {


        //        NSArray *datumRects = self.datumRects;
        //
        //        for (int k = 0; k < [datumRects count]; k++) {
        //            NSRect datumRect = [[datumRects objectAtIndex: k] rectValue];
        //            NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect: rect radius: datumHeight / 8];
        //            [self.datumColor set];
        //            [self.datumBorderColor setStroke];
        //            [path setLineWidth: 0.5];
        //            [path fill];
        //            [path stroke];
        //        }


        NSRect masterDatumsRect = self.datumsRect;
        NSArray *datums = self.datum.unpausedDatums;

        for (int j = 0; j < [datums count]; j++) {
            DPTimerDatum *subDatum = [datums objectAtIndex: j];
            //            NSLog(@"interval = %.0f (%f), startDate = %@, endDate = %@", subDatum.interval, (subDatum.interval / 3600), subDatum.startDate, subDatum.endDate);

            CGFloat datumX = masterDatumsRect.origin.x + (self.widthForSecondNew * [subDatum.startDate timeIntervalSinceDate: self.datum.startDate]);
            CGFloat datumY = NSMaxY(masterDatumsRect) - self.datumHeight;
            CGFloat datumWidth = self.widthForSecondNew * subDatum.interval;
            NSRect rect = NSMakeRect(datumX, datumY, datumWidth, self.datumHeight);

            NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect: rect radius: datumHeight / 8];
            [self.datumColor set];
            [self.datumBorderColor setStroke];
            [path setLineWidth: 0.5];
            [path fill];
            [path stroke];
        }
    }

}


#pragma mark Rects & Drawing



- (NSRect) drawingRect {
    NSRect ret = self.bounds;
    ret.origin.x += viewInsets.left;
    ret.origin.y += viewInsets.top;
    ret.size.width -= (viewInsets.left + viewInsets.right);
    ret.size.height -= (viewInsets.top + viewInsets.bottom);
    return ret;
    //    return NSInsetRect(self.bounds, 10, 10);
    //    return self.bounds;
}

- (NSRect) textRect {
    NSAttributedString *string = self.attributedString;

    NSRect bounds = self.drawingRect;
    NSRect ret = NSMakeRect(bounds.origin.x,
            bounds.size.height - string.size.height,
            bounds.size.width, string.size.height);
    return ret;
}

- (NSRect) ticksRect {
    NSRect bounds = self.drawingRect;

    CGFloat startingX = bounds.origin.x;
    if (self.labelAlignment == NSCenterTextAlignment) {
        startingX += self.attributedString.size.width / 2;
    } else if (self.labelAlignment == NSCenterTextAlignment) {
        startingX += self.attributedString.size.width;
    }

    NSRect ret = NSMakeRect(startingX,
            self.textRect.origin.y - self.maxTickHeight - self.tickOffset.height,
            bounds.size.width - startingX,
            self.maxTickHeight);
    return ret;
}

- (NSRect) datumsRect {
    NSRect tickRect = self.ticksRect;

    NSRect bounds = self.drawingRect;
    CGFloat height = bounds.size.height - (bounds.size.height - tickRect.origin.y);


    NSRect ret = NSMakeRect(tickRect.origin.x,
            bounds.origin.y,
            bounds.size.width - tickRect.origin.x,
            height - bounds.origin.y);

    ret.origin.y += self.datumInsets.top;
    ret.size.height -= self.datumInsets.bottom;

    //    ret = self.ticksRect;


    return ret;
}


- (CGFloat) maxTickHeight {
    return fmaxf((float) self.tickHeight, (float) self.minorTickHeight);
}

- (NSRect) rectForTickNumber: (int) index {
    NSRect marksRect = self.ticksRect;

    NSRect ret = NSMakeRect(marksRect.origin.x + (index * self.tickSpacing), marksRect.origin.y, 0.5, self.tickHeight);
    return ret;
}


- (NSArray *) datumRects {

    NSMutableArray *ret = [[NSMutableArray alloc] init];

    NSRect masterDatumsRect = self.datumsRect;
    NSArray *datums = self.datum.unpausedDatums;

    for (int j = 0; j < [datums count]; j++) {
        DPTimerDatum *subDatum = [datums objectAtIndex: j];
        CGFloat datumX = masterDatumsRect.origin.x + (self.widthForSecondNew * [subDatum.startDate timeIntervalSinceDate: self.datum.startDate]);
        CGFloat datumY = NSMaxY(masterDatumsRect) - self.datumHeight;
        CGFloat datumWidth = self.widthForSecondNew * subDatum.interval;
        NSRect rect = NSMakeRect(datumX, datumY, datumWidth, self.datumHeight);
        [ret addObject: [NSValue valueWithRect: rect]];
    }

    //
    //
    //    NSArray *datums = self.datum.pauses;
    //
    //
    //    NSRect masterDatumsRect = self.datumsRect;
    //    for (int j = 0; j < [datums count]; j++) {
    //        DPTimerDatum *subDatum = [datums objectAtIndex: j];
    //
    //        //
    //        //        CGFloat datumX = masterDatumsRect.origin.x + (self.widthForSecondNew * [subDatum.startDate timeIntervalSinceDate: self.datum.startDate]);
    //        //        CGFloat datumY = (masterDatumsRect.origin.y - 10) - (j * (self.datumHeight + 10));
    //        //        datumY = NSMaxY(masterDatumsRect) - self.datumHeight;
    //        //        CGFloat datumWidth = self.widthForSecondNew * subDatum.interval;
    //        //
    //        //        NSRect rect = NSMakeRect(datumX, datumY, datumWidth, self.datumHeight);
    //        //        [ret addObject: [NSValue valueWithRect: rect]];
    //
    //        CGFloat datumX = masterDatumsRect.origin.x + (self.widthForSecondNew * [subDatum.startDate timeIntervalSinceDate: self.datum.startDate]);
    //        CGFloat datumY = (masterDatumsRect.origin.y - 10) - (j * (self.datumHeight + 10));
    //        datumY = NSMaxY(masterDatumsRect) - self.datumHeight;
    //        CGFloat datumWidth = self.widthForSecondNew * subDatum.interval;
    //
    //        NSRect rect = NSMakeRect(datumX, datumY, datumWidth, self.datumHeight);
    //        [ret addObject: [NSValue valueWithRect: rect]];
    //        //        rect = NSMakeRect(datumX, datumY, datumWidth, self.datumHeight);
    //
    //    }
    //
    return ret;

}


#pragma mark Calculations


- (int) numberOfTicks {
    return (int) ceil(self.tickingRange / self.tickInterval);
}

- (int) numberOfLabels {
    return (int) ceil(self.tickingRange / self.labelInterval);
}

- (int) numberOfMinorTicksPerTick {
    return self.minorTickIntervalsPerTickInterval - 1;
}


- (NSDate *) tickStartTime {
    if (tickStartTime == nil) {
        tickStartTime = [[[NSDate date] dateAtStartOfDay] dateByAddingHours: 6];
    }
    return tickStartTime;
}

- (NSDate *) tickStopTime {
    if (tickStopTime == nil) tickStopTime = [self.tickStartTime dateByAddingHours: 17];
    return tickStopTime;
}


- (NSTimeInterval) tickingRange {
    return [self.tickStopTime timeIntervalSinceDate: self.tickStartTime];
}

#pragma mark Tick

- (NSColor *) tickColor {
    return [NSColor whiteColor];
}

- (CGFloat) tickHeight {
    if (tickHeight == 0) {
        tickHeight = 10.0;
    }
    return tickHeight;
}


- (NSTimeInterval) tickInterval {
    return self.minorTickInterval * self.minorTickIntervalsPerTickInterval;
}


- (void) setTickSpacing: (CGFloat) tickSpacing1 {
    if (tickSpacing1 < minimumTickSpacing) tickSpacing1 = minimumTickSpacing;
    if (tickSpacing != tickSpacing1) {
        tickSpacing = tickSpacing1;
        //        [self setNeedsDisplay: YES];
        [self setNeedsUpdateConstraints: YES];
    }
}


- (NSSize) tickOffset {
    return tickOffset;
}


#pragma mark Minor ticks


- (NSColor *) minorTickColor {
    if (minorTickColor == nil) {
        minorTickColor = [self.tickColor colorWithAlphaComponent: 0.5];
    }
    return minorTickColor;
}

- (CGFloat) minorTickHeight {
    if (minorTickHeight == 0) {
        minorTickHeight = 5.0;
    }
    return minorTickHeight;

}

- (NSTimeInterval) minorTickInterval {
    return 60 * 60;
}

- (int) minorTickIntervalsPerTickInterval {
    return 2;
}


#pragma mark Labels

- (NSColor *) labelColor {
    if (labelColor == nil) {
        labelColor = self.tickColor;
    }
    return labelColor;
}


- (NSDateFormatter *) labelDateFormatter {
    if (labelDateFormatter == nil) {
        labelDateFormatter = [[NSDateFormatter alloc] init];
        labelDateFormatter.dateFormat = @"h a";
    }
    return labelDateFormatter;
}

- (NSTimeInterval) labelInterval {
    if (labelInterval == 0) {
        labelInterval = self.tickInterval;
    }
    return labelInterval;
}


- (NSMutableAttributedString *) attributedStringForLabel: (NSString *) label {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString: [label uppercaseString]];
    [string addAttribute: NSForegroundColorAttributeName value: self.labelColor];
    [string addAttribute: NSFontAttributeName value: self.font];
    return string;

}

- (NSMutableAttributedString *) attributedString {
    return [self attributedStringForLabel: @"10:00 AM"];
}

- (NSFont *) font {
    if (font == nil) {
        font = [NSFont fontWithName: @"Arial-BoldMT" size: 8.0];
    }
    return font;
}

#pragma mark Other


- (CGFloat) widthForInterval: (NSTimeInterval) interval {
    return interval * self.widthForSecondNew;
}


- (CGFloat) widthForSecondNew {
    return self.tickSpacing / self.tickInterval;
}


- (NSDateFormatter *) formatter {
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        //        formatter.dateStyle = NSDateFormatterLongStyle;
        formatter.timeStyle = NSDateFormatterFullStyle;
    }
    return formatter;
}


- (CGFloat) viewWidth {
    return viewInsets.left + (self.tickSpacing * self.numberOfTicks) + viewInsets.right;
}


#pragma mark Selected Datum

- (void) setSelectedDatum: (DPTimerDatum *) selectedDatum1 {
    selectedDatum = selectedDatum1;
    self.infoView.datum = selectedDatum;
}


- (DPTimerDatumInfoView *) infoView {
    return infoView;
}


#pragma mark Getters




#pragma mark View update

- (void) updateConstraints {
    [super updateConstraints];

    CGFloat widthValue = self.viewWidth;
    NSLayoutConstraint *constraint = [self staticWidthConstraint];
    if (constraint == nil) {
        constraint = [self staticConstrainWidth: widthValue];
    }
    constraint.constant = self.viewWidth;
}



#pragma mark Tracking Areas

- (void) updateTrackingAreas {
    [super updateTrackingAreas];

    for (NSTrackingArea *trackingArea in self.trackingAreas) {
        [self removeTrackingArea: trackingArea];
    }

    self.trackingAreas = [[NSMutableArray alloc] init];

    NSArray *datumRects = self.datumRects;
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);

    for (int j = 0; j < [datumRects count]; j++) {
        NSRect rect = [[datumRects objectAtIndex: j] rectValue];

        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject: @"datum" forKey: @"type"];
        NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect: rect options: opts owner: self userInfo: userInfo];
        [self.trackingAreas addObject: trackingArea];
        [self addTrackingArea: trackingArea];
    }

    NSTrackingArea *trackingArea;

    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject: @"text" forKey: @"type"];
    trackingArea = [[NSTrackingArea alloc] initWithRect: self.textRect options: opts owner: self userInfo: userInfo];
    [self.trackingAreas addObject: trackingArea];
    [self addTrackingArea: trackingArea];

}

- (NSMutableArray *) trackingAreas {
    if (trackingAreas == nil) {
        trackingAreas = [[NSMutableArray alloc] init];
    }
    return trackingAreas;
}

- (void) cursorUpdate: (NSEvent *) event {
}


- (void) mouseDown: (NSEvent *) theEvent {
    //    [super mouseDown: theEvent];
    lastPoint = [[self superview] convertPoint: [theEvent locationInWindow] fromView: nil];

    NSPoint point = [self convertPoint: [theEvent locationInWindow] fromView: nil];

    NSInteger index = [self datumIndexForPoint: point];
    if (index != -1) {
        DPTimerDatum *aDatum = [self.datum.unpausedDatums objectAtIndex: index];
        self.selectedDatum = aDatum;

        NSRect datumRect = [[self.datumRects objectAtIndex: index] rectValue];
        infoView.left = datumRect.origin.x;
        infoView.top = datumRect.origin.y - infoView.height;
    }
}


- (void) mouseDragged: (NSEvent *) theEvent {
    NSPoint newDragLocation = [[self superview] convertPoint: [theEvent locationInWindow] fromView: nil];

    NSPoint thisOrigin = self.frame.origin;
    thisOrigin.x += (-self.lastPoint.x + newDragLocation.x);
    thisOrigin.y += (-self.lastPoint.y + newDragLocation.y);

    self.tickSpacing += thisOrigin.x;
    self.lastPoint = newDragLocation;
}

- (void) mouseEntered: (NSEvent *) theEvent {
    NSDictionary *dictionary = theEvent.trackingArea.userInfo;
    if (dictionary && [dictionary objectForKey: @"type"]) {

        NSString *type = [dictionary objectForKey: @"type"];
        if ([type isEqualToString: @"text"]) {
            [[NSCursor resizeLeftRightCursor] set];
        } else if ([type isEqualToString: @"datum"]) {
            [self mouseEnteredDatum: theEvent];
        }
    }
}


- (void) mouseEnteredDatum: (NSEvent *) theEvent {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSPoint point = [self convertPoint: [theEvent locationInWindow] fromView: nil];

    NSInteger index = [self datumIndexForPoint: point];
    if (index != -1) {

        NSRect datumRect = [[self.datumRects objectAtIndex: index] rectValue];
        [infoView updateSuperLeadingConstraint: datumRect.origin.x];
        [infoView updateSuperTopConstraint: datumRect.origin.y - infoView.height];

        DPTimerDatum *aDatum = [self.datum.unpausedDatums objectAtIndex: index];
        self.selectedDatum = aDatum;

        [self setNeedsDisplay: YES];

    }

}

- (void) mouseExited: (NSEvent *) theEvent {
    NSDictionary *dictionary = theEvent.trackingArea.userInfo;
    if (dictionary && [dictionary objectForKey: @"type"]) {

        NSString *type = [dictionary objectForKey: @"type"];
        if ([type isEqualToString: @"text"]) {
            [[NSCursor arrowCursor] set];
        } else if ([type isEqualToString: @"datum"]) {
            [self mouseExitedDatum: theEvent];
        }
    }
}


- (void) mouseExitedDatum: (NSEvent *) theEvent {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.infoView.datum = nil;
    NSLog(@"infoView.frame = %@", NSStringFromRect(infoView.frame));
    //    [self setNeedsDisplay: YES];

}

- (BOOL) mouseDownCanMoveWindow {
    return NO;
}


- (NSInteger) datumIndexForPoint: (NSPoint) point {
    NSInteger ret = -1;
    NSArray *datumRects = self.datumRects;

    for (NSValue *value in datumRects) {
        if (NSPointInRect(point, [value rectValue])) {
            ret = [datumRects indexOfObject: value];
        }
    }
    return ret;
}

- (NSInteger) indexOfDatumRect: (NSRect) rect {
    NSInteger ret = -1;
    NSArray *datumRects = self.datumRects;
    for (NSValue *value in datumRects) {
        if (NSEqualRects([value rectValue], rect)) {
            ret = [datumRects indexOfObject: value];
        }
    }
    return ret;
}



#pragma mark Old

- (void) drawFakeMarks {
    CGFloat width = self.graphRect.size.width;
    CGFloat xOffset = self.graphRect.origin.x;
    CGFloat yOffset = self.graphRect.origin.y;

    CGFloat markDivider = 2;

    for (int j = 0; j < width / markDivider; j++) {
        NSRect rect = NSMakeRect(self.graphRect.origin.x + (j * markDivider), yOffset, 0.5, 5);

        [self.hourTickColor set];
        NSRectFill(rect);

    }
}

- (void) drawDatum {

    if (self.datum) {

        NSRect graphRect = self.graphRect;
        NSArray *datums = self.datum.unpausedDatums;

        CGFloat datumX;
        CGFloat datumY = graphRect.origin.y;
        CGFloat datumHeight = 10;
        NSRect rect = NSMakeRect(0, 0, 3, 20);

        for (int j = 0; j < [datums count]; j++) {
            DPTimerDatum *subDatum = [datums objectAtIndex: j];
            //            NSLog(@"interval = %.0f (%f), startDate = %@, endDate = %@", subDatum.interval, (subDatum.interval / 3600), subDatum.startDate, subDatum.endDate);

            datumX = graphRect.origin.x + (self.widthForSecond * [subDatum.startDate timeIntervalSinceDate: self.datum.startDate]);
            datumY = (graphRect.origin.y + 10) + (j * (datumHeight + 10));
            CGFloat datumWidth = self.widthForSecond * subDatum.interval;
            rect = NSMakeRect(datumX, datumY, datumWidth, datumHeight);

            NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect: rect radius: 2.5];
            [[[NSColor yellowColor] colorWithAlphaComponent: 0.5] set];
            [[NSColor yellowColor] setStroke];
            [path setLineWidth: 0.5];
            [path fill];
            [path stroke];
        }
    }

}


- (void) drawHourMarks {

    NSDate *startDate = self.datum.startDate;
    NSLog(@"self.datum.startDate = %@", self.datum.startDate);
    //    NSInteger hours = [startDate hoursBeforeDate: [NSDate date]];
    //    NSLog(@"hours = %li", hours);

    CGFloat numMarks = self.displayedInterval / self.hourInterval;
    [self drawMarks: numMarks];
}

- (CGFloat) tickWidth {
    CGFloat quarterHours = self.numMarks * 4;
    CGFloat hourWidth = (self.graphRect.size.width - 1) / self.numMarks;

    return hourWidth / 4;
}


- (CGFloat) numMarks {
    return self.displayedInterval / self.hourInterval;
}

- (CGFloat) widthForSecond {
    NSTimeInterval fifteen = 60 * 15;
    CGFloat ret = self.tickWidth / fifteen;
    return ret;
}

- (void) drawMarks: (CGFloat) numMarks {
    CGFloat bottomOffset = self.graphRect.origin.y;
    CGFloat xOffset = self.graphRect.origin.x;
    CGFloat width = self.graphRect.size.width;
    CGFloat hourWidth = (width - 1) / numMarks;


    NSMutableAttributedString *string = [self attributedStringForLabel: [NSString stringWithFormat: @"%i:00", 0]];


    CGFloat quarterHours = numMarks * 4;
    CGFloat miniRectWidth = hourWidth / 4;

    for (int j = 0; j < quarterHours; j++) {

        NSRect miniRect = NSMakeRect(xOffset + (miniRectWidth * j),
                bottomOffset,
                0.5,
                self.hourTickHeight - (self.tickSpacingOld * 2));

        if (j % 4 == 0) {
            miniRect.size.height = self.hourTickHeight;
            CGFloat textRectX = miniRect.origin.x;
            [self drawLabelText: [NSString stringWithFormat: @"%i:00", j / 4] offset: textRectX];

            NSRect textRect = NSMakeRect(textRectX, 0, string.size.width, string.size.height);
            string = [self attributedStringForLabel: [NSString stringWithFormat: @"%i:00", j / 4]];
            [string drawInRect: textRect];
        }

        [self.hourTickColor set];
        NSRectFill(miniRect);
        //        NSFrameRectWithWidth(miniRect, 0.5);

    }

    CGFloat remainder = fmodf(numMarks, 1);
    if (remainder == 0) {
        CGFloat textRectX = (xOffset + (numMarks * hourWidth));
        NSRect textRect = NSMakeRect(textRectX, 0, string.size.width, string.size.height);
        string = [self attributedStringForLabel: [NSString stringWithFormat: @"%i:00", (int) numMarks + 1]];
        [string drawInRect: textRect];

    } else {

    }

}

- (void) drawLabelText: (NSString *) aString offset: (CGFloat) offsetX {
    NSAttributedString *string = [self attributedStringForLabel: aString];

    NSRect textRect = NSMakeRect(offsetX, 0, string.size.width, string.size.height);
    [string drawInRect: textRect];
}


- (void) drawMiniMarks: (CGFloat) hourWidth rect: (NSRect) rect {
    CGFloat miniRectWidth = hourWidth / 4;
    for (int k = 0; k < 4; k++) {
        NSRect miniRect = NSMakeRect(rect.origin.x + (miniRectWidth * k), rect.origin.y, rect.size.width, self.hourTickHeight - (self.tickSpacingOld * 2));
        if (k == 0) {
            miniRect.size.height = self.hourTickHeight;
        }
        //            miniRect.size.height = k == 2 ? (self.hourTickHeight - self.tickSpacingOld) : miniRect.size.height;

        [self.hourTickColor set];
        NSFrameRectWithWidth(miniRect, 0.5);

    }

}



#pragma mark Rects


- (NSRect) graphRect {
    CGFloat yOffset = 6;
    NSRect modBounds = self.bounds;
    modBounds.origin.y += (self.attributedString.size.height + yOffset);
    modBounds.size.height -= (self.attributedString.size.height + yOffset);
    modBounds = NSInsetRect(modBounds, 20, 0);
    return modBounds;
}


- (NSColor *) hourTickColor {
    return [NSColor whiteColor];
}

- (CGFloat) hourTickHeight {
    return 20.0;
}

- (CGFloat) tickSpacingOld {
    return 5.0;
}


- (NSTimeInterval) displayedInterval {
    NSTimeInterval ret = 5.5 * self.hourInterval;
    if (self.datum) {
        ret = self.datum.interval;
    }
    return ret;
}

- (NSTimeInterval) hourInterval {
    return 60 * 60;
}


- (NSTimeInterval) minute {
    return 60;
}

#pragma mark Getters


- (BOOL) isOpaque {
    return NO;
}

- (BOOL) isFlipped {
    return YES;
}


@end