class UsersController < ApplicationController

  def new 
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to #{@user.username} to MyBrews App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
    
  def show
    @user = User.find(params[:id])
  end
    
  end


  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :lastname, :firstname)
    end
    
end