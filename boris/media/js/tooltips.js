/* JS for Tooltip behavior */


// State Requirements forms

$("document").ready(function() {

//Hide tooltips on ready

	$(".tooltip_text").hide();

	$(".tooltip > a").hover(function() {
		$(this).next().show();
		}, function() { $(this).next().hide(); 
	});
	
	$(".tooltip > a").toggle(function() {
		$(this).next().show();
		}, function() { 
		$(this).next().hide(); 
	});
});