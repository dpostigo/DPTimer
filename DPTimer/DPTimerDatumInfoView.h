//
// Created by Dani Postigo on 2/26/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPTimerDatum;

@interface DPTimerDatumInfoView : NSView {

    DPTimerDatum *datum;
    NSTextField *textField;
}

@property(nonatomic, strong) NSTextField *textField;
@property(nonatomic, strong) DPTimerDatum *datum;
@end