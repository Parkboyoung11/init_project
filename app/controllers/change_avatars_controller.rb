class ChangeAvatarsController < ApplicationController
  def new
    return if logged_in?
    redirect_to root_url
  end

  def change
    if logged_in?
      uploaded_io = params[:change_avatar][:avatar]
      File.open((Rails.root.to_s + "/app/assets/images/#{current_user.id}.jpg"), "wb") do |file|
        file.write(uploaded_io.read)
      end
      redirect_to current_user
    else
      redirect_to root_url
    end
  end
end