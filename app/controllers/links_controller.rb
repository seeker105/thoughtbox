class LinksController < ApplicationController
  def index
    @link = Link.new
    @links = current_user.links
  end

  def create
    link = current_user.links.new(link_params)
    if link.save
      flash[:success] = "Link Created"
    else
      flash[:danger] = link.errors.full_messages.join(", ")
    end
    redirect_to links_index_path
  end

  def edit
    @link = current_user.links.find_by(id: params[:id])
  end

  def update
    link = current_user.links.find_by(id: params[:id])
    link.update_attributes(link_params)
    redirect_to links_index_path
  end

  private
  def link_params
    params.require(:link).permit(:url_string, :title)
  end
end
