do ( $ = jQuery ) ->
  class Stronghold
    constructor: ( options ) ->
      $.extend true, @, @defaults, options

      # Initial sidebar state
      @sidebarState     = @staticClass
      @offsetRight      = @calculateOffset()
      @contentOffsetTop = @within.offset().top + @staticOffset

      @window.scroll =>
          # Prevent default actions
          return if @sidebarState is @preventClass

          scrollTop = @window.scrollTop()

          # Add @fixedClass if the scroll position
          # is in the middle of the page
          if scrollTop >= @contentOffsetTop and @offsetRight
            # Add @bottomClass if the page is scrolled
            # to the bottom of the boundary
            sHeight = @el.height()
            cHeight = @within.outerHeight()

            if scrollTop > cHeight + @contentOffsetTop - sHeight
              @set @bottomClass, { right: 'auto' }
            else
              @set @fixedClass, { right: @offsetRight }
          else
            @set @staticClass, { right: 'auto' }

        # Recalculate horizontal position of the sidebar
        # on window resize
        @window.resize =>
          # Prevent default actions
          return if @sidebarState is @preventClass

          @offsetRight = @calculateOffset()
          offset       = if @sidebarState is @fixedClass then @offsetRight else 'auto'

          if offset
            @set @sidebarState, { right: offset, force: true }
          else
            @set @staticClass, { right: 'auto' }

    # Horizontal offset of the sidebar
    calculateOffset: ->
      right = Math.floor( ( @window.width() - @within.width() ) / 2 )
      return if right < 0 then false else right

    set: ( newState, params = {} ) ->
      return if newState is @sidebarState and !params.force

      if params.right?
        @el.css 'right', params.right

      switch newState
        when @staticClass   then @onStatic?.call( @el[0] )
        when @fixedClass    then @onFixed?.call( @el[0] )
        when @bottomClass   then @onBottom?.call( @el[0] )

      @el
        .removeClass( @sidebarState )
        .addClass( newState )

      @sidebarState = newState

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
