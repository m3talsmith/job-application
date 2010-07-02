module View
  def image_tag(source, options={})
    return options.empty? ? "<img src='#{source}' />" : "<img src='#{source}' #{attributes_from_hash(options)} />"
  end
  
  def url_for_file_column(model, asset, image_size, file_extension="png")
    return "/assets/#{model}/#{asset}_#{image_size}.#{file_extension}"
  end
  
  def link_to(text, source="#", html={})
    return html.empty? ? "<a href='#{source}'>#{text}</a>" : "<a href='#{source}' #{attributes_from_hash(html)}"
  end
  
  private
    def attributes_from_hash(attributes={})
      return attributes.empty? ? nil : attributes.map {|key, value| "#{key}='#{value}'"}.join(" ")
    end
end