class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @publish_posts = Entry.all.where(user_id: current_user.following_ids)
                                .order(updated_at: :asc).page(params[:page])
                                .per Settings.entries_per_home_page
    else
      @publish_posts = Entry.all.order(updated_at: :asc).page(params[:page])
                                .per Settings.entries_per_home_page
    end
  end

  def help; end

  def about; end

  def contact; end
end
