initializeWidget = ->    
  #inject css
  ovrCss = document.createElement "link"
  ovrCss.href = 'https://s3.amazonaws.com/register2.rockthevote.com/widgetloader/css/style.css'
  ovrCss.rel = "stylesheet"
  ovrCss.type = "text/css"
  head = document.getElementsByTagName("head")[0]
  head.appendChild(ovrCss)

  #click handler for registration links.
  registrationLinks = $ '.floatbox[href*="register.rockthevote.com"],.floatbox[href*="register2.rockthevote.com"]'
  registrationLinks.on 'click', (e) ->
    e.preventDefault()
    $el = $(@)
    $body = $('body')
    $overlay = $ '<div class="ovr-overlay" />'
    $iframe  = $ '<iframe id="ovr-widget" />'
    $close = $ '<a href="#" class="ovr-close">close [x]</a>'
    $container = $ '<div id="ovr-container" />'
    $iframe.attr('src', $el.attr('href'))
    $body.append $container
    $container.append $overlay
    $overlay.hide().fadeIn(300)
    $container.append $iframe
    $container.prepend($close)
    $close.on 'click', (e) ->
      e.preventDefault()
      close = confirm "Close voter registration application?"
      if close
        $('.ovr-overlay, #ovr-container').remove()
      else
        return false

if typeof jQuery == "undefined"
  script = document.createElement("script")
  script.src = "http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"
  head = document.getElementsByTagName("head")[0]
  head.appendChild(script)
  script.onload = ->
    jQuery ($) ->
      initializeWidget()  

else
  jQuery ($) ->
    initializeWidget()