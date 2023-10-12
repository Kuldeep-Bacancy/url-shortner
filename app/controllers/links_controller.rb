class LinksController < ApplicationController

  def index
    @links = Link.latest
  end

  def create
    @link = Link.new(link_params)
    if @link.valid?
      @link.save!
      redirect_to root_path
    else
      @links = Link.latest
      render :index, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end