# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("form").ready ->
  $("select#background_check_property").change ->
    property_id = $(this).val()
    $("select[name*='background_check[apartment_id]']").addClass "hidden"
    $("select#apartment" + property_id).removeClass "hidden"
    return
  return
