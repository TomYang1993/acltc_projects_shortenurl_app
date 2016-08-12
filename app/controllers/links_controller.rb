class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
    render "new.html.erb"
  end

  def create
    @link = Link.new(
      # user_id: current_user.id,
      slug: params[:slug],
      target_url: params[:target_url]
    )
    @link.save
    if @link.valid?
      flash[:success] = "link is created !"
      redirect_to '/links/new'
    else
      flash[:danger] = "Oh, no !"
      redirect_to '/links/new'
    end
  end
end
