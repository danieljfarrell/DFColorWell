DFColorWell
-----------

![DFColorWell example.](https://github.com/danieljfarrell/DFColorWell/blob/master/screenshot.png)

An implementation of the colour well seen in Pages 5, Numbers 3 and Keynote 6.

I implemented this in an afternoon, this project is not a good example of beautiful code!

Usage
-----

1. Drag out an NSView into a XIB
2. Change the class to `DFColorWell`
3. Add placeholder intrinsic size. **NB** DFColorWell sets the `intrinsicContentSize` because the control will always have a fixed size, so size constraints should not be used.
4. Implement the **required** delegate methods which fills the pop over with difference colours:

    - (NSUInteger) numberOfRowsInColorWell:(DFColorWell*)colorSelectorView;
    - (NSUInteger) numberOfColumnsInColorWell:(DFColorWell*)colorSelectorView;
    - (NSColor*) colorWell:(DFColorWell*)colorSelectorView colorAtColumn:(NSUInteger)column row:(NSUInteger)row;

