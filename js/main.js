jQuery(document).ready(function ($) {
	// add timeline
	var $timeline = $('#cd-timeline'), contentHtml = '', contentListHtml = '';

	myAppData.timeline.forEach(function (item) {
		contentHtml = '';
		item.contents.forEach(function (cont) {
			contentListHtml = '';
			if (cont.list.length > 1) { // make list
				contentListHtml = '<ul class="list-group">' + ((cont.list.map(function (li) {
					return '<li class="list-group-item">' + li + '</li>'
				})).join('')) + '</ul>';
			} else {
				contentListHtml = '<p>' + cont.list[0] + '</p>';
			}
			if (cont.header) { // make panel
				contentListHtml = ' <div class="panel panel-info">\
				<div class="panel-heading"><h3 class="panel-title">' + cont.header + '</h3></div>\
				<div class="panel-body">' + contentListHtml + '</div>\
				</div>';
			}
			contentHtml += contentListHtml; // combine contents
		});

		$timeline.append('  <!-- cd-timeline-block -->\
                            <div class="cd-timeline-block">\
                                <div class="cd-timeline-img '+ item.icon.bgClass + '"><img src="' + item.icon.src + '" alt="Picture"></div>\
                                <!-- cd-timeline-img -->\
                                <div class="cd-timeline-content">\
                                    <h2>'+ item.title + '</h2>' + contentHtml + '\
                                    <span class="cd-date">'+ item.startYear + '</span>\
                                </div>\
                                <!-- cd-timeline-content -->\
                            </div>');
	});

	var $timeline_block = $('.cd-timeline-block');

	//hide timeline blocks which are outside the viewport
	$timeline_block.each(function () {
		if ($(this).offset().top > $(window).scrollTop() + $(window).height() * 0.75) {
			$(this).find('.cd-timeline-img, .cd-timeline-content').addClass('is-hidden');
		}
	});

	//on scolling, show/animate timeline blocks when enter the viewport
	$(window).on('scroll', function () {
		$timeline_block.each(function () {
			if ($(this).offset().top <= $(window).scrollTop() + $(window).height() * 0.75 && $(this).find('.cd-timeline-img').hasClass('is-hidden')) {
				$(this).find('.cd-timeline-img, .cd-timeline-content').removeClass('is-hidden').addClass('bounce-in');
			}
		});
	});
});