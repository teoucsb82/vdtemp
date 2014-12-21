module DashboardsHelper
  def i_link(text, path, fa_class, m=nil)
    return m.nil? ? link_to(content_tag(:i, "", class: "fa fa-#{fa_class}") + " #{text}", path) : link_to(content_tag(:i, "", class: "fa fa-#{fa_class}") + " #{text}", path, method: m)
  end

  def i_link_dropdown(text, path, fa_class)
    dropdown_arrow = content_tag(:span, content_tag(:i, "", class: "fa fa-chevron-right"), class: "pull-right")
    return link_to(content_tag(:i, "", class: "fa fa-#{fa_class}") + " #{text}" + dropdown_arrow, path)
  end
end