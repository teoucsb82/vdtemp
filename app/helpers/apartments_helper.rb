module ApartmentsHelper
  def available_colorizer(value)
    if value
      content_tag(:span, "Available", class: "label label-success")
    else
      content_tag(:span, "Unavailable", class: "label label-danger")
    end
  end

  def prices_array(apartments)
    return (@apartments.available.map(&:rent).min.to_i..@apartments.available.map(&:rent).max.to_i).to_a.select { |x| x % 50 == 0 }
  end
end
