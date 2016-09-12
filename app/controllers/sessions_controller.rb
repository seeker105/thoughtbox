class SessionsController < ApplicationController
  def create
    @user = User.from_params(user_params)
    if @user == nil
      redirect_to root_path
    elsif user_params[:password] != user_params[:password_confirmation]
      redirect_to root_path
    elsif (@user.password == user_params[:password]) || @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      cookies[:user_email] = @user.email
      redirect_to links_index_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    cookies.delete :user_email
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
