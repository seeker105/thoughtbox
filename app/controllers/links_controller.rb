class LinksController < ApplicationController
  def index
    @link = Link.new
    @links = current_user.links
  end

  def create
    if !valid_url?(link_params[:url_string])
      # byebug
      flash[:danger] = "Error: Bad web address"
      redirect_to links_index_path
    elsif current_user
      current_user.links.create(link_params)
      redirect_to links_index_path
    else
      flash.now[:danger] = "No Logged in user"
      redirect_to root_path
    end
  end

  private
  def link_params
    params.require(:link).permit(:url_string, :title)
  end

  def valid_url?(url_string)
    !!URI.parse(url_string)
  rescue URI::InvalidURIError
    false
  end
end
