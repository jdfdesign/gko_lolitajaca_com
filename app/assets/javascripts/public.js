//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

//= require flexslider/jquery.flexslider.js
//= require jquery.throttledresize.js
//= require supersized.3.2.7.min.js
//= require modernize.js
//= require gko/catalog/zoom.js
//= require util
//= require filters
//= require product
//= require site

var $window,$body,$header,$mainContainer;
var headerHeight, viewPortHeight, viewPortWidth, availableHeight;



$(document).ready(function() {
	$body = $("body"),
	$window = $(window);
	$header = $('header.navbar');
	$sideBar = $('#sidebar');
	$mainContainer = $('#main-container');
	Util.updateDimensions();
	Site.init();  
	Carousel.init();  
	
	$('.btn-popover').popover()
}); 

var Carousel = {

	init : function() { 
		
		if($('#carousel li').length > 1) {
			// The slider being synced must be initialized first
			  $('#carousel').flexslider({
			    animation: "slide",
			    controlNav: false,
			    animationLoop: false,
			    slideshow: false,
			    itemWidth: 156,
			    itemMargin: 5,
			    asNavFor: '#slider'
			  });

			  $('#slider').flexslider({
			    animation: "slide",
			    controlNav: false,
			    animationLoop: false,
			    slideshow: false,
			    sync: "#carousel"
			  });
		} else {
			$('#carousel').hide();
		} 

	}
}

