# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".dashboard-js").ready ->
  sidebar()
  widget()
  calendar()
  progressBar()
  slider()
  support()
  toTop()
  noty()
  dateTimePicker()
  onOff()
  cleditor()
  prettyPhoto()
  slimScroll()  
  dtable()
  $(".modal").appendTo $("body")
  load_chart_data()
  return

sidebar = ->
  $(window).resize ->
    if $(window).width() >= 765
      $(".sidebar #nav").slideDown 350
    else
      $(".sidebar #nav").slideUp 350
    return

  $(".has_sub > a").click (e) ->
    e.preventDefault()
    menu_li = $(this).parent("li")
    menu_ul = $(this).next("ul")
    if menu_li.hasClass("open")
      menu_ul.slideUp 350
      menu_li.removeClass "open"
    else
      $("#nav > li > ul").slideUp 350
      $("#nav > li").removeClass "open"
      menu_ul.slideDown 350
      menu_li.addClass "open"
    return

  $(".sidebar-dropdown a").on "click", (e) ->
    e.preventDefault()
    unless $(this).hasClass("open")
      
      # hide any open menus and remove all other classes
      $(".sidebar #nav").slideUp 350
      $(".sidebar-dropdown a").removeClass "open"
      
      # open our new menu and add the open class
      $(".sidebar #nav").slideDown 350
      $(this).addClass "open"
    else if $(this).hasClass("open")
      $(this).removeClass "open"
      $(".sidebar #nav").slideUp 350
    return
  return

widget = ->
  $(".wclose").click (e) ->
    e.preventDefault()
    $wbox = $(this).parent().parent().parent()
    $wbox.hide 100
    return

  $(".wminimize").click (e) ->
    e.preventDefault()
    $wcontent = $(this).parent().parent().next(".widget-content")
    if $wcontent.is(":visible")
      $(this).children("i").removeClass "fa fa-chevron-up"
      $(this).children("i").addClass "fa fa-chevron-down"
    else
      $(this).children("i").removeClass "fa fa-chevron-down"
      $(this).children("i").addClass "fa fa-chevron-up"
    $wcontent.toggle 500
    return
  return

calendar = ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()
  $("#calendar").fullCalendar
    header:
      left: "prev"
      center: "title"
      right: "month,agendaWeek,agendaDay,next"

    editable: true
    events: [
      {
        title: "All Day Event"
        start: new Date(y, m, 1)
      }
      {
        title: "Long Event"
        start: new Date(y, m, d - 5)
        end: new Date(y, m, d - 2)
      }
      {
        id: 999
        title: "Repeating Event"
        start: new Date(y, m, d - 3, 16, 0)
        allDay: false
      }
      {
        id: 999
        title: "Repeating Event"
        start: new Date(y, m, d + 4, 16, 0)
        allDay: false
      }
      {
        title: "Meeting"
        start: new Date(y, m, d, 10, 30)
        allDay: false
      }
      {
        title: "Lunch"
        start: new Date(y, m, d, 12, 0)
        end: new Date(y, m, d, 14, 0)
        allDay: false
      }
      {
        title: "Birthday Party"
        start: new Date(y, m, d + 1, 19, 0)
        end: new Date(y, m, d + 1, 22, 30)
        allDay: false
      }
      {
        title: "Click for Google"
        start: new Date(y, m, 28)
        end: new Date(y, m, 29)
        url: "http://google.com/"
      }
    ]
  return

progressBar = ->
  setTimeout (->
    $(".progress-animated .progress-bar").each ->
      me = $(this)
      perc = me.attr("data-percentage")
      
      #TODO: left and right text handling
      current_perc = 0
      progress = setInterval(->
        if current_perc >= perc
          clearInterval progress
        else
          current_perc += 1
          me.css "width", (current_perc) + "%"
        me.text (current_perc) + "%"
        return
      , 200)
      return

    return
  ), 1200
  return

slider = ->
  $ ->
    # Horizontal slider
    $("#master1, #master2").slider
      value: 60
      orientation: "horizontal"
      range: "min"
      animate: true

    $("#master4, #master3").slider
      value: 80
      orientation: "horizontal"
      range: "min"
      animate: true

    $("#master5, #master6").slider
      range: true
      min: 0
      max: 400
      values: [
        75
        200
      ]
      slide: (event, ui) ->
        $("#amount").val "$" + ui.values[0] + " - $" + ui.values[1]
        return

    
    # Vertical slider 
    $("#eq > span").each ->
      
      # read initial values from markup and remove that
      value = parseInt($(this).text(), 10)
      $(this).empty().slider
        value: value
        range: "min"
        animate: true
        orientation: "vertical"

      return
    return
  return

support = ->
  $("#slist a").click (e) ->
    e.preventDefault()
    $(this).next("p").toggle 200
    return
  return

toTop = ->
  $(".totop").hide()
  $ ->
    $(window).scroll ->
      if $(this).scrollTop() > 300
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

noty = ->
  $(".noty-alert").click (e) ->
    e.preventDefault()
    noty
      text: "Some notifications goes here..."
      layout: "topRight"
      type: "alert"
      timeout: 2000
    return

  $(".noty-success").click (e) ->
    e.preventDefault()
    noty
      text: "Some notifications goes here..."
      layout: "top"
      type: "success"
      timeout: 2000
    return

  $(".noty-error").click (e) ->
    e.preventDefault()
    noty
      text: "Some notifications goes here..."
      layout: "topRight"
      type: "error"
      timeout: 2000
    return

  $(".noty-warning").click (e) ->
    e.preventDefault()
    noty
      text: "Some notifications goes here..."
      layout: "bottom"
      type: "warning"
      timeout: 2000
    return

  $(".noty-information").click (e) ->
    e.preventDefault()
    noty
      text: "Some notifications goes here..."
      layout: "topRight"
      type: "information"
      timeout: 2000
    return
  return

dateTimePicker = ->
  $ ->
    $("#datetimepicker1").datetimepicker pickTime: false
    return

  $ ->
    $("#datetimepicker2").datetimepicker pickDate: false
    return
  return

onOff = ->
  $('.toggleBtn').onoff()
  return

cleditor = ->
  $(".cleditor").cleditor
    width: "auto"
    height: "auto"
  return

prettyPhoto = ->
  $("a[class^='prettyPhoto']").prettyPhoto
    overlay_gallery: false
    social_tools: false

  return

slimScroll = ->
  $(".scroll-chat").slimscroll
    height: "350px"
    color: "rgba(0,0,0,0.3)"
    size: "5px"
  return

dtable = ->
  $("#data-table").dataTable sPaginationType: "full_numbers"
  return

load_chart_data = ->
  $ ->
    
    # Bar Chart starts 
    plotWithOptions = ->
      $.plot $("#bar-chart"), [
        d1
        d2
      ],
        series:
          stack: stack
          lines:
            show: lines
            fill: true
            steps: steps

          bars:
            show: bars
            barWidth: 0.8

        grid:
          borderWidth: 0
          hoverable: true
          color: "#777"

        colors: [
          "#ff6c24"
          "#ff2424"
        ]
        bars:
          show: true
          lineWidth: 0
          fill: true
          fillColor:
            colors: [
              {
                opacity: 0.9
              }
              {
                opacity: 0.8
              }
            ]

      return
    d1 = []
    i = 0

    while i <= 20
      d1.push [
        i
        parseInt(Math.random() * 30)
      ]
      i += 1
    d2 = []
    i = 0

    while i <= 20
      d2.push [
        i
        parseInt(Math.random() * 30)
      ]
      i += 1
    stack = 0
    bars = true
    lines = false
    steps = false
    plotWithOptions()
    $(".stackControls input").click (e) ->
      e.preventDefault()
      stack = (if $(this).val() is "With stacking" then true else null)
      plotWithOptions()
      return

    $(".graphControls input").click (e) ->
      e.preventDefault()
      bars = $(this).val().indexOf("Bars") isnt -1
      lines = $(this).val().indexOf("Lines") isnt -1
      steps = $(this).val().indexOf("steps") isnt -1
      plotWithOptions()
      return

    return


  # Bar chart ends 

  # Curve chart starts 
  $ ->
    showTooltip = (x, y, contents) ->
      $("<div id=\"tooltip\">" + contents + "</div>").css(
        position: "absolute"
        display: "none"
        top: y + 5
        left: x + 5
        border: "1px solid #000"
        padding: "2px 8px"
        color: "#ccc"
        "background-color": "#000"
        opacity: 0.9
      ).appendTo("body").fadeIn 200
      return
    sin = []
    cos = []
    i = 0

    while i < 14
      sin.push [
        i
        Math.sin(i)
      ]
      cos.push [
        i
        Math.cos(i)
      ]
      i += 0.5
    plot = $.plot($("#curve-chart"), [
      {
        data: sin
        label: "sin(x)"
      }
      {
        data: cos
        label: "cos(x)"
      }
    ],
      series:
        lines:
          show: true
          fill: true

        points:
          show: true

      grid:
        hoverable: true
        clickable: true
        borderWidth: 0

      yaxis:
        min: -1.2
        max: 1.2

      colors: [
        "#1eafed"
        "#1eafed"
      ]
    )
    previousPoint = null
    $("#curve-chart").bind "plothover", (event, pos, item) ->
      $("#x").text pos.x.toFixed(2)
      $("#y").text pos.y.toFixed(2)
      if $("#enableTooltip:checked").length > 0
        if item
          unless previousPoint is item.dataIndex
            previousPoint = item.dataIndex
            $("#tooltip").remove()
            x = item.datapoint[0].toFixed(2)
            y = item.datapoint[1].toFixed(2)
            showTooltip item.pageX, item.pageY, item.series.label + " of " + x + " = " + y
        else
          $("#tooltip").remove()
          previousPoint = null
      return

    $("#curve-chart").bind "plotclick", (event, pos, item) ->
      if item
        $("#clickdata").text "You clicked point " + item.dataIndex + " in " + item.series.label + "."
        plot.highlight item.series, item.datapoint
      return

    return


  # Curve chart ends 

  # Realtime chart starts 
  $ ->
    
    # we use an inline data source in the example, usually data would
    # be fetched from a server
    getRandomData = ->
      data = data.slice(1)  if data.length > 0
      
      # do a random walk
      while data.length < totalPoints
        prev = (if data.length > 0 then data[data.length - 1] else 50)
        y = prev + Math.random() * 10 - 5
        y = 10  if y < 10
        y = 70  if y > 70
        data.push y
      
      # zip the generated y values with the x values
      res = []
      i = 0

      while i < data.length
        res.push [
          i
          data[i]
        ]
        ++i
      res
    
    # setup control widget
    
    # setup plot
    # drawing is faster without shadows
    update = ->
      plot.setData [getRandomData()]
      
      # since the axes don't change, we don't need to call plot.setupGrid()
      plot.draw()
      setTimeout update, updateInterval
      return
    data = []
    totalPoints = 300
    updateInterval = 300
    $("#updateInterval").val(updateInterval).change ->
      v = $(this).val()
      if v and not isNaN(+v)
        updateInterval = +v
        updateInterval = 1  if updateInterval < 1
        updateInterval = 2000  if updateInterval > 2000
        $(this).val "" + updateInterval
      return

    options =
      series:
        shadowSize: 0

      lines:
        fill: true

      grid:
        borderWidth: 0

      yaxis:
        min: 0
        max: 100

      colors: ["#ff2424"]

    plot = $.plot($("#live-chart"), [getRandomData()], options)
    update()
    return


  # Realtime charts ends 

  # Pie chart starts 
  $ ->
    data = []
    series = Math.floor(Math.random() * 10) + 1
    i = 0

    while i < series
      data[i] =
        label: "Series" + (i + 1)
        data: Math.floor(Math.random() * 100) + 1
      i++
    $.plot $("#pie-chart"), data,
      series:
        pie:
          show: true
          radius: 1
          label:
            show: true
            radius: 3 / 4
            formatter: (label, series) ->
              "<div style=\"font-size:8pt;text-align:center;padding:2px;color:white;\">" + label + "<br/>" + Math.round(series.percent) + "%</div>"

            background:
              opacity: 0

      grid:
        hoverable: true

      legend:
        show: false

    $.plot $("#pie-chart2"), data,
      series:
        pie:
          show: true

      grid:
        hoverable: true

    $.plot $("#pie-chart3"), data,
      series:
        pie:
          show: true

      grid:
        hoverable: true

      legend:
        show: false

    return


  # Pie chart ends 
return