class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])
    if @user == nil
      @user = User.new(email: user_params[:email],
                       password: user_params[:password],
                       password_confirmation: user_params[:password_confirmation])
    elsif @user.save
      session[:user_id] = @user.id
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
