/* JS for Tooltip behavior */// State Requirements forms
$("document").ready(function(){$(".tooltip_text").hide();$(".tooltip > a").toggle(function(){$(this).next().show()},function(){$(this).next().hide()})});