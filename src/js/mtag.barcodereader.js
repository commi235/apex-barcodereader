/* global apex, codeReader */

(function( $, event ){

  $.widget( "mtag.codereader", {
    options: {
      reInitOnEvent: true
    },
    _create: function() {
      this.codeReader = new ZXing.BrowserMultiFormatReader();
      this.regionId = "#" + this.element[0].id;
      this.videoElementId = this.element[0].id + "_video";
      this._init();
    },
    _init() {
      this.codeReader.decodeFromInputVideoDevice( 
        undefined,
        this.videoElementId
        ).then(result => {
          event.trigger(this.regionId, "codereader:result", result);
        }).catch(err => {
          event.trigger(this.regionId, "codereader:error", err);
        }).finally( () => {
          if (this.options.reInitOnEvent) {
            this.reInit();
          }
        });
    },
    reInit() {
      this.codeReader.reset();
      this._init();
    }
  });

})( apex.jQuery, apex.event );
