( function( $, util ) {

/**
 * @param {String} pRegionId
 * @param {Object} [pOptions]
 **/
atimagepicker = function( itemId, options ) {
  var item = '#' + util.escapeCSS( itemId );

  var defaults = {
    hide_select : true,
    show_label  : false,

    initialized: function(imagePicker) {
      apex.event.trigger(item, "at-ip-initialized", {imagePicker});
    },
    changed: function(select, newValues, oldValues, event) {
      apex.event.trigger(item, "change", {select, newValues, oldValues, event});
    },
    clicked: function(select, option, event) {
      apex.event.trigger(item, "click", {select, option, event});
    },
    selected: function(select, option, event) {
      $(item).data('picker').sync_picker_with_select();
      apex.event.trigger(item, "select", {select, option, event});
    },
    limit_reached: function(select) {
      apex.event.trigger(item, "at-ip-limit-reached", {select});
    }
  }

  var options = $.extend(defaults, options);
  _refresh();
  /* Bind event handler to the apexrefresh event for the main region element. Dynamic actions can then
   * refresh the fullcalendar via the 'Refresh' action.
   */
  $(item).on( "apexrefresh", function() {
      //$(item).imagepicker(options);
      _refresh();
  }).trigger( "apexrefresh" );

  // Uses AJAX to get the newest chart data
  function _refresh() {
    if (typeof options.ajax_identifier !== 'undefined' || options.ajax_identifier) {
      console.log(options.ajax_identifier);
      console.log(options.pageItems);

      apex.server.plugin ( options.ajax_identifier,
                          { x01: options.values,
                            pageItems: options.pageItems},
          {cache: false,
          success: function( data ) {
            $(item).empty();
            apex.debug.log(data.content);
            $(item).append(data.content);

            console.log()
            $(item).imagepicker(options);
          }
      });
    } else {
      //_doHtml("");
    }
  }


}
})( apex.jQuery, apex.util );
