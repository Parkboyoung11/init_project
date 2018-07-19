class StaticPagesController < ApplicationController
  def home
    @publish_posts = Entry.all.order(updated_at: :asc).page(params[:page])
                         .per Settings.microposts_per_page
  end

  def help; end

  def about; end

  def contact; end
end
