//
//  DFColorGridViewController.m
//  DFColorSelector
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import "DFColorGridViewController.h"
#import "DFColorWell.h"
#import "DFColorGridView.h"

@interface DFColorGridViewController ()

@end

@implementation DFColorGridViewController


- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _colorModelArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    DFColorGridView *view = (DFColorGridView*)self.view;
    view.controller = self;
}

- (NSUInteger) numberOfRows {
    return [_colorSelectorView.delegate numberOfRowsInColorWell:_colorSelectorView];
}

- (NSUInteger) numberOfColumns {
    return [_colorSelectorView.delegate numberOfColumnsInColorWell:_colorSelectorView];
}

- (NSColor*) colorAtColumn:(NSUInteger)columnIndex row:(NSUInteger)rowIndex {
    return [_colorSelectorView.delegate colorWell:_colorSelectorView colorAtColumn:columnIndex row:rowIndex];
}



@end
