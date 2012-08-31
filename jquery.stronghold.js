// Generated by CoffeeScript 1.3.3

(function($) {
  var Stronghold;
  Stronghold = (function() {

    function Stronghold(options) {
      var _this = this;
      $.extend(true, this, this.defaults, options);
      this.sidebarState = this.staticClass;
      this.offsetRight = this.calculateOffset();
      this.contentOffsetTop = this.boundary.offset().top + this.staticOffset;
      this.window.scroll(function() {
        var cHeight, sHeight, scrollTop;
        if (_this.sidebarState === _this.preventClass) {
          return;
        }
        scrollTop = _this.window.scrollTop();
        if (scrollTop >= _this.contentOffsetTop && _this.offsetRight) {
          sHeight = _this.el.height();
          cHeight = _this.boundary.outerHeight();
          if (scrollTop > cHeight + _this.contentOffsetTop - sHeight) {
            return _this.set(_this.absoluteClass, {
              right: 'auto'
            });
          } else {
            return _this.set(_this.fixedClass, {
              right: _this.offsetRight
            });
          }
        } else {
          return _this.set(_this.staticClass, {
            right: 'auto'
          });
        }
      });
      this.window.resize(function() {
        var offset;
        if (_this.sidebarState === _this.preventClass) {
          return;
        }
        _this.offsetRight = _this.calculateOffset();
        offset = _this.sidebarState === _this.fixedClass ? _this.offsetRight : 'auto';
        if (offset) {
          return _this.set(_this.sidebarState, {
            right: offset,
            force: true
          });
        } else {
          return _this.set(_this.staticClass, {
            right: 'auto'
          });
        }
      });
    }

    Stronghold.prototype.calculateOffset = function() {
      var right;
      right = Math.floor((this.window.width() - this.boundary.width()) / 2);
      if (right < 0) {
        return false;
      } else {
        return right;
      }
    };

    Stronghold.prototype.set = function(newState, params) {
      var _ref, _ref1, _ref2;
      if (params == null) {
        params = {};
      }
      if (newState === this.sidebarState && !params.force) {
        return;
      }
      if (params.right != null) {
        this.el.css('right', params.right);
      }
      switch (newState) {
        case this.staticClass:
          if ((_ref = this.onStatic) != null) {
            _ref.call(this.el[0]);
          }
          break;
        case this.fixedClass:
          if ((_ref1 = this.onFixed) != null) {
            _ref1.call(this.el[0]);
          }
          break;
        case this.absoluteClass:
          if ((_ref2 = this.onAbsolute) != null) {
            _ref2.call(this.el[0]);
          }
      }
      this.el.removeClass(this.sidebarState).addClass(newState);
      return this.sidebarState = newState;
    };

    Stronghold.prototype.window = $(window);

    Stronghold.prototype.defaults = {
      preventClass: '',
      fixedClass: 'fixed',
      absoluteClass: 'absolute',
      staticClass: 'static',
      staticOffset: 0
    };

    return Stronghold;

  })();
  return $.fn.stronghold = function(method, args) {
    return this.each(function(elem) {
      var _ref, _ref1;
      if (args != null) {
        return (_ref = this._stronghold) != null ? (_ref1 = _ref[method]) != null ? _ref1.apply(this._stronghold, args) : void 0 : void 0;
      } else {
        return this._stronghold = new Stronghold($.extend(true, method, {
          el: $(this)
        }));
      }
    });
  };
})(jQuery);