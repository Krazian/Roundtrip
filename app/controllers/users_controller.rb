class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "User Successfully Created"
      flash[:username] = user_params[:username]
      redirect_to sessions_path
    else
      render new_user_path
    end

  end

  def show
    @user_id = params[:id]
    @trips = User.find_by(id: params[:id]).trips

    if @trips
      @rand = Trip.order("RANDOM()").first

    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:username, :email, :first_name, :first_name, :last_name, :password, :password_confirmation)
  end
  
end

