//
//  DFColorGridViewController.h
//  DFColorSelector
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DFColorWell;

@interface DFColorGridViewController : NSViewController <NSCollectionViewDelegate>

@property DFColorWell *colorSelectorView;

@property NSMutableArray *colorModelArray;


# pragma mark Wrapping the delegate calls

- (NSUInteger) numberOfRows;

- (NSUInteger) numberOfColumns;

- (NSColor*) colorAtColumn:(NSUInteger)columnIndex row:(NSUInteger)rowIndex;

@end
