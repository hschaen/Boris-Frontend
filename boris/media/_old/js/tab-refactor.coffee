tabNext = (e, self) ->
	$tab = 	$("##{$(self).parents('fieldset').attr('id')}-tab")
	$('li.tab.active').removeClass("active")
	$tab.addClass("complete")
	$tab.next().addClass("active")

	$(self)
		.parents('fieldset')
		.hide()
		.next()
		.show()

tabPrev = (e, self) ->
	$tab = 	$("##{$(self).parents('fieldset').attr('id')}-tab")
	$tab.removeClass("active")
	$tab.removeClass("complete")
	$tab.prev().addClass("active")
	
	$(self)
		.parents('fieldset')
		.hide()
		.prev()
		.show()

tabValidate = (id) ->
		switch id
			when "address"
				return validateAddresses()
			when "personal"
				return validatePersonal()
			when "contact"
				return validateContact()
			when "additional"
				return validateAdditional()
			else
				return true

initTabs = ->
	# Hide unused fieldsets
	$fieldsets = $('fieldset')
	$fieldsets.hide()
		.filter(':first')
		.show()

	# Generate Fieldset Header
	html = "<div id=\"tab-indicators\"><ol></ol></div>"
	$('#state_form').before(html)
	counter = 1
	$fieldsets.not('.mailing, .address-change, #previous_name').each -> #Keeping optional fieldsets out of the tab navigation#
		$fs = $(this)
		unless $fs.find('li.form-action').length == 1
			$fs.children('ul').append("<li class=\"form-action\"></li>")
		unless $fs.next().length == 0
			$fs.find('li.form-action').append("<button class=\"btn-next\">Next</button>")
		unless $fs.prev().length == 0
			$fs.find('li.form-action').append("<button class=\"btn-prev\">Back</button>")		
		tabClass = if (counter == 1) then "active tab" else "tab"
		html =  """
				<li class="#{tabClass}" id="#{ $fs.attr('id') }-tab">
					Step #{counter}
				</li>
				"""
		$('#tab-indicators > ol').append(html)
		counter++
	#Start Over Button
	#$("fieldset#address").find("li.form-action").append("<button class=\"start-over\">Go Back</button>");


	# Bind Click Handlers
	$("button.start-over").on('click',(e) ->
  	e.preventDefault()
  	window.location.reload();
  	)
	
	$("button.btn-next").on('click', (e) ->
		e.preventDefault()
		if tabValidate($(this).parents('fieldset').attr('id')) != true
			false
		else
			tabNext(e, this)
	)
	$("button.btn-prev").on('click', (e) ->
		e.preventDefault()
		#console.log "Next!"
		tabPrev(e, this)
	)