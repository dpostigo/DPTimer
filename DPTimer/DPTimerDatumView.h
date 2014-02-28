//
// Created by Dani Postigo on 2/25/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPTimerDatum;
@class DPTimerDatumDrawingView;
@class DPScrollView;

@interface DPTimerDatumView : NSView {
    NSView *backgroundView;
    DPScrollView *scrollView;
    DPTimerDatumDrawingView *datumView;
}

@property(nonatomic, strong) NSFont *font;
@property(nonatomic, strong) DPTimerDatum *datum;
@property(nonatomic, strong) DPTimerDatumDrawingView *datumView;
@property(nonatomic, strong) DPScrollView *scrollView;
@property(nonatomic, strong) NSView *backgroundView;
@end