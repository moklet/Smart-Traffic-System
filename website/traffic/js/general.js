$(document).ready(function() {
	if ($('#login #content').length > 0) {
		var h = $(window).height() - 44;
		$('#login #content').css('min-height',h);
	}
	if ($('#home #content').length > 0) {
		var h = $(window).height();
		$('#home #content').css('min-height',h - 51);
		$('.menu-container').css('min-height',h-51);
	}
	if ($('#table').length > 0) {
		$('#table').DataTable();
	}
	$("#menu").click(function() {
		if ($(".menu-container").hasClass("show")) {
			setTimeout(function(){
				$(".menu-container").removeClass("show");
			},1000);
			$(".menu-container").animate({ right: "-126px" });
			$("#menu").animate({ right: "40px" });
			$(this).addClass('glyphicon-align-justify').removeClass('glyphicon-remove');
		} else {
			$(".menu-container").addClass("show");
			$(".menu-container").animate({ right: "0" });
			$("#menu").animate({ right: "136px" });
			$(this).removeClass('glyphicon-align-justify').addClass('glyphicon-remove');
		}
    });
	if ($('.type-merk').length > 0) {
		$( "#datebirth" ).datepicker({
			changeMonth: true,
			changeYear: true,
			defaultDate: "-18y",
			maxDate: "-18y",
			dateFormat : "yy-mm-dd"
		});
		$("#merk").change(function(){
			$.ajax({
				cache: false,
				url: '/getTypeMerk/' + $(this).val()
			})
			.done(function (data) {
				$("#merktype").empty().html(data);
			});
		});
	}
});