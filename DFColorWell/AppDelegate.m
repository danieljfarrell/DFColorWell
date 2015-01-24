//
//  AppDelegate.m
//  DFColorWell
//
//  Created by Daniel Farrell on 18/01/2015.
//  Copyright (c) 2015 Daniel Farrell. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property NSMutableDictionary *colors;
@end

@implementation AppDelegate

#pragma mark - Make colours

- (void) _generateColors {
    
    _colors = [NSMutableDictionary new];
    _colors[@"(0,0)"] = [NSColor colorWithCalibratedRed:0.807 green:0.845 blue:0.886 alpha:1.000];
    _colors[@"(0,1)"] = [NSColor colorWithCalibratedRed:0.587 green:0.673 blue:0.767 alpha:1.000];
    _colors[@"(0,2)"] = [NSColor colorWithCalibratedRed:0.236 green:0.365 blue:0.518 alpha:1.000];
    _colors[@"(0,3)"] = [NSColor colorWithCalibratedRed:0.176 green:0.262 blue:0.364 alpha:1.000];
    _colors[@"(0,4)"] = [NSColor colorWithCalibratedWhite:1.000 alpha:1.000];
    
    _colors[@"(1,0)"] = [NSColor colorWithCalibratedRed:0.864 green:0.889 blue:0.849 alpha:1.000];
    _colors[@"(1,1)"] = [NSColor colorWithCalibratedRed:0.527 green:0.589 blue:0.480 alpha:1.000];
    _colors[@"(1,2)"] = [NSColor colorWithCalibratedRed:0.237 green:0.341 blue:0.182 alpha:1.000];
    _colors[@"(1,3)"] = [NSColor colorWithCalibratedRed:0.150 green:0.229 blue:0.108 alpha:1.000];
    _colors[@"(1,4)"] = [NSColor colorWithCalibratedWhite:0.604 alpha:1.000];
    
    _colors[@"(2,0)"] = [NSColor colorWithCalibratedRed:0.987 green:0.902 blue:0.731 alpha:1.000];
    _colors[@"(2,1)"] = [NSColor colorWithCalibratedRed:0.854 green:0.705 blue:0.422 alpha:1.000];
    _colors[@"(2,2)"] = [NSColor colorWithCalibratedRed:0.570 green:0.397 blue:0.182 alpha:1.000];
    _colors[@"(2,3)"] = [NSColor colorWithCalibratedRed:0.287 green:0.201 blue:0.126 alpha:1.000];
    _colors[@"(2,4)"] = [NSColor colorWithCalibratedWhite:0.404 alpha:1.000];
    
    _colors[@"(3,0)"] = [NSColor colorWithCalibratedRed:0.915 green:0.629 blue:0.521 alpha:1.000];
    _colors[@"(3,1)"] = [NSColor colorWithCalibratedRed:0.889 green:0.465 blue:0.306 alpha:1.000];
    _colors[@"(3,2)"] = [NSColor colorWithCalibratedRed:0.820 green:0.263 blue:0.105 alpha:1.000];
    _colors[@"(3,3)"] = [NSColor colorWithCalibratedRed:0.633 green:0.218 blue:0.014 alpha:1.000];
    _colors[@"(3,4)"] = [NSColor colorWithCalibratedWhite:0.204 alpha:1.000];
    
    _colors[@"(4,0)"] = [NSColor colorWithCalibratedRed:0.875 green:0.492 blue:0.473 alpha:1.000];
    _colors[@"(4,1)"] = [NSColor colorWithCalibratedRed:0.662 green:0.166 blue:0.194 alpha:1.000];
    _colors[@"(4,2)"] = [NSColor colorWithCalibratedRed:0.493 green:0.074 blue:0.103 alpha:1.000];
    _colors[@"(4,3)"] = [NSColor colorWithCalibratedRed:0.349 green:0.000 blue:0.013 alpha:1.000];
    _colors[@"(4,4)"] = [NSColor colorWithCalibratedWhite:0.0 alpha:1.0];
    
    _colors[@"(5,0)"] = [NSColor colorWithCalibratedRed:0.629 green:0.602 blue:0.701 alpha:1.000];
    _colors[@"(5,1)"] = [NSColor colorWithCalibratedRed:0.426 green:0.388 blue:0.527 alpha:1.000];
    _colors[@"(5,2)"] = [NSColor colorWithCalibratedRed:0.303 green:0.269 blue:0.393 alpha:1.000];
    _colors[@"(5,3)"] = [NSColor colorWithCalibratedRed:0.199 green:0.178 blue:0.253 alpha:1.000];
    _colors[@"(5,4)"] = [NSNull null];
    
}

#pragma mark - App Delegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self _generateColors];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Delegate methods for the color well

- (NSUInteger) numberOfColumnsInColorWell:(DFColorWell *)colorWell {
    return 6;
}

- (NSUInteger) numberOfRowsInColorWell:(DFColorWell *)colorWell {
    return 5;
}

- (NSColor*) colorWell:(DFColorWell *)colorWell colorAtColumn:(NSUInteger)column row:(NSUInteger)row {
    NSString *key = [NSString stringWithFormat:@"(%lu,%lu)", (unsigned long)column,(unsigned long)row];
    NSColor *color = _colors[key];
    return color;
}

@end
