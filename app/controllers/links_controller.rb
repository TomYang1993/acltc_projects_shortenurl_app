class LinksController < ApplicationController
  def index
    @links = Link.where(user_id: current_user.id)
  end

  def new
    @link = Link.new
    render "new.html.erb"
  end

  def show
    @link = Link.find_by(id: params[:id])
  end

  def create
    @link = Link.new(
      user_id: current_user.id,
      slug: params[:slug],
      target_url: params[:target_url]
    )
    @link.standardize_target_url!
    if current_user
      @link.save
      if @link.valid?
        flash[:success] = "link is created !"
        redirect_to '/links'
      else
        flash[:danger] = @link.errors.full_messages
        render "new.html.erb"
      end
    else
      flash[:danger] = "you need to log in !"
      redirect_to '/users/sign_in'
    end
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update
    @link = Link.find_by(id: params[:id])
    @link.update(
      slug: params[:slug],
      target_url: params[:target_url]
    )
    if @link.valid?
      @link.standardize_target_url!
      flash[:success] = "link is updated !"
      redirect_to '/links'
    else
      flash[:danger] = @link.errors.full_messages
      render "edit.html.erb"
    end

  end
end
