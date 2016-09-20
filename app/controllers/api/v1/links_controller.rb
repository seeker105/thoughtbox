class Api::V1::LinksController < ApplicationController

  def index
    @links = Link.where(user_id: current_user.id)
    render json: @links
  end

  def update
    link = Link.find_by(id: params[:id])
    link.update_attributes(update_params)
    render json: link
  end

  private
  def update_params
    params.require(:link).permit(:title, :url_string, :read)
  end
end
