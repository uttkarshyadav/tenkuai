$(document).ready(function() {

	$(".feedbackList").jCarouselLite({
		btnNext: ".down",
		btnPrev: ".up",
		vertical: true
	});

	$(".activityEntry").jCarouselLite({
		btnNext: ".down",
		btnPrev: ".up",
		vertical: true,
		circular: false,
		visible: 3,
		start: 0
	});

	$("#loginButton").click(function() {
		$('#loginBox').slideToggle();
	});

	var msie6 = $.browser == 'msie' && $.browser.version < 7;
	if (!msie6) {
		/*top is equal to the distance between ribbon-wrapper and the top of the screen, top value never change*/
		var top = $('.ribbon-wrapper').offset().top - parseFloat($('.ribbon-wrapper').css('margin-top').replace(/auto/, 0));
		var top_last =  $('#lastFeatured').offset().top - parseFloat($('#lastFeatured').css('margin-top').replace(/auto/, 0));
		var top1 =  $('.ribbon-wrapper1').offset().top - parseFloat($('.ribbon-wrapper1').css('margin-top').replace(/auto/, 0));
		var top_last1 =  $('#lastFeatured1').offset().top - parseFloat($('#lastFeatured1').css('margin-top').replace(/auto/, 0));

		$(window).scroll(function (event) {
			$('.ribbon-wrapper, .ribbon-wrapper1').css({
				'z-index': '200'
			});
$('.ribbon-wrapper').text(y)
			var y = $(this).scrollTop();
			if (y >= top-30 && y < top_last-30) {
				$('.ribbon-wrapper').addClass('fixed');
				$('.ribbon-front').addClass('padding');
			} else{
				$('.ribbon-wrapper').removeClass('fixed');
				$('.ribbon-front').removeClass('padding');
			}
			if (y >= top1-30 && y < top_last1-30) {
				$('.ribbon-wrapper1').addClass('fixed');
				$('.ribbon-front1').addClass('padding');
			} else{
				$('.ribbon-wrapper1').removeClass('fixed');
				$('.ribbon-front1').removeClass('padding');
			}
		});
	}

});
