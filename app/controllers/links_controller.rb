class LinksController < ApplicationController
  before_action :set_link, only: [:show, :view]

  def index
    @pagy, @links = pagy(Link.latest)
  end

  def show; end

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

  def view
    redirect_to @link.url, allow_other_host: true
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def set_link
    @link = Link.find_by(id: ShortCode.decode(params[:id]))
  end
end