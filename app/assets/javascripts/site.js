var Site = {
	animating : false,
	
	init: function() {
	
	//	Carousel.addTheme();
	//	Carousel.init();
	
	
		Site.attachEvents();
		Filter.init();
		Product.init();
		Site.onResize();
		
	   // Zoom.init();
	},
	
	onScroll:function(e) {
		var st = Math.min(viewPortWidth*0.25,$window.scrollTop()*0.25),
		$spirit = $("#spirit");
		
		if($spirit.length) {
			var so = $spirit.offset().top;

			$spirit.css({backgroundPosition: (-st+so*0.2)*1.5+"px 0"});
		}
		
	},
	
	onResize: function(e) {
		Util.updateDimensions();
		//$('.section-cover').css('height', viewPortHeight - 500);
	},
	
	attachEvents: function() {
		if(Modernizr.touch == false){			
			$(window).on("throttledresize",
				function(e) {
					Site.onResize(e);
					Site.onScroll(e);
		        }).on("scroll",
				function(e) {
					// set a timeout to avoid that the function gets called on every scroll trigger
					if( Site.animating ) return false;
					Site.animating = true;
					setTimeout( function() {
						Site.onScroll(e);
						Site.animating = false;
					}, 10 );
				});
		}
		else {
			$(window).on("throttledresize",
				function(e) {
					Site.onResize(e);
		        });
		}
		
		$("#play").on('click', function(){
			$("#player-controls").removeClass('hide');
			$("section, footer, #copyright-container").addClass('hide');
		//	api.nextSlide();
			api.playToggle();
		});
		$("#pause").on('click', function(){
			console.log("ddd")
			api.playToggle();
			$("#player-controls").addClass('hide');
			$("section, footer, #copyright-container").removeClass('hide');
			
		})

			
	}
}
