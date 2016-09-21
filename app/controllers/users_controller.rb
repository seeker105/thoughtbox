class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "Welcome #{user_params[:email]}"
      session[:user_id] = user.id
      redirect_to links_index_path
    else
      flash[:danger] = user.errors.full_messages.join(", ")
      redirect_to sign_up_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
