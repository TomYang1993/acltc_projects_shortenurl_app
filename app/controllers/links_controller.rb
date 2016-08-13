class LinksController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
      @links = Link.where(user_id: current_user.id)
    else
      render "index"
    end
  end

  def new
    @link = Link.new
    render "new"
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

      @link.save
      if @link.valid?
        flash[:success] = "link is created !"
        redirect_to links_path
      else
        flash[:danger] = @link.errors.full_messages
        render "new.html.erb"
      end
    # else
    #   flash[:danger] = "you need to log in !"
    #   redirect_to '/users/sign_in'
    # end
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
      redirect_to links_path
    else
      flash[:danger] = @link.errors.full_messages
      render "edit.html.erb"
    end
  end

  def destroy
    @link = Link.find_by(:id => params[:id])
    if @link.destroy
      flash[:success] = "a record has been deleted"
      redirect_to links_path
    else
      flash[:danger] = "unknown mistake"
      redirect_to links_path
    end
  end
end
