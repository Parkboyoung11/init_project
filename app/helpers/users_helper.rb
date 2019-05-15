module UsersHelper
  def gravatar_for user, options = {size: Settings.img_size}
    size = options[:size]
    if File.exist?(Rails.root.to_s + "/app/assets/images/#{user.id}.jpg")
      gravatar_url = "#{user.id}.jpg"
    else
      gravatar_url = "default.png"
    end
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size: size)
  end
end
