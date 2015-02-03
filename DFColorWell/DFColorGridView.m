//
//  DFColorGridView.m
//  DFColorWell
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import "DFColorGridView.h"
#import "DFColorWell.h"

#import <QuartzCore/QuartzCore.h>

@interface DFColorGridView ()
@property BOOL shouldDrawSelectorRing;
@property NSUInteger mouseDownInColumnIndex;
@property NSUInteger mouseDownInRowIndex;
@property BOOL mouseIsDown;
@property BOOL mouseDraggedOutsideMouseDownCell;
@property NSMutableDictionary *colors;
@end

@implementation DFColorGridView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _mouseDownInColumnIndex = NSNotFound;
        _mouseDownInRowIndex = NSNotFound;
        _mouseIsDown = NO;
        _mouseDraggedOutsideMouseDownCell = NO;
        _borderPadding = 6.0;
        _cellBorderLinewidth = 0.5;
        _intercellSpacing = 2.0;
        _cellWidth = 44.0;
        _cellHeight = 23.0;
        _cellBorderColor = [[NSColor darkGrayColor] colorWithAlphaComponent:0.5];
        
    }
    return self;
}

- (BOOL) isFlipped {
    return NO;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    
    NSUInteger columns = [_colorWell.delegate numberOfColumnsInColorWell:_colorWell];
    NSUInteger rows = [_colorWell.delegate numberOfRowsInColorWell:_colorWell];
    
    for (NSUInteger i=0; i < columns; i++) {
        for (NSUInteger j=0; j < rows; j++) {

            NSColor *fillColor = [_colorWell.delegate colorWell:_colorWell colorAtColumn:i row:j];
            if (fillColor) {
                if (fillColor != (id)[NSNull null]) {
                    NSRect frame = [self _frameForColorAreaAtColumn:i row:j];
                    [DFColorWell drawColorSwatchWithFrame:frame color:fillColor shouldDrawBorder:YES];
                }
            }
        }
    }
    
    if (_shouldDrawSelectorRing) {
        if (_mouseIsDown) {
            if (_mouseDownInColumnIndex != NSNotFound && _mouseDownInRowIndex != NSNotFound) {
                [self _drawSelectorRectAtColumn:_mouseDownInColumnIndex row:_mouseDownInRowIndex];
            }
        }
    }
}

- (NSRect) _frameOfTopLeftCell {
    
    CGFloat x = _borderPadding;
    CGFloat y = NSMaxY(self.bounds) - _borderPadding - _cellHeight;
    return NSMakeRect(x, y, _cellWidth, _cellHeight);
}

- (NSRect) _frameForColorAreaAtColumn:(NSUInteger)columnIndex row:(NSUInteger)rowIndex {
    
    NSRect topLeftCellRect = [self _frameOfTopLeftCell];
    NSRect cellRect = NSMakeRect(topLeftCellRect.origin.x, topLeftCellRect.origin.y, topLeftCellRect.size.width, topLeftCellRect.size.height);
    if (columnIndex > 0) {
        cellRect = NSOffsetRect(cellRect, (columnIndex - 0) * _intercellSpacing + columnIndex * _cellWidth, 0.0);
    }
    
    if (rowIndex > 0) {
        cellRect = NSOffsetRect(cellRect, 0.0, -((rowIndex - 0) * _intercellSpacing + rowIndex * _cellHeight));
    }
    
    return cellRect;
    
}

- (void) _drawSelectorRectAtColumn:(NSUInteger)i row:(NSUInteger)j {
    
    NSColor *cellColor = [_colorWell.delegate colorWell:_colorWell colorAtColumn:i row:j];
    if (cellColor) {
        if (cellColor != (id)[NSNull null]) {
            
            NSRect cellFrame = [self _frameForColorAreaAtColumn:i row:j];
            NSRect outerRect = NSInsetRect(cellFrame, -3.0, -3.0);
            NSBezierPath *outerPath = [NSBezierPath bezierPathWithRect:outerRect];
            [outerPath setLineWidth:0.5];
            [[NSColor whiteColor] setFill];
            [[NSColor darkGrayColor] setStroke];
            [outerPath fill];
            [outerPath stroke];
            
            NSRect innerRect = NSInsetRect(cellFrame, 1.0, 1.0);
            NSBezierPath *innerPath = [NSBezierPath bezierPathWithRect:innerRect];
            [innerPath setLineWidth:0.5];
            [cellColor setFill];
            [[NSColor lightGrayColor] setStroke];
            [innerPath fill];
            [innerPath stroke];
        }
    }
}


- (NSSize) intrinsicContentSize {
    
    NSUInteger maxColumnIndex = 0;
    if ([_colorWell.delegate numberOfColumnsInColorWell:_colorWell] > 0 ) {
        maxColumnIndex = [_colorWell.delegate numberOfColumnsInColorWell:_colorWell] - 1;
    } else {
        maxColumnIndex  = 0;
    }
    
    NSUInteger maxRowIndex = 0;
    if ([_colorWell.delegate numberOfRowsInColorWell:_colorWell] > 0 ) {
        maxRowIndex = [_colorWell.delegate numberOfRowsInColorWell:_colorWell] - 1;
    } else {
        maxRowIndex  = 0;
    }
    
    
    NSRect topLeftFrame = [self _frameOfTopLeftCell];
    NSRect bottomRightFrame = [self _frameForColorAreaAtColumn:maxColumnIndex row:maxRowIndex];
    topLeftFrame = NSOffsetRect(topLeftFrame, -_borderPadding, _borderPadding);
    bottomRightFrame = NSOffsetRect(bottomRightFrame, _borderPadding, -_borderPadding);
    return NSUnionRect(topLeftFrame, bottomRightFrame).size;
}

- (void) mouseDown:(NSEvent *)theEvent {
    
    NSUInteger columns = [_colorWell.delegate numberOfColumnsInColorWell:_colorWell];
    NSUInteger rows = [_colorWell.delegate numberOfRowsInColorWell:_colorWell];
    NSPoint locationInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    // Get the col and row index of the mouse down
    for (NSUInteger i=0; i < columns; i++) {
        for (NSUInteger j=0; j < rows; j++) {
            NSRect frame = [self _frameForColorAreaAtColumn:i row:j];
            if (NSPointInRect(locationInView, frame)) {
                _mouseDownInColumnIndex = i;
                _mouseDownInRowIndex = j;
                _mouseIsDown = YES;
                _shouldDrawSelectorRing = YES;
                [self setNeedsDisplay:YES];
                return;
            }
        }
    }
}


- (void) mouseUp:(NSEvent *)theEvent {
    
    _mouseIsDown = NO;
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    
    
    NSUInteger mouseUpInColumnIndex = NSNotFound;
    NSUInteger mouseUpInRowIndex = NSNotFound;
    
    NSUInteger columns = [_colorWell.delegate numberOfColumnsInColorWell:_colorWell];
    NSUInteger rows = [_colorWell.delegate numberOfRowsInColorWell:_colorWell];
    
    NSPoint locationInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSColor *selectedColor = nil;
    // Get the col and row index of the mouse down
    for (NSUInteger i=0; i < columns; i++) {
        for (NSUInteger j=0; j < rows; j++) {
            NSRect frame = [self _frameForColorAreaAtColumn:i row:j];
            if (NSPointInRect(locationInView, frame)) {
                //NSLog(@"**FOUND** column:%lu row:%lu", (unsigned long)i, (unsigned long)j);
                
                mouseUpInColumnIndex = i;
                mouseUpInRowIndex = j;
                
            }
        }
    }
    
    
    if ((_mouseDownInColumnIndex == mouseUpInColumnIndex) && (_mouseDownInRowIndex == mouseUpInRowIndex)) {
        selectedColor = [_colorWell.delegate colorWell:_colorWell colorAtColumn:_mouseDownInColumnIndex row:_mouseDownInRowIndex];
        if (selectedColor) {
            if (selectedColor != (id)[NSNull null]) {
                _colorWell.color = selectedColor;
            }
        }
    }
    
}

- (void) mouseDragged:(NSEvent *)theEvent {
    
    if (_mouseDownInColumnIndex == NSNotFound || _mouseDownInRowIndex == NSNotFound) {
        return;
    }
    
    // Monitor for drag in or out of the selected cell
    NSPoint locationInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSRect selectedCellFrame = [self _frameForColorAreaAtColumn:_mouseDownInColumnIndex row:_mouseDownInRowIndex];
    
    if (_mouseDraggedOutsideMouseDownCell == YES) {
        if (NSPointInRect(locationInView, selectedCellFrame)) {
            _mouseDraggedOutsideMouseDownCell = NO;
            _shouldDrawSelectorRing = YES;
            [self setNeedsDisplay:YES];
            return;
        }
    } else {
        if (NSPointInRect(locationInView, selectedCellFrame)) {
            
            BOOL shouldRedraw = NO;
            if (_mouseDraggedOutsideMouseDownCell != NO && _shouldDrawSelectorRing != YES) {
                shouldRedraw = YES;
            }
            _mouseDraggedOutsideMouseDownCell = NO;
            _shouldDrawSelectorRing = YES;
            if (shouldRedraw) {
                [self setNeedsDisplay:YES];
            }
            
            return;
        } else {
            _mouseDraggedOutsideMouseDownCell = YES;
            _shouldDrawSelectorRing = NO;
            [self setNeedsDisplay:YES];
            return;
        }
    }
}

@end
