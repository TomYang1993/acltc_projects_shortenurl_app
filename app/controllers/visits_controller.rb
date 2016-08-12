class VisitsController < ApplicationController
  def create
    @link = Link.find_by(slug: params[:slug])
    redirect_to "#{@link.target_url}"

  end
end
