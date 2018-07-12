class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user, only: :destroy
  before_action :load_user, only: [:show, :edit, :update,
                :destroy, :correct_user]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.select(:id, :name, :admin, :email).order(name: :asc)
                 .page(params[:page]).per Settings.user_per_page
  end

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

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "u_delete"
    else
      flash[:danger] = t "not_delete"
    end
    redirect_to users_url
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "p_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless @user&.current_user? current_user
  end

  def user_params
    params.require(:user).permit User::USER_ATTRIBUTE
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]

    return @user if @user
    flash[:danger] = t "error"
    redirect_to root_path
  end
end
