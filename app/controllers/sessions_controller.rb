class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      flash[:success] = "Welcome #{user_params[:email]}"
      session[:user_id] = @user.id
      redirect_to links_index_path
    else
      if @user
        flash[:danger] = @user.errors.full_messages.join(", ")
      else
        flash[:danger] = "Bad Login"
      end
      redirect_to login_path
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
