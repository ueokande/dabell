class UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :full_name, :email, :avatar)
  end
end
