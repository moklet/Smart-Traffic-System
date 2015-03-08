$( document ).ready(function() {
	var height = $(window).height()-252-50;
	$("#content").css("min-height",height);
	$(".sm-menu").click(function(){
		$(".sm-ulmenu").slideToggle();
	});
	$(".accord-title").click(function(){
		var data=$(this).attr("data");
		$("#"+data).slideToggle();
	})
});