# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".page-js").ready ->
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
