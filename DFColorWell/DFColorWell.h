//
//  DFColorSelectorView.h
//  DFColorSelector
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DFColorWell;

@protocol DFColorWellDelegate <NSObject>

@required
- (NSUInteger) numberOfRowsInColorSelectorView:(DFColorWell*)colorSelectorView;
- (NSUInteger) numberOfColumnsInColorSelectorView:(DFColorWell*)colorSelectorView;
- (NSColor*) colorSelectorView:(DFColorWell*)colorSelectorView colorAtRow:(NSUInteger)row column:(NSUInteger)column;

@end

@interface DFColorWell : NSView <NSDraggingSource, NSDraggingDestination>

@property NSColor *color;

@property IBOutlet id <DFColorWellDelegate> delegate;

@end
