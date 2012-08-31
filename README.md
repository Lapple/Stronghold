# Stronghold

Small jQuery plugin that adds «fixed-view» behavior to any element.

### Basic Usage

```js
$( '#menu' ).stronghold({
    // Boundaries to fix the element within
    boundary: $( '#content' )
})
```

By default `#menu` will get one of the following CSS classes:

- `static` — when the top offset of the viewport is above the target element;
- `fixed` — when the top offset is below the target element;
- `absolute` — when the target element, while being fixed, reaches the bottom of `boundary`.

These classes can be easily overriden, *e.g.*:

```js
$( '#menu' ).stronghold({
    boundary      : $( '#content' ),
    staticClass   : 'stronghold-static',
    fixedClass    : 'stronghold-fixed',
    absoluteClass : 'stronghold-bottom'
});
```

Please consider supplying your own CSS declarations for the above classes, however, you can use the following for minimal setup:

```css
#menu.fixed {
    position: fixed;
    top: 10px;
}

#menu.absolute {
    position: absolute;
    bottom: 0;
}

#content {
    position: relative;
}
```
