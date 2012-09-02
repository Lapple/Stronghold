do ( $ = jQuery ) ->
  class Stronghold
    constructor: ( options ) ->
      $.extend true, @, @defaults, options

      # Initial sidebar state
      @sidebarState     = @staticClass
      @parentOffset     = @el.position().left + @parseAttribute( @el.css 'border-left-width' )
      @offsetLeft       = @calculateOffset()
      @contentOffsetTop = @within.offset().top + @staticOffset

      @window.scroll =>
          # Prevent default actions
          return if @sidebarState is @preventClass

          scrollTop = @window.scrollTop()

          # Add @fixedClass if the scroll position
          # is in the middle of the page
          if scrollTop >= @contentOffsetTop and @offsetLeft
            # Add @bottomClass if the page is scrolled
            # to the bottom of the boundary
            sHeight = @el.outerHeight() + @parseAttribute( @el.css 'top' )
            cHeight = @within.outerHeight()

            if scrollTop > cHeight + @contentOffsetTop - sHeight
              @set @bottomClass, { left: @parentOffset }
            else
              @set @fixedClass, { left: @offsetLeft }
          else
            @set @staticClass, { left: 'auto' }

        # Recalculate horizontal position of the sidebar
        # on window resize
        @window.resize =>
          # Prevent default actions
          return if @sidebarState is @preventClass

          @offsetLeft  = @calculateOffset()
          offset       = if @sidebarState is @fixedClass then @offsetLeft else 'auto'

          if offset
            @set @sidebarState, { left: offset, force: true }
          else
            @set @staticClass, { left: 'auto' }

    # Horizontal offset of the sidebar
    calculateOffset: ->
      left = Math.round( ( @window.width() - @within.outerWidth() ) / 2 ) + @parentOffset
      return if left < 0 then false else left

    set: ( newState, params = {} ) ->
      return if newState is @sidebarState and !params.force

      if params.left?
        @el.css 'left', params.left

      switch newState
        when @staticClass then @onStatic?.call( @el[0] )
        when @fixedClass  then @onFixed?.call( @el[0] )
        when @bottomClass then @onBottom?.call( @el[0] )

      @el
        .removeClass( @sidebarState )
        .addClass( newState )

      @sidebarState = newState

    parseAttribute: ( attr ) ->
      parseInt( attr, 10 ) or 0

    window: $( window )

    defaults:
      preventClass  : ''
      fixedClass    : 'fixed'
      bottomClass   : 'bottom'
      staticClass   : 'static'
      staticOffset  : 0
      within        : $( 'body' )

  # Exporting the plugin
  $.fn.stronghold = ( method, args ) ->
    @each ( elem ) ->
      # Assumming that method is being called
      if args?
        @_stronghold?[ method ]?.apply @_stronghold, args
      else
        @_stronghold = new Stronghold( $.extend true, method, { el: $( @ ) } )
