module ApartmentsHelper
  def available_colorizer(value)
    if value
      content_tag(:span, "Available", class: "label label-success")
    else
      content_tag(:span, "Unavailable", class: "label label-danger")
    end
  end
end
