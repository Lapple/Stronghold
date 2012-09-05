# Stronghold v0.0.2

Small jQuery plugin that adds «fixed-view» behavior to any element.

## Basic Usage

```js
$( '#menu' ).stronghold({
    // Boundaries to fix the element within.
    // Default is $( 'body' ).
    within: $( '#content' )
});
```

By default `#menu` will get one of the following CSS classes:

- `static` when the top offset of the viewport is above the target element;
- `fixed` when the top offset is below the target element;
- `bottom` when the target element, while being fixed, reaches the bottom of `within`.

These classes can be easily overriden, *e.g.*:

```js
$( '#menu' ).stronghold({
    within      : $( '#content' ),
    staticClass : 'stronghold-static',
    fixedClass  : 'stronghold-fixed',
    bottomClass : 'stronghold-bottom'
});
```

Please consider supplying your own CSS declarations for the above classes, however, you can use the following for minimal setup:

```css
.fixed {
    position: fixed;
}

.bottom {
    position: absolute;
    bottom: 0;
}

/*
 * In order to appropriately display `bottom` position
 * boundary element should be positioned relatively.
 */
#content {
    position: relative;
}
```

## Modifying trigger boundaries

Sometimes you might need to adjust the vertical offset at which the target element changes from `static` to `fixed`. In order to achieve this, simply pass `staticOffset` property to the options list:

```js
$( '#menu' ).stronghold({
    within       : $( '#content' ),
    staticOffset : 10
});
```

Now the `#menu` will switch to `fixed` state once the top viewport margin moves **10 pixels below** the `#content`'s top boundary. Note that you may pass negative number as well.

## State switch callbacks

Pass in optional callbacks should you want to track the changing state of the target element:

```js
$( '#menu' ).stronghold({
    within: $( '#content' ),
    onFixed: function() {
        console.log( 'The menu is now fixed' );
    },
    onStatic: function() {
        console.log( 'The menu is back to static' );
    },
    onBottom: function() {
        console.log( 'The menu reached the bottom' );
    }
});
```

## License

(The MIT License)

Copyright (c) 2012 Aziz Yuldoshev <yuldoshev.aziz@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
