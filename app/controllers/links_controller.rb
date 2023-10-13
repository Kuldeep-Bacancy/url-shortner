class LinksController < ApplicationController
  before_action :set_link, only: [:show, :view]

  def index
    links = params[:q].present? ? Link.where("url LIKE :search", search: "%#{params[:q]}%") : Link.latest
    @pagy, @links = pagy(links)
  end

  def show; end

  def create
    @link = Link.new(link_params)
    respond_to do |format|
      if @link.valid?
        @link.save!
        format.turbo_stream
      else
        @pagy, @links = pagy(Link.latest)
        format.turbo_stream { render turbo_stream: turbo_stream.update('errors', partial: 'errors', locals: {link: @link})}
      end
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