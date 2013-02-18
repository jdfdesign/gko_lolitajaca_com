var Filter = {
	scrollpaneApis: [],
	init: function() {
	//	this.scrollpaneApis << $('aside .scrollable').jScrollPane({}).data('jsp');
		//this.scrollpaneApis << $('aside .nav-tabs').jScrollPane({}).data('jsp');


		$('aside').on('click', 'a', function (e) {
			var $this = $(this),
				$ul = $this.closest('.nav')
				$parent = $this.parent(),
				parentId = $parent.attr('id');
			
			console.log("parentId " + parentId);	
			Filter.byTag(parentId);
			return false;
		})
	},
	byTag: function(tag) {
		var $grid = $(".grid:first"),
			filterableItems = $grid.find('li[data-categories*=]'),
			categories,
			el,
			result = [];
			
		$grid.find('li').hide().css({clear:'none'});
		
		filterableItems.each(function() {
			el = $(this);
			categories = el.data('categories');
			console.log("categories " + categories);
			$.grep(categories, function (item) {
				if(~item.indexOf(tag)) {
					result.push(el[0]);
				}
			})
        })
		
		console.log("result " + result.length);

		$.each(result, function(index, item) {
			if (index % 4 == 0) {
				$(item).css({clear:'left'});
			}
			$(item).show();
		});

		$("html, body").animate({ scrollTop: $grid.position().top }, 600);
		$grid.show();
	}
}
