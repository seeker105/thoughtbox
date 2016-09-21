class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      flash[:success] = "Welcome #{user_params[:email]}"
      session[:user_id] = @user.id
      redirect_to links_index_path
    else
      flash[:danger] = "Invalid Login"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
