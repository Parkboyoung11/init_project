class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :admin_user, only: :destroy
  before_action :load_user, only: [:show, :edit, :update,
                                   :destroy, :correct_user,
                                   :following, :followers]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.get_users_to_show
                 .page(params[:page]).per Settings.user_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "c_uc.p_check_mail"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @entries = @user.entries.page(params[:page])
                       .per Settings.microposts_per_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "c_uc.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "c_uc.u_delete"
    else
      flash[:danger] = t "c_uc.not_delete"
    end
    redirect_to users_url
  end

  def following
    @title = t "following"
    @users = @user.following.page(params[:page]).per(Settings.users_per_page)
    render "show_follow"
  end

  def followers
    @title = t "followers"
    @users = @user.followers.page(params[:page]).per(Settings.users_per_page)
    render "show_follow"
  end

  private

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
    flash[:danger] = t "c_uc.find_error"
    redirect_to root_path
  end
end
