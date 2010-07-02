module Profile
  def profile_path(profile)
    return "/profiles/#{profile.name}/"
  end
end