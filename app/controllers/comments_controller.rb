class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def create
    @entry = Entry.find params[:comment][:entry_id]
    @comment = current_user.comments.build comment_params
    if @comment.save
      respond_to do |format|
        format.html {redirect_to @entry}
        format.js
      end
    else
      flash[:danger] = "Comment Fail!"
      redirect_to @entry
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update_attribute :content, params[:comment][:content]
      respond_to do |format|
        format.html {redirect_to @comment.entry}
        format.js
      end
    else
      flash[:alert] = "Something worng, try again"
      render @comment.entry
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_to @comment}
        format.js
      end
    else
      flash[:danger] = t "c_mc.mpost_not_delete"
      redirect_to @comment.entry
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :entry_id
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end
end