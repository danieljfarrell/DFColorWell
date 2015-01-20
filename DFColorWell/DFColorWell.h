//
//  DFColorWell.h
//  DFColorWell
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DFColorWell;

@protocol DFColorWellDelegate <NSObject>

@required
- (NSUInteger) numberOfRowsInColorWell:(DFColorWell*)colorWell;
- (NSUInteger) numberOfColumnsInColorWell:(DFColorWell*)colorWell;
- (NSColor*) colorWell:(DFColorWell*)colorWell colorAtColumn:(NSUInteger)column row:(NSUInteger)row;

@end

@interface DFColorWell : NSView <NSDraggingSource, NSDraggingDestination>

@property NSColor *color;

@property IBOutlet id <DFColorWellDelegate> delegate;

@end
