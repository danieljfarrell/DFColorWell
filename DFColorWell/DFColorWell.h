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
- (NSUInteger) numberOfRowsInColorWell:(DFColorWell*)colorSelectorView;
- (NSUInteger) numberOfColumnsInColorWell:(DFColorWell*)colorSelectorView;
- (NSColor*) colorWell:(DFColorWell*)colorSelectorView colorAtColumn:(NSUInteger)column row:(NSUInteger)row;

@end

@interface DFColorWell : NSView <NSDraggingSource, NSDraggingDestination>

@property NSColor *color;

@property IBOutlet id <DFColorWellDelegate> delegate;

@end
