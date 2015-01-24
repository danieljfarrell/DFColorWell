DFColorWell
-----------

![DFColorWell example.](https://github.com/danieljfarrell/DFColorWell/blob/master/screenshot.png)

An implementation of the colour well seen in Pages 5, Numbers 3 and Keynote 6.

All custom drawing is done with NSBezierPath (cached where possible), the usual NSEvent methods (-mouseDown:, -mouseUp:, -mouseDrag) are implemented to keep track of the control's state and turn on or off different drawing options. Colours can be dragged and dropped into or out of the colour well using the systems NSColorPanel. Delegate methods should be implemented to fill the popover grid with colour cells.

Any improvements welcomed. 

Things that need adding & improvements
--------------------------------------

* I wrote this on rMBP running OSX 10.10 so there may be some retina specific code which does not look good on other screens.

* Want to add the ability to display custom views in the popover (from a user specified content view controller), this will enable users to design their own layout of colour cells etc.

Usage
-----

1. Drag out an NSView into a XIB
2. Change the class to `DFColorWell`

   ![Changing the custom class screenshot](http://i.imgur.com/YdQ6qbb.png)
   
3. Add placeholder intrinsic size to 67 by 23. 
   
   **NB** DFColorWell sets the `intrinsicContentSize` because the control will always have a fixed size, so size constraints should not be used.

   ![Setting the placeholder intrinsic content size](http://i.imgur.com/5X0KuA5.png)

4. Implement all the **required** delegate methods which fills the pop over with different colours:

```
    - (NSUInteger) numberOfRowsInColorWell:(DFColorWell*)colorWell;
    - (NSUInteger) numberOfColumnsInColorWell:(DFColorWell*)colorWell;
    - (NSColor*) colorWell:(DFColorWell*)colorWell colorAtColumn:(NSUInteger)column row:(NSUInteger)row;
```

Contact
-------
* Daniel Farrell
* [@danieljfarrell](http://twitter.com/danieljfarrell)
* http://daniel.farrell.name

Licensing
---------
DFColorWell is licensed under the [BSD license](http://opensource.org/licenses/BSD-3-Clause).
