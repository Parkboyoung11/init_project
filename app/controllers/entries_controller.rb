class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build entry_params
    if @entry.save
      flash[:success] = t "c_mc.entry_created"
      redirect_to root_url
    else
      @publish_posts = Entry.all.order(updated_at: :asc).page(params[:page])
                            .per Settings.microposts_per_page
      render :new
    end
  end

  def show
    @entry = Entry.find_by id: params[:id]
    @comment = Comment.new

    return @entry if @entry
    flash[:danger] = t "c_uc.find_error"
    redirect_to root_path
  end

  def destroy
    if @entry.destroy
      flash[:success] = t "c_mc.entry_deleted"
    else
      flash[:danger] = t "c_mc.mpost_not_delete"
    end
    redirect_to request.referrer || root_url
  end

  private

  def entry_params
    params.require(:entry).permit :content, :title
  end

  def correct_user
    @entry = current_user.entries.find_by id: params[:id]
    redirect_to root_url if @entry.nil?
  end
end
