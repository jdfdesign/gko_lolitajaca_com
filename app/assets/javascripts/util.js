var Util = {

	updateDimensions: function() {
		headerHeight = $header.outerHeight();
		viewPortHeight = $window.height();
		viewPortWidth = $window.width();
		availableHeight = viewPortHeight - headerHeight;
	}
}
