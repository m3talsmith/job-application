module View
  def image_tag(source, options={})
    image_attributes = options.map {|key, value| "#{key}='#{value}'"} unless options.empty?
    return image_attributes ? "<img src='#{source}' #{image_attributes} />" : "<img src='#{source}' />"
  end
  
  def link_to
  end
end