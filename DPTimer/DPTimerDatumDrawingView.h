//
// Created by Dani Postigo on 2/21/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPTimerDatum;
@class DPTimerDatumInfoView;

@interface DPTimerDatumDrawingView : NSView {
    DPTimerDatum *datum;

    NSFont *font;
    NSDateFormatter *formatter;


    NSMutableArray *trackingAreas;
    NSEdgeInsets viewInsets;
    NSEdgeInsets datumInsets;

    CGFloat datumHeight;
    NSColor *datumColor;
    NSColor *datumBorderColor;

    NSDateFormatter *labelDateFormatter;
    NSTextAlignment labelAlignment;
    NSColor *labelColor;
    NSTimeInterval labelInterval;
    NSColor *minorTickColor;
    CGFloat minorTickHeight;

    NSDate *tickStartTime;
    NSDate *tickStopTime;
    CGFloat tickHeight;
    NSSize tickOffset;
    CGFloat tickSpacing;
    CGFloat minimumTickSpacing;

    BOOL drawsAxis;
    NSPoint lastPoint;
    DPTimerDatum *selectedDatum;
    DPTimerDatumInfoView *infoView;
}

@property(nonatomic, strong) NSFont *font;
@property(nonatomic, strong) DPTimerDatum *datum;
@property(nonatomic, strong) NSDateFormatter *formatter;
@property(nonatomic) NSTimeInterval labelInterval;
@property(nonatomic, strong) NSColor *minorTickColor;
@property(nonatomic) CGFloat tickHeight;
@property(nonatomic) CGFloat minorTickHeight;
@property(nonatomic) CGFloat tickSpacing;
@property(nonatomic) NSSize tickOffset;
@property(nonatomic) NSTextAlignment labelAlignment;
@property(nonatomic, strong) NSColor *labelColor;
@property(nonatomic, strong) NSDate *tickStartTime;
@property(nonatomic, strong) NSDate *tickStopTime;
@property(nonatomic, strong) NSDateFormatter *labelDateFormatter;
@property(nonatomic) BOOL drawsAxis;
@property(nonatomic) NSEdgeInsets datumInsets;
@property(nonatomic) NSEdgeInsets viewInsets;
@property(nonatomic, strong) NSMutableArray *trackingAreas;
@property(nonatomic) NSPoint lastPoint;
@property(nonatomic) CGFloat minimumTickSpacing;
@property(nonatomic) CGFloat datumHeight;
@property(nonatomic, strong) NSColor *datumColor;
@property(nonatomic, strong) NSColor *datumBorderColor;
@property(nonatomic, strong) DPTimerDatum *selectedDatum;
@property(nonatomic, strong) DPTimerDatumInfoView *infoView;
@end