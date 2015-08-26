//
//  DFColorWell.m
//  DFColorWell.h
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import "DFColorWell.h"
#import "DFColorGridView.h"

#pragma mark - Build-in color well delegate

@interface DFColorGridViewDefaultDelegate : NSObject <DFColorWellDelegate>
@property NSMutableDictionary *colorMatrix;
@end

@implementation DFColorGridViewDefaultDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _generateColors];
    }
    return self;
}

- (void) _generateColors {
    
    _colorMatrix = [NSMutableDictionary new];
    _colorMatrix[@"(0,0)"] = [NSColor colorWithCalibratedRed:0.807 green:0.845 blue:0.886 alpha:1.000];
    _colorMatrix[@"(0,1)"] = [NSColor colorWithCalibratedRed:0.587 green:0.673 blue:0.767 alpha:1.000];
    _colorMatrix[@"(0,2)"] = [NSColor colorWithCalibratedRed:0.236 green:0.365 blue:0.518 alpha:1.000];
    _colorMatrix[@"(0,3)"] = [NSColor colorWithCalibratedRed:0.176 green:0.262 blue:0.364 alpha:1.000];
    _colorMatrix[@"(0,4)"] = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    _colorMatrix[@"(1,0)"] = [NSColor colorWithCalibratedRed:0.864 green:0.889 blue:0.849 alpha:1.000];
    _colorMatrix[@"(1,1)"] = [NSColor colorWithCalibratedRed:0.527 green:0.589 blue:0.480 alpha:1.000];
    _colorMatrix[@"(1,2)"] = [NSColor colorWithCalibratedRed:0.237 green:0.341 blue:0.182 alpha:1.000];
    _colorMatrix[@"(1,3)"] = [NSColor colorWithCalibratedRed:0.150 green:0.229 blue:0.108 alpha:1.000];
    _colorMatrix[@"(1,4)"] = [NSColor colorWithCalibratedRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    
    _colorMatrix[@"(2,0)"] = [NSColor colorWithCalibratedRed:0.987 green:0.902 blue:0.731 alpha:1.000];
    _colorMatrix[@"(2,1)"] = [NSColor colorWithCalibratedRed:0.854 green:0.705 blue:0.422 alpha:1.000];
    _colorMatrix[@"(2,2)"] = [NSColor colorWithCalibratedRed:0.570 green:0.397 blue:0.182 alpha:1.000];
    _colorMatrix[@"(2,3)"] = [NSColor colorWithCalibratedRed:0.287 green:0.201 blue:0.126 alpha:1.000];
    _colorMatrix[@"(2,4)"] = [NSColor colorWithCalibratedRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    
    _colorMatrix[@"(3,0)"] = [NSColor colorWithCalibratedRed:0.915 green:0.629 blue:0.521 alpha:1.000];
    _colorMatrix[@"(3,1)"] = [NSColor colorWithCalibratedRed:0.889 green:0.465 blue:0.306 alpha:1.000];
    _colorMatrix[@"(3,2)"] = [NSColor colorWithCalibratedRed:0.820 green:0.263 blue:0.105 alpha:1.000];
    _colorMatrix[@"(3,3)"] = [NSColor colorWithCalibratedRed:0.633 green:0.218 blue:0.014 alpha:1.000];
    _colorMatrix[@"(3,4)"] = [NSColor colorWithCalibratedRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    
    _colorMatrix[@"(4,0)"] = [NSColor colorWithCalibratedRed:0.875 green:0.492 blue:0.473 alpha:1.000];
    _colorMatrix[@"(4,1)"] = [NSColor colorWithCalibratedRed:0.662 green:0.166 blue:0.194 alpha:1.000];
    _colorMatrix[@"(4,2)"] = [NSColor colorWithCalibratedRed:0.493 green:0.074 blue:0.103 alpha:1.000];
    _colorMatrix[@"(4,3)"] = [NSColor colorWithCalibratedRed:0.349 green:0.000 blue:0.013 alpha:1.000];
    _colorMatrix[@"(4,4)"] = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    
    _colorMatrix[@"(5,0)"] = [NSColor colorWithCalibratedRed:0.629 green:0.602 blue:0.701 alpha:1.000];
    _colorMatrix[@"(5,1)"] = [NSColor colorWithCalibratedRed:0.426 green:0.388 blue:0.527 alpha:1.000];
    _colorMatrix[@"(5,2)"] = [NSColor colorWithCalibratedRed:0.303 green:0.269 blue:0.393 alpha:1.000];
    _colorMatrix[@"(5,3)"] = [NSColor colorWithCalibratedRed:0.199 green:0.178 blue:0.253 alpha:1.000];
    _colorMatrix[@"(5,4)"] = [NSNull null];
    
}

- (NSUInteger) numberOfColumnsInColorWell:(DFColorWell *)colorWell {
    return 6;
}

- (NSUInteger) numberOfRowsInColorWell:(DFColorWell *)colorWell {
    return 5;
}

- (NSColor*) colorWell:(DFColorWell *)colorWell colorAtColumn:(NSUInteger)column row:(NSUInteger)row {
    NSString *key = [NSString stringWithFormat:@"(%lu,%lu)", (unsigned long)column,(unsigned long)row];
    NSColor *color = _colorMatrix[key];
    return color;
}

@end

#pragma mark - Control geometry 

#define INTRINSIC_WIDTH 66.0
#define INTRINSIC_HEIGHT 22.0
#define BUTTON_SIDE_LENGTH 22.0
#define MOUSE_OVER_INDICATOR_SIDE_LENGTH 13.0
#define MOUSE_OVER_INDICATOR_PADDING 4.0
#define MOUSE_OVER_INDICATOR_TIC_UNIT_LENGTH 3.0

#define BUTTON_RADIUS 4.0
#define BUTTON_IMAGE_INSET 3.0
#define DRAG_IMAGE_SIDE_LENGTH 18.0
#define DRAG_IMAGE_PADDING 3.0
#define DRAG_IMAGE_CORNER_RADIUS 2.0
#define DRAG_IMAGE_X_OFFSET 5.0
#define DRAG_IMAGE_Y_OFFSET 0.0

#pragma mark - DFColorWell 

static void * kDFColorSwatchTooltipArea = &kDFColorSwatchTooltipArea;
static void * kDFButtonTooltipArea = &kDFButtonTooltipArea;

@interface DFColorWell ()

@property BOOL shouldDrawMouseOverIndicator;

@property BOOL shouldDrawDarkerButtonRegion;

@property BOOL shouldDrawButtonRegionWithSelectedColor;

@property BOOL shouldDrawFocusRing;

@property NSTrackingArea *colorSwatchTrackingArea;

@property NSTrackingArea *buttonTrackingArea;

@property NSBezierPath *controlColorSwatchPath;

@property NSBezierPath *controlButtonPath;

@property NSBezierPath *controlOuterBorderPath;

// Popover and content view controller
@property DFColorGridView *colorGridView;

@property NSPopover *popover;

@end

@implementation DFColorWell


- (void) awakeFromNib {
    
    // Layout
    [self setContentHuggingPriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationHorizontal];
    [self setContentHuggingPriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationVertical];
    
    // Drag and drop
    [self registerForDraggedTypes:@[NSPasteboardTypeColor]];
    
    // Mouse interactions
    NSTrackingAreaOptions options = (NSTrackingActiveInKeyWindow |
                                     NSTrackingMouseEnteredAndExited );
    
    
    _colorSwatchTrackingArea = [[NSTrackingArea alloc] initWithRect:[self _controlColorSwatchFrame]
                                                            options:options
                                                              owner:self
                                                           userInfo:nil];
    
    _buttonTrackingArea = [[NSTrackingArea alloc] initWithRect:[self _controlButtonFrame]
                                                       options:options
                                                         owner:self
                                                      userInfo:nil];
    
    [self addTrackingArea:_colorSwatchTrackingArea];
    [self addTrackingArea:_buttonTrackingArea];
    
    [self addToolTipRect:[self _controlColorSwatchFrame] owner:self userData:kDFColorSwatchTooltipArea];
    [self addToolTipRect:[self _controlButtonFrame] owner:self userData:kDFButtonTooltipArea];
    
    [self addTrackingArea:_colorSwatchTrackingArea];
    [self addTrackingArea:_buttonTrackingArea];
    
    [self addToolTipRect:[self _controlColorSwatchFrame] owner:self userData:kDFColorSwatchTooltipArea];
    [self addToolTipRect:[self _controlButtonFrame] owner:self userData:kDFButtonTooltipArea];
    
    // Default, non-nil, color
    if (self.color == nil) {
        self.color = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    self.delegate = [[DFColorGridViewDefaultDelegate alloc] init];
}

#pragma mark - Tooltips

- (NSString*) view:(NSView *)view stringForToolTip:(NSToolTipTag)tag point:(NSPoint)point userData:(void *)data {
    
    if (view == self) {
        
        if (data == kDFColorSwatchTooltipArea) {
            return @"Click to choose a colour.";
        }
        
        if (data == kDFButtonTooltipArea) {
            return @"Click to show more colours or show your own.";
        }
    }
    return nil;
}

#pragma mark - Control private drawing methods

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [self _drawControlColorSwatch];
    [self _drawControlButton];
    [self _drawControlOuterBorder];
    [self _drawSeparatorLine];
    
    if (_shouldDrawFocusRing) {
        [self _drawInternalFocusRingIndicator];
    }
}

/** Returns the stroke width to draw exactly one on-screen pixel.
 
 This takes the screen's scale factor into account (retina vs. non-retina).
 */
- (CGFloat)_strokeWidth {
    CGFloat scale = self.window.backingScaleFactor;
    
    if (scale == 0) {
        // View is not yet attached to a window.
        return 1;
    } else {
        return 1 / scale;
    }
}

/** Insets the given rectangle for path calculations that take are suitable for stroking exactly
 one pixel thick paths.
 
 In Cocoa, stroking is done by drawing to both sides of an infinitely thin line. So to draw a line
 that should be 1pt wide, the coordinates must be offset by 0.5pt.
 */
- (NSRect)_insetRectForStroking:(NSRect)rect {
    CGFloat inset = [self _strokeWidth] / 2;
    return NSInsetRect(rect, inset, inset);
}

#pragma mark Color swatch

/* The basic frame of the control's color swatch.
 
 This frame used to generate a path with rounded corners for the control.
 */
- (NSRect) _controlColorSwatchFrame {
    return NSMakeRect(0, 0, INTRINSIC_WIDTH  - BUTTON_SIDE_LENGTH, INTRINSIC_HEIGHT);
}

- (NSBezierPath*) _generateControlColorSwatchPath {

    // Since we're stroking the outline later on we also have to inset the rectangle here to get
    // a pixel-perfect shape without any artifacts that might peek out from below the stroked border.
    NSRect rect = [self _insetRectForStroking:[self _controlColorSwatchFrame]];
    // Don't inset on the right border.
    rect.size.width += [self _strokeWidth];
    
    CGFloat r = BUTTON_RADIUS;
    
    NSPoint pt1 = NSMakePoint(NSMinX(rect) + r, NSMaxY(rect));
    NSPoint pt2 = NSMakePoint(NSMinX(rect), NSMaxY(rect));
    NSPoint pt3 = NSMakePoint(NSMinX(rect), NSMaxY(rect) - r);
    NSPoint pt4 = NSMakePoint(NSMinX(rect), NSMinY(rect) + r);
    NSPoint pt5 = NSMakePoint(NSMinX(rect), NSMinY(rect));
    NSPoint pt6 = NSMakePoint(NSMinX(rect) + r, NSMinY(rect));
    NSPoint pt7 = NSMakePoint(NSMaxX(rect), NSMinY(rect));
    NSPoint pt8 = NSMakePoint(NSMaxX(rect), NSMaxY(rect));
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:pt1];
    [path appendBezierPathWithArcFromPoint:pt2 toPoint:pt3 radius:r];
    [path lineToPoint:pt4];
    [path appendBezierPathWithArcFromPoint:pt5 toPoint:pt6 radius:r];
    [path lineToPoint:pt7];
    [path lineToPoint:pt8];
    [path closePath];
    
    return path;
}

- (NSBezierPath*) _controlColorSwatchLowerTrianglePath {
    
    NSRect rect = [self _controlColorSwatchFrame];
    CGFloat r = BUTTON_RADIUS;
    
    NSPoint pt1 = NSMakePoint(NSMinX(rect) - r, NSMinY(rect) - r);
    NSPoint pt2 = NSMakePoint(NSMaxX(rect), NSMaxY(rect));
    NSPoint pt3 = NSMakePoint(NSMaxX(rect), NSMinY(rect));
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:pt1];
    [path lineToPoint:pt2];
    [path lineToPoint:pt3];
    [path closePath];
    
    return path;
}

- (void) _drawControlColorSwatch {
    
    /* Draw the color area */
    
    // Black and white upper and lower triangle in the background
    if (_controlColorSwatchPath == nil) {
        _controlColorSwatchPath = [self _generateControlColorSwatchPath];
    }
    
    [[NSColor blackColor] setFill];
    [_controlColorSwatchPath fill];
    [[NSColor whiteColor] setFill];
    [[self _controlColorSwatchLowerTrianglePath] fill];
    
    // Now over fill with the actual color
    [_color setFill];
    [_controlColorSwatchPath fill];
    
    if (_shouldDrawMouseOverIndicator) {
        [self _drawMouseOverIndicator];
        [self _drawMouseOverIndicatorChevron];
    }
}

#pragma mark Button

- (NSRect) _controlButtonFrame {
    NSRect colorRect = [self _controlColorSwatchFrame];
    return NSMakeRect(NSMaxX(colorRect), 0, BUTTON_SIDE_LENGTH, INTRINSIC_HEIGHT);
}

- (NSBezierPath*) _generatedButtonPath {
    
    
    NSRect rect = [self _controlButtonFrame];
    CGFloat r = BUTTON_RADIUS;
    
    // top right corner
    NSPoint pt1 = NSMakePoint(NSMaxX(rect) - r, NSMaxY(rect));
    NSPoint pt2 = NSMakePoint(NSMaxX(rect), NSMaxY(rect));
    NSPoint pt3 = NSMakePoint(NSMaxX(rect), NSMaxY(rect) - r);
    // bottom right corner
    NSPoint pt4 = NSMakePoint(NSMaxX(rect), NSMinY(rect) + r);
    NSPoint pt5 = NSMakePoint(NSMaxX(rect), NSMinY(rect));
    NSPoint pt6 = NSMakePoint(NSMaxX(rect) - r, NSMinY(rect));
    // bottom left and top right corners
    NSPoint pt7 = NSMakePoint(NSMinX(rect), NSMinY(rect));
    NSPoint pt8 = NSMakePoint(NSMinX(rect), NSMaxY(rect));
    
    // Create path with rounded corners
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:pt1];
    [path appendBezierPathWithArcFromPoint:pt2 toPoint:pt3 radius:r];
    [path lineToPoint:pt4];
    [path appendBezierPathWithArcFromPoint:pt5 toPoint:pt6 radius:r];
    [path lineToPoint:pt7];
    [path lineToPoint:pt8];
    [path closePath];
    
    return path;
}

- (void) _drawControlButton {
    
    /* Draw the button area */
    
    if (_controlButtonPath == nil) {
        _controlButtonPath = [self _generatedButtonPath];
    }
    
    [[NSColor controlColor] setFill];
    if (_shouldDrawButtonRegionWithSelectedColor) {
        [[NSColor alternateSelectedControlColor] setFill];
        
    } else if (_shouldDrawDarkerButtonRegion) {
        [[NSColor colorWithCalibratedWhite:0.825 alpha:1.0] setFill];
    }
    
    [_controlButtonPath fill];
    
    // Draw the image centre in this region
    NSImage *image = [NSImage imageNamed:@"DFColorWheel"];
    [image drawInRect:NSInsetRect([self _controlButtonFrame], BUTTON_IMAGE_INSET, BUTTON_IMAGE_INSET)];
    
}

#pragma mark Control border

- (NSBezierPath*) _generateControlOuterBorderPath {
    
    NSRect rect = NSUnionRect([self _controlColorSwatchFrame], [self _controlButtonFrame]);
    rect = [self _insetRectForStroking:rect];
    
    CGFloat r = BUTTON_RADIUS;
    
    // Top left
    NSPoint pt1 = NSMakePoint(NSMinX(rect) + r, NSMaxY(rect));
    NSPoint pt2 = NSMakePoint(NSMinX(rect), NSMaxY(rect));
    NSPoint pt3 = NSMakePoint(NSMinX(rect), NSMaxY(rect) - r);
    // Bottom left
    NSPoint pt4 = NSMakePoint(NSMinX(rect), NSMinY(rect) + r);
    NSPoint pt5 = NSMakePoint(NSMinX(rect), NSMinY(rect));
    NSPoint pt6 = NSMakePoint(NSMinX(rect) + r, NSMinY(rect));
    // Bottom right
    NSPoint pt7 = NSMakePoint(NSMaxX(rect) - r, NSMinY(rect));
    NSPoint pt8 = NSMakePoint(NSMaxX(rect), NSMinY(rect));
    NSPoint pt9 = NSMakePoint(NSMaxX(rect), NSMinY(rect) + r);
    // Top right
    NSPoint pt10 = NSMakePoint(NSMaxX(rect), NSMaxY(rect) - r);
    NSPoint pt11 = NSMakePoint(NSMaxX(rect), NSMaxY(rect));
    NSPoint pt12 = NSMakePoint(NSMaxX(rect) - r, NSMaxY(rect));
    
    
    // Create rounded rect
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:pt1];
    [path appendBezierPathWithArcFromPoint:pt2 toPoint:pt3 radius:r];
    [path lineToPoint:pt4];
    [path appendBezierPathWithArcFromPoint:pt5 toPoint:pt6 radius:r];
    [path lineToPoint:pt7];
    [path appendBezierPathWithArcFromPoint:pt8 toPoint:pt9 radius:r];
    [path lineToPoint:pt10];
    [path appendBezierPathWithArcFromPoint:pt11 toPoint:pt12 radius:r];
    [path closePath];
    
    return path;
    
}

- (void) _drawControlOuterBorder {
    
    if (_controlOuterBorderPath == nil) {
        _controlOuterBorderPath = [self _generateControlOuterBorderPath];
    }
    
    /* Stroke the border */
    [_controlOuterBorderPath setLineWidth:[self _strokeWidth]];
    [[NSColor colorWithCalibratedWhite:0.5 alpha:1.0] setStroke];
    [_controlOuterBorderPath stroke];
}

- (void) _drawSeparatorLine {
    // The x coordinate needs to offset by half the stroke width.
    CGFloat x = NSMaxX([self _controlColorSwatchFrame]) + ([self _strokeWidth] / 2);
    NSPoint startPoint = NSMakePoint(x, NSMaxY([self _controlColorSwatchFrame]));
    NSPoint endPoint = NSMakePoint(x, NSMinY([self _controlColorSwatchFrame]));
    [[NSColor colorWithCalibratedWhite:0.5 alpha:1.0] setStroke];
    NSBezierPath *line = [NSBezierPath bezierPath];
    [line moveToPoint:startPoint];
    [line lineToPoint:endPoint];
    [line setLineWidth:[self _strokeWidth]];
    [line stroke];
}

#pragma mark Focus ring on drag

- (void) _drawInternalFocusRingIndicator {
    
    
    NSColor *startingColor = [NSColor alternateSelectedControlColor];
    NSColor *endingColor = [[NSColor alternateSelectedControlColor] blendedColorWithFraction:0.4 ofColor:[NSColor whiteColor]];
    NSGradient *gradientFill = [[NSGradient alloc] initWithStartingColor:startingColor
                                                             endingColor:endingColor];
    
    CGFloat padding = 4.0;
    NSRect stampRect = NSInsetRect([self _controlColorSwatchFrame], padding, padding);
    NSBezierPath *stampPath = [NSBezierPath bezierPathWithRect:stampRect];
    NSBezierPath *outerPath = [_controlColorSwatchPath copy]; // Need to make a copy here because we will reverse the path to enable the cut-out
    stampPath = [stampPath bezierPathByReversingPath];
    [outerPath appendBezierPath:stampPath];
    [gradientFill drawInBezierPath:outerPath angle:90.0];
}

#pragma mark Mouse over indicator

- (NSRect) _mouseOverIndicatorFrame {
    
    NSRect colorRect = [self _controlColorSwatchFrame];
    NSRect basicRect = NSMakeRect(NSMaxX(colorRect) - MOUSE_OVER_INDICATOR_SIDE_LENGTH,
                                  0.5 * (INTRINSIC_HEIGHT - MOUSE_OVER_INDICATOR_SIDE_LENGTH),MOUSE_OVER_INDICATOR_SIDE_LENGTH,
                                  MOUSE_OVER_INDICATOR_SIDE_LENGTH);
    return NSOffsetRect(basicRect, -MOUSE_OVER_INDICATOR_PADDING, 0.0);
}

- (void) _drawMouseOverIndicator {
    
    NSBezierPath* ovalPath = [NSBezierPath bezierPathWithOvalInRect:[self _mouseOverIndicatorFrame]];
    NSColor* color = [NSColor colorWithCalibratedWhite:0.4 alpha:0.4];
    [color setFill];
    [ovalPath fill];
}

- (void) _drawMouseOverIndicatorChevron {
    
    
    /* This is the white "tick" or chevron that appears in the circle to
     indicated that the popover can be launched by clicking the color segment.*/
    NSRect frame = [self _mouseOverIndicatorFrame];
    NSPoint mid = NSMakePoint(NSMidX(frame), NSMidY(frame));
    NSPoint secondPoint = NSMakePoint(mid.x, mid.y - MOUSE_OVER_INDICATOR_TIC_UNIT_LENGTH * 0.5);
    NSPoint firstPoint = NSMakePoint(secondPoint.x - MOUSE_OVER_INDICATOR_TIC_UNIT_LENGTH, secondPoint.y + MOUSE_OVER_INDICATOR_TIC_UNIT_LENGTH);
    NSPoint thridPoint = NSMakePoint(secondPoint.x + MOUSE_OVER_INDICATOR_TIC_UNIT_LENGTH, secondPoint.y + MOUSE_OVER_INDICATOR_TIC_UNIT_LENGTH);
    
    NSBezierPath *tickPath = [NSBezierPath bezierPath];
    [tickPath moveToPoint:firstPoint];
    [tickPath lineToPoint:secondPoint];
    [tickPath lineToPoint:thridPoint];
    [tickPath setLineWidth:[self _strokeWidth] * 2];
    [[NSColor whiteColor] setStroke];
    [tickPath stroke];
    
}


#pragma mark - Public drawing methods

+ (void) drawColorSwatchWithFrame:(NSRect)frame color:(NSColor*) color shouldDrawBorder:(BOOL)shouldDrawBorder {
    
    [NSGraphicsContext saveGraphicsState];
    

    
    // Fill with black, this will end up looking like the upper triangle.
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:frame];
    [[NSColor blackColor] setFill];
    [path fill];
    
    // White lower triangle.
    NSPoint p1 = NSMakePoint(NSMinX(frame), NSMinY(frame));
    NSPoint p2 = NSMakePoint(NSMaxX(frame), NSMaxY(frame));
    NSPoint p3 = NSMakePoint(NSMaxX(frame), NSMinY(frame));
    
    NSBezierPath *lowerTrianglePath = [NSBezierPath bezierPath];
    [lowerTrianglePath moveToPoint:p1];
    [lowerTrianglePath lineToPoint:p2];
    [lowerTrianglePath lineToPoint:p3];
    [lowerTrianglePath closePath];
    [[NSColor whiteColor] setFill];
    [lowerTrianglePath fill];
    
    // Now over draw the actual color of the cell above the black and white triangles,
    // if the colour is transparent then we see the black/white triangle background,
    // this is the standard approach with OSX colour wells.
    [color setFill];
    [path fill];
    
    // Draw border
    if (shouldDrawBorder) {
        [[[NSColor darkGrayColor] colorWithAlphaComponent:0.5] setStroke];
        [path stroke];
    }
    
    [NSGraphicsContext restoreGraphicsState];
}


#pragma mark - Mouse tracking

- (void) mouseEntered:(NSEvent *)theEvent {
    
    NSTrackingArea *trackingArea = [theEvent trackingArea];
    if (trackingArea == nil) {
        return;
    }
    
    if (trackingArea == _colorSwatchTrackingArea) {
        _shouldDrawMouseOverIndicator = YES;
        [self setNeedsDisplay:YES];
    }
    
    if (trackingArea == _buttonTrackingArea) {
        _shouldDrawDarkerButtonRegion = YES;
        [self setNeedsDisplay:YES];
    }
}

- (void) mouseExited:(NSEvent *)theEvent {
    
    NSTrackingArea *trackingArea = [theEvent trackingArea];
    if (trackingArea == nil) {
        return;
    }
    
    if (trackingArea == _colorSwatchTrackingArea) {
        // Exited the color swatch
        _shouldDrawMouseOverIndicator = NO;
        [self setNeedsDisplay:YES];
    }
    
    if (trackingArea == _buttonTrackingArea) {
        _shouldDrawDarkerButtonRegion = NO;
        [self setNeedsDisplay:YES];
    }
}

- (void) mouseUp:(NSEvent *)theEvent {

    /* Mouse down either launches a popover or the color
     panel depending on the location in the view. */
    NSPoint locationInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    if (NSPointInRect(locationInView, [self _controlColorSwatchFrame])) {
        [self _handleMouseUpInColorRect];
    } else if (NSPointInRect(locationInView, [self _controlButtonFrame])){
        [self _handleMouseUpInButtonRect];
    }
}

- (void) mouseDragged:(NSEvent *)theEvent {
    
    id propertyListRep = [self.color pasteboardPropertyListForType:NSPasteboardTypeColor];
    NSPasteboardItem *pbItem = [[NSPasteboardItem alloc] initWithPasteboardPropertyList:propertyListRep ofType:NSPasteboardTypeColor];
    NSDraggingItem *item = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];
    
    NSColor *dragColor = [self.color copy];
    NSImage *contentImage = [NSImage imageWithSize:NSMakeSize(DRAG_IMAGE_SIDE_LENGTH, DRAG_IMAGE_SIDE_LENGTH) flipped:NO drawingHandler:^BOOL(NSRect dstRect) {
        
        NSRect imageRect = NSInsetRect(dstRect, DRAG_IMAGE_PADDING, DRAG_IMAGE_PADDING);
        NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:imageRect
                                                             xRadius:DRAG_IMAGE_CORNER_RADIUS
                                                             yRadius:DRAG_IMAGE_CORNER_RADIUS];
        [path setLineWidth:0.0];
        [[[NSColor darkGrayColor] colorWithAlphaComponent:0.5] setStroke];
        [dragColor setFill];
        [path fill];
        [path stroke];
        return YES;
    }];
    
    NSRect dragImageFrame = NSMakeRect(DRAG_IMAGE_X_OFFSET, DRAG_IMAGE_Y_OFFSET, DRAG_IMAGE_SIDE_LENGTH, DRAG_IMAGE_SIDE_LENGTH);
    [item setDraggingFrame:dragImageFrame contents:contentImage];
    id source = (id <NSDraggingSource>) self;
    [self beginDraggingSessionWithItems:@[item] event:theEvent source:source];
    
}


#pragma mark - Mouse Clicking

- (void) _handleMouseUpInColorRect {

    if (_colorGridView == nil) {
        _colorGridView = [[DFColorGridView alloc] initWithFrame:NSZeroRect];
        _colorGridView.translatesAutoresizingMaskIntoConstraints = YES;
        _colorGridView.colorWell = self;
    }
    
    
    // Check that popover is shown before creating a new popover
    // This fixed, https://github.com/danieljfarrell/DFColorWell/issues/3
    if([_popover isShown]){
        [_popover close];
        return;
    }
    

    // The color grid view knows it own size, set this here
    _popover = [[NSPopover alloc] init];
    [_popover setContentSize:[_colorGridView intrinsicContentSize]];
    
    // Set up popover and show
    NSViewController *contentViewController = [[NSViewController alloc] init];
    contentViewController.view = _colorGridView;
    [_popover setContentViewController:contentViewController];
    [_popover setAnimates:NO];
    [_popover setBehavior:NSPopoverBehaviorSemitransient];
    [_popover showRelativeToRect:[self _controlColorSwatchFrame] ofView:self preferredEdge:NSMinYEdge];
}

- (void) _handleMouseUpInButtonRect {
    
    if (_shouldDrawButtonRegionWithSelectedColor == YES) {
        
        _shouldDrawButtonRegionWithSelectedColor = NO;
        _shouldDrawDarkerButtonRegion = YES;
        NSColorPanel *panel = [NSColorPanel sharedColorPanel];
        [panel close];
        
        
    } else {
        
        _shouldDrawDarkerButtonRegion = NO;
        _shouldDrawButtonRegionWithSelectedColor = YES;
        [self setNeedsDisplay:YES];
        
        NSColorPanel *panel = [NSColorPanel sharedColorPanel];
        panel.showsAlpha = YES;
        panel.target = self;
        panel.action = @selector(handleColorPanelColorSelectionAction:);
        panel.color = self.color;
        [panel orderFront:nil];
        
        /* Capture the close of the color panel. */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowWillCloseNotification:) name:NSWindowWillCloseNotification object:panel];
        
    }

}

#pragma mark - Dealing with the NSColorPanel

- (void) handleWindowWillCloseNotification:(NSNotification*)notification {
    
    /* Remove the color panel notification */
    NSColorPanel *panel = [NSColorPanel sharedColorPanel];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowWillCloseNotification object:panel];
    
    /* Reset all the color panel values */
    panel.target = nil;
    panel.action = NULL;
    _shouldDrawButtonRegionWithSelectedColor = NO;
    [self setNeedsDisplay:YES];
}

- (void) handleColorPanelColorSelectionAction:(id)sender {
    self.color = [sender color];
}

#pragma mark - Setting the color

@synthesize color = _color;

- (void) setColor:(NSColor *)color {
    
    
    if (color == nil) {
        return;
    }
    
    [self willChangeValueForKey:@"color"];
    _color = color;
    [self setNeedsDisplay:YES];
    [self didChangeValueForKey:@"color"];
    
    // Set the control's target/action
    if ([self.target respondsToSelector:self.action]) {
        [NSApp sendAction:self.action to:self.target from:self];
    }
    
    // Hook into the popover here and if shown, close it
    if (_popover) {
        if ([_popover isShown]) {
            [_popover close];
        }
    }
}

- (NSColor*) color {
    return _color;
}

#pragma mark - Autolayout

- (NSSize) intrinsicContentSize {
    return NSMakeSize(INTRINSIC_WIDTH, INTRINSIC_HEIGHT);
}

#pragma mark - Dragging Source



- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context {
    
    switch(context) {
        case NSDraggingContextOutsideApplication:
            return NSDragOperationCopy | NSDragOperationMove;
            break;
            
        case NSDraggingContextWithinApplication:
        default:
            return NSDragOperationCopy | NSDragOperationMove;
            break;
    }
}


#pragma mark - Dragging Destination

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    
    // Don't allow drag and drop to self
    if ([sender draggingSource] == self) {
        return NSDragOperationNone;
    }
    
    NSColor *possiblyValidColor = [NSColor colorFromPasteboard:[sender draggingPasteboard]];
    if (possiblyValidColor) {
        _shouldDrawFocusRing = YES;
        [self setNeedsDisplay:YES];
    }
    return NSDragOperationMove;
}


- (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender {
    if ([NSColor colorFromPasteboard:[sender draggingPasteboard]]) {
        return YES;
    }
    return NO;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    
    if ([NSColor colorFromPasteboard:[sender draggingPasteboard]]) {
        
        NSColor *draggedColor = [NSColor colorFromPasteboard:[sender draggingPasteboard]];
        if (draggedColor) {
            self.color = draggedColor;
            _shouldDrawFocusRing = NO;
            [self setNeedsDisplay:YES];
        }
        return YES;
    }
    return NO;
}


@end
