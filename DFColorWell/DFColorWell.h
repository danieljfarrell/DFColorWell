//
//  DFColorWell.h
//  DFColorWell
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DFColorWell;

/** 
 The DFColorWellDelegate protocol defines the optional methods implemented by delegates of DFColorWell objects. Using a color well delegate allows you to customize the color matrix contained in the control's popover. A table view delegate provides the number of rows and columns and a NSColor object for each index pair.
 */
@protocol DFColorWellDelegate <NSObject>

@required

/** 
 Returns the number of rows in the color well's popover.
 
 @param colorWell the color well object that sent the message
 
 @return The number of rows in the color matrix.
 
 */
- (NSUInteger) numberOfRowsInColorWell:(DFColorWell*)colorWell;

/**
 Returns the number of columns in the color well's popover.
 
 @param colorWell the color well object that sent the message
 
 @return The number of columns in the color matrix.
 
 */
- (NSUInteger) numberOfColumnsInColorWell:(DFColorWell*)colorWell;

/**
 Called by the color well to return the color at the specified row and column.
 
  Return `nil` or `[NSNull null]` from this method if the color well should not draw a color swatch at the specified index.
 
  @param colorWell the color well object that sent the message
  @param column the column index of the color swatch
  @param row the row index of the color swatch
 
 @return the color at the specified row and column.
 
 */
- (NSColor*) colorWell:(DFColorWell*)colorWell colorAtColumn:(NSUInteger)column row:(NSUInteger)row;

@end

/**
 A `DFColorWell` is an `NSControl` for selecting and displaying a single colour value. The colour well's appearance is modelled after the control first seen in Pages 5, Numbers 3 and Keynote 6 on the Mac and the related applications in iCloud.
 
 The colour well is comprised of two sections: a colour swatch and a colour panel button. Clicking the colour swatch launches a popover that displays a build-in list of colours that can be selected. Alternatively, clicking the colour panel button launches a `NSColorPanel`, allowing the user to select additional colours.
 
 The colours that appears in the popover can be customised by implementing the colour wells delegate protocol, to learn more about customisation see DFColorWellDelegate Protocol Reference.
 
 ## Usage
 
 The control should used added to a user interface using Xcode:
 
 1. Drag out a custom NSView
 2. Set the placeholder intrinsic content size to 67px by 23px
 3. Change the Custom Class option to DFColorWell
 
 `DFColorWell` has a fixed sizes of 67px wide by 23px high. To provide this information to the Cocoa layout system the control implements `-intrinisicContentSize`. Duplicating these values in Interface Builder will allows developers to layout the control as it will be displayed when the application runs.
 
 @warning `DFColorWell` is not a drop in replacement for a `NSColorWell` because it does not attempt to implement the same interface.
 */
IB_DESIGNABLE
@interface DFColorWell : NSControl <NSDraggingSource, NSDraggingDestination>


///-------------------------
/// @name Setting the colour
///-------------------------


/** The color displayed in the color well.
 
 Setting a new color causes the view to reload.
 
 When setting the color nil values are ignored.
 
 This property is KVO observable.
 */
@property NSColor *color;

///--------------------------------------------------
/// @name Customising the colors shown in the popover
///--------------------------------------------------


/** A delegate which implements the DFColorWellDelegate protocol (optional).
 
 During initialisation this property is set to an internal delegate which provide default colour matrix view for the popover.
 
 */
@property IBOutlet id <DFColorWellDelegate> delegate;

#pragma mark - Drawing convenience methods

///----------------------------
/// @name Drawing colour swatch
///----------------------------

/** Class method is used by DFColorWell instances to draw the color a swatch.
 @param frame the rect in the coordinate system of the current graphic context, where the colour swatch should be draw
 @param color the color that should be draw
 @param shouldDrawBorder a flag indicating whether the border around the color swatch should also be draw.
*/
+ (void) drawColorSwatchWithFrame:(NSRect)frame color:(NSColor*)color shouldDrawBorder:(BOOL)shouldDrawBorder;

@end
