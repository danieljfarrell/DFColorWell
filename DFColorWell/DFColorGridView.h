//
//  DFColorGridView.h
//  DFColorSelector
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DFColorGridViewController;

IB_DESIGNABLE;
@interface DFColorGridView : NSView

@property CGFloat borderPadding;

@property CGFloat intercellSpacing;

@property CGFloat cellBorderLinewidth;

@property NSColor *cellBorderColor;

@property CGFloat cellWidth;

@property CGFloat cellHeight;

@property DFColorGridViewController *controller;

@end
