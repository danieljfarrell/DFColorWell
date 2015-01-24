//
//  DFColorWell.m
//  DFColorWell.h
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import "DFColorWell.h"
#import "DFColorGridViewController.h"
#import "DFColorGridView.h"

#define INTRINSIC_WIDTH 65.0
#define INTRINSIC_HEIGHT 21.0
#define BUTTON_SIDE_LENGTH 21.0
#define MOUSE_OVER_INDICATOR_SIDE_LENGTH 13.0
#define MOUSE_OVER_INDICATOR_PADDING 4.0
#define MOUSE_OVER_INDICATOR_TIC_UNIT_LENGTH 3.0

#define BUTTON_RADIUS 4.0
#define COLOR_DRAG_RECT_SIDE_LENGTH 18.0

static void * kDFColorCellAreaUserInfo = &kDFColorCellAreaUserInfo;
static void * kDFButtonAreaUserInfo = &kDFButtonAreaUserInfo;

@interface DFColorWell ()

@property BOOL shouldDrawMouseOverIndicator;

@property BOOL shouldDrawDarkerButtonRegion;

@property BOOL shouldDrawButtonRegionWithSelectedColor;

@property BOOL shouldDrawFocusRing;

@property NSTrackingArea *trackingArea;

@property NSBezierPath *controlColorSwatchPath;

@property NSBezierPath *controlButtonPath;

@property NSBezierPath *controlOuterBorderPath;

// Popover and content view controller

@property DFColorGridViewController *colorGridViewController;

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
    if (_trackingArea == nil) {
        
        NSTrackingAreaOptions options = (NSTrackingActiveAlways |
                                         NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved);
        
        _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                     options:options
                                                       owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
    }
    
    [self addToolTipRect:[self _controlColorSwatchFrame] owner:self userData:kDFColorCellAreaUserInfo];
    [self addToolTipRect:[self _controlButtonFrame] owner:self userData:kDFButtonAreaUserInfo];
    
    // Cache paths
//    _controlColorSwatchPath = [self _colorAreaPath];
//    _controlButtonPath = [self _buttonAreaPath];
//    _controlOuterBorderPath = [self _controlOuterPath];
    
    
    // Default, non-nil, color
    if (self.color == nil) {
        self.color = [NSColor whiteColor];
    }
}

#pragma mark - Tooltips

- (NSString*) view:(NSView *)view stringForToolTip:(NSToolTipTag)tag point:(NSPoint)point userData:(void *)data {
    
    if (view == self) {
        
        if (data == kDFColorCellAreaUserInfo) {
            return @"Click to choose a colour";
        }
        
        if (data == kDFButtonAreaUserInfo) {
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

#pragma mark Color swatch

/* The basic frame of the control's color swatch.
 
 This frame used to generate a path with rounded corners for the control.
 */
- (NSRect) _controlColorSwatchFrame {
    return NSMakeRect(0.25, 0.25, INTRINSIC_WIDTH  - BUTTON_SIDE_LENGTH, INTRINSIC_HEIGHT);
}

- (NSBezierPath*) _generateControlColorSwatchPath {
    
    NSRect rect = [self _controlColorSwatchFrame];
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
    return NSMakeRect(NSMaxX(colorRect) + 0.25, 0.25, BUTTON_SIDE_LENGTH, INTRINSIC_HEIGHT);
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
    NSImage *image = [NSImage imageNamed:@"DFColorWheel2"];
    [image drawInRect:NSInsetRect([self _controlButtonFrame], 3.0, 3.0)];
    
}

#pragma mark Control border

- (NSBezierPath*) _generateControlOuterBorderPath {
    
    NSRect rect = NSUnionRect([self _controlColorSwatchFrame], [self _controlButtonFrame]);
    
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
    [_controlOuterBorderPath setLineWidth:0.5];
    [[NSColor colorWithCalibratedWhite:0.5 alpha:1.0] setStroke];
    [_controlOuterBorderPath stroke];
}

- (void) _drawSeparatorLine {
    NSPoint startPoint = NSMakePoint(NSMaxX([self _controlColorSwatchFrame]), NSMaxY([self _controlColorSwatchFrame]));
    NSPoint endPoint = NSMakePoint(NSMaxX([self _controlColorSwatchFrame]), NSMinY([self _controlColorSwatchFrame]));
    [[NSColor colorWithCalibratedWhite:0.5 alpha:1.0] setStroke];
    NSBezierPath *line = [NSBezierPath bezierPath];
    [line moveToPoint:startPoint];
    [line lineToPoint:endPoint];
    [line setLineWidth:0.5];
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

#pragma Mouse over indicator

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
    [tickPath setLineWidth:1.0];
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
    
    /* Set visual highlight when the mouse enters the view */
    NSPoint locationInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    if (NSPointInRect(locationInView, [self _controlColorSwatchFrame])) {
        _shouldDrawMouseOverIndicator = YES;
    } else {
        _shouldDrawMouseOverIndicator = NO;
    }
    [self setNeedsDisplay:YES];
}


- (void) mouseMoved:(NSEvent *)theEvent {
    
    /* The code here is horrible!
     
     All we are doing is checking:
        1. which part of the view are we in (color region or button region).
        2. If the state has changed since the last time the -mouseMoved: method
            was called then we need to call -setNeedsDisplay:
     
     TODO: This horrible code be avoided by having two tracking areas for the different regions.
     
     */
    BOOL needToRedraw = NO;
    NSPoint locationInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    // Check for mouse in color region
    if (NSPointInRect(locationInView, [self _controlColorSwatchFrame])) {
        
        if (_shouldDrawMouseOverIndicator != YES) {
            needToRedraw = YES;
        }
        _shouldDrawMouseOverIndicator = YES;
        
    } else {
        
        if (_shouldDrawMouseOverIndicator != NO) {
            needToRedraw = YES;
        }
        _shouldDrawMouseOverIndicator = NO;
    }
    
    // Check for mouse in button region
    if (NSPointInRect(locationInView, [self _controlButtonFrame]) ) {
        // Check if we did change
        if (YES != _shouldDrawDarkerButtonRegion) {
            needToRedraw = YES;
        }
        _shouldDrawDarkerButtonRegion = YES;
    } else {
        // Check if we did change
        if (NO != _shouldDrawDarkerButtonRegion) {
            needToRedraw = YES;
        }
        _shouldDrawDarkerButtonRegion = NO;
    }
    
    if (needToRedraw) {
        [self setNeedsDisplay:YES];
    }
    
}

- (void) mouseExited:(NSEvent *)theEvent {
    
    /* On mouse exit reset all highlights that indicated 
     the mouse is inside the view. */
    _shouldDrawMouseOverIndicator = NO;
    _shouldDrawDarkerButtonRegion = NO;
    [self setNeedsDisplay:YES];
}


- (void) mouseUp:(NSEvent *)theEvent {
    
    /* Mouse down either launches a popover or the color
     panel depending on the location in the view. */
    NSPoint locationInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    if (NSPointInRect(locationInView, [self _controlColorSwatchFrame])) {
        [self _handleMouseDownInColorRect];
    } else if (NSPointInRect(locationInView, [self _controlButtonFrame])){
        [self _handleMouseDownInButtonRect];
    }
}

#pragma mark - Mouse Clicking

- (void) _handleMouseDownInColorRect {
    

    if (_colorGridViewController == nil) {
        _colorGridViewController = [[DFColorGridViewController alloc] initWithNibName:@"DFColorGridViewController" bundle:nil];
        _colorGridViewController.colorWell = self;
        DFColorGridView *view = (DFColorGridView*)_colorGridViewController.view;
        view.controller = _colorGridViewController;
    }
    
    // The color grid view knows it own size, set this here
    _popover = [[NSPopover alloc] init];
    DFColorGridView *view = (DFColorGridView*)_colorGridViewController.view;
    [_popover setContentSize:[view intrinsicContentSize]];
    
    // Set up popover and show
    [_popover setContentViewController:_colorGridViewController];
    [_popover setAnimates:NO];
    [_popover setBehavior:NSPopoverBehaviorTransient];
    [_popover showRelativeToRect:[self _controlColorSwatchFrame] ofView:self preferredEdge:NSMinYEdge];
}

- (void) _handleMouseDownInButtonRect {
    
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
    _color = color;
    [self setNeedsDisplay:YES];
    
    /* Hook into the popover here and if show, close it.*/
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
    
    /* The views has a fixed size, but we need an extra pixel on all 
     sizes so that that the border stroke remains fully within the view.
     For this reason we check with NSScreen the smallest possible line 
     width and add that amount to the defined intrinsic size. */
    NSScreen *screen = [NSScreen mainScreen];
    CGFloat buffer = 2.0;
    if ([screen backingScaleFactor] == 2.0) {
        buffer = 1.0;
    }
    return NSMakeSize(INTRINSIC_WIDTH + buffer, INTRINSIC_HEIGHT + buffer);
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

- (void)draggingSession:(NSDraggingSession *)session movedToPoint:(NSPoint)screenPoint {
    //NSLog(@"%@", NSStringFromPoint(screenPoint));
}

- (void) mouseDragged:(NSEvent *)theEvent {
    
    
    id propertyListRep = [self.color pasteboardPropertyListForType:NSPasteboardTypeColor];
    NSPasteboardItem *pbItem = [[NSPasteboardItem alloc] initWithPasteboardPropertyList:propertyListRep ofType:NSPasteboardTypeColor];
    NSDraggingItem *item = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];
    
    NSColor *dragColor = [self.color copy];
    NSImage *contentImage = [NSImage imageWithSize:NSMakeSize(COLOR_DRAG_RECT_SIDE_LENGTH, COLOR_DRAG_RECT_SIDE_LENGTH) flipped:NO drawingHandler:^BOOL(NSRect dstRect) {
        
        CGFloat padding = 3.0;
        NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(dstRect, padding, padding) xRadius:2.0 yRadius:2.0];
        [path setLineWidth:0.5];
        [[[NSColor darkGrayColor] colorWithAlphaComponent:0.5] setStroke];
        [dragColor setFill];
        [path fill];
        [path stroke];
        return YES;
    }];
    
    [item setDraggingFrame:NSMakeRect(5.0, 0.0, COLOR_DRAG_RECT_SIDE_LENGTH, COLOR_DRAG_RECT_SIDE_LENGTH) contents:contentImage];
    id source = (id <NSDraggingSource>) self;
    [self beginDraggingSessionWithItems:@[item] event:theEvent source:source];
}


#pragma mark - Dragging Destination

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Don't allow drag and drop to self
    if ([sender draggingSource] == self) {
        return NSDragOperationNone;
    }
    
    NSColor *possiblyValidColor = [NSColor colorFromPasteboard:[sender draggingPasteboard]];
    if (possiblyValidColor) {
        //NSLog(@"%@", @"Should draw highlight around view.");
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
