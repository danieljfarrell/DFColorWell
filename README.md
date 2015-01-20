DFColorWell
-----------

![DFColorWell example.](https://github.com/danieljfarrell/DFColorWell/blob/master/screenshot.png)

An implementation of the colour well seen in Pages 5, Numbers 3 and Keynote 6.

**I implemented this in an afternoon, this project is not a good example of beautiful code!** However, it is stable and reasonably efficient when redrawing. All custom drawing is done with NSBezierPath, the usual NSEvent methods (-mouseDown:, -mouseUp:, -mouseDrag) are implemented to keep track of the control's state and turn on or off different drawing options. Colours can be drag and dropped into or out of the colour well. Delegate methods should be implemented to fill the popover grid with colour cells.

Any improvements welcomed. I wrote this on rMBP running OSX 10.10 so there may be some retina specific code which does not look good on other screens.

Usage
-----

1. Drag out an NSView into a XIB
2. Change the class to `DFColorWell`
3. Add placeholder intrinsic size. **NB** DFColorWell sets the `intrinsicContentSize` because the control will always have a fixed size, so size constraints should not be used.
4. Implement all the **required** delegate methods which fills the pop over with different colours:

```
    - (NSUInteger) numberOfRowsInColorWell:(DFColorWell*)colorSelectorView;
    - (NSUInteger) numberOfColumnsInColorWell:(DFColorWell*)colorSelectorView;
    - (NSColor*) colorWell:(DFColorWell*)colorSelectorView colorAtColumn:(NSUInteger)column row:(NSUInteger)row;
```
