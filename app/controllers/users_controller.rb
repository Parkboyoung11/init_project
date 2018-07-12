class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "Welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:success] = t "error"
    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit User::USER_ATTRIBUTE
  end
end
