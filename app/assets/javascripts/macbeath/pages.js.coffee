# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".page-js").ready ->
  $("form :submit").click (e) ->
    e.preventDefault()
    location = $("#location").val()
    radius = $("#radius").val()
    square_footage = $("#square_footage").val()
    bedrooms = $("#bedrooms").val()
    bathrooms = $("#bathrooms").val()
    min_price = $("#min_price").val()
    max_price = $("#max_price").val()
    form = $("form")
    path = form.attr "action"
    $.ajax path,
      type: 'POST'
      dataType: 'json'
      data:
        location : location
        radius : radius
        square_footage : square_footage
        bedrooms : bedrooms
        bathrooms : bathrooms
        min_price : min_price
        max_price : max_price
      error: ->
      success: (data) ->
        update_availabilities(data)
      complete: ->
    return

  # Parallax Slider
  $ ->
    $("#da-slider").cslider
      autoplay: true
      interval: 8000
    return

  # Flex image slider
  $(".flex-image").flexslider
    direction: "vertical"
    controlNav: false
    directionNav: true
    pauseOnHover: true
    slideshowSpeed: 10000

  # Testimonial slider
  $(".testi-flex").flexslider
    direction: "vertical"
    controlNav: true
    directionNav: false
    pauseOnHover: true
    slideshowSpeed: 8000

  # About slider
  $(".about-flex").flexslider
    direction: "vertical"
    controlNav: true
    directionNav: false
    pauseOnHover: true
    slideshowSpeed: 8000


  # Owl carousel
  # Carousel
  $(document).ready ->
    recent = $("#owl-recent")
    recent.owlCarousel
      autoPlay: 3000 #Set AutoPlay to 3 seconds
      items: 4
      mouseDrag: false
      pagination: false

    $(".next").click ->
      recent.trigger "owl.next"
      return

    $(".prev").click ->
      recent.trigger "owl.prev"
      return

    return


  # Support
  $("#slist a").click (e) ->
    e.preventDefault()
    $(this).next("p").toggle 200
    return


  # Tooltip
  $("#price-tip1").tooltip()

  # Scroll to Top
  $(document).ready ->
    $(".totop").hide()
    $ ->
      $(window).scroll ->
        if $(this).scrollTop() > 400
          $(".totop").fadeIn()
        else
          $(".totop").fadeOut()
        return

      $(".totop a").click (e) ->
        e.preventDefault()
        $("body,html").animate
          scrollTop: 0
        , 500
        return

      return

    return

  # cache container
  $container = $("#portfolio")

  # initialize isotope
  $container.isotope()

  # filter items when filter link is clicked
  $("#filters a").click ->
    selector = $(this).attr("data-filter")
    $container.isotope filter: selector
    false


  # Pretty Photo for Gallery
  jQuery(".prettyphoto").prettyPhoto
    overlay_gallery: false
    social_tools: false

  return

update_availabilities = (data) ->
  apartments = data
  return alert "Sorry, there were no results that matched your conditions" if apartments.length == 0
  $(".owl-wrapper").empty()
  $(".rp h4.title").text "Search Results (" + apartments.length + ")"
  $.each data, (key, value) ->
    apartment = JSON.parse(value)
    $(".owl-wrapper").append "<div class=\"owl-item\" style=\"width: 238px;\">
    <div class=\"item\">
    <a href=\"/apartments/" + apartment.id + "\">
    <img src=\"" + apartment.image + "\" class=\"img-responsive\" />
    </a>
    <h4><a href=\"/apartments/" + apartment.id + "\">" + apartment.address + "</a></h4>
    <div class=\"clearfix\"></div>
    <p>" + apartment.description + "</p>
    </div>
    </div>
    </div>"
    return

  return