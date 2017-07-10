class UsersController < ApplicationController
  before_action :require_user, only: [:index, :destroy]

  def new 
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Successfully created user!'
      redirect_to new_login_path
    else
      flash[:alert] = 'Error creating new user!'
      render :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, notice: 'User was deleted'
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
