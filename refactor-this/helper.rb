require 'helper/view'
require 'helper/profile'
class Helper
  include View
  include Profile
  
  def self.foo
    "foo"
  end

  def image_size(profile, non_rep_size)
    if profile.user.rep?
      '190x114'
    else
      non_rep_size
    end
  end

  def display_small_photo(profile, html = {}, options = {})
    display_photo(profile, image_size(profile, "32x32"), html, options)
  end

  def display_medium_photo(profile, html = {}, options = {})
    display_photo(profile, image_size(profile, "48x48"), html, options)
  end

  def display_large_photo(profile, html = {}, options = {}, link = true)
    display_photo(profile, image_size(profile, "64x64"), html, options, link)
  end

  def display_huge_photo(profile, html = {}, options = {}, link = true)
    display_photo(profile, image_size(profile, "200x200"), html, options, link)
  end

  def display_photo(profile, size, html = {}, options = {}, link = true)
    return image_tag("wrench.png") unless profile  # this should not happen

    show_default_image = !(options[:show_default] == false)
    html.reverse_merge!(:class => 'thumbnail', :size => size, :title => "Link to #{profile.name}")

    if profile && profile.user
      if profile.user.photo && File.exists?(profile.user.photo.to_s)
        @user = profile.user
        if link
          # Syntax: link_to(content, source, html_options)
          return link_to(image_tag(url_for_file_column("user", "photo", size), html), profile_path(profile) )
        else
          return image_tag(url_for_file_column("user", "photo", size), html)
        end
      else
        show_default_image ? default_photo(profile, size, {}, link) : ''
      end
    end

    show_default_image ? default_photo(profile, size, {}, link) : ''
  end

  def default_photo(profile, size, html={}, options={}, link = true)
    if profile.user && profile.user.rep?
      image = image_tag("user190x119.jpg", html)
    else
      image = image_tag("user#{size}.jpg", html)
    end
    
    return link ? link_to(options[:show_default] ? image : profile.name, profile_path(profile)) : image
  end
end