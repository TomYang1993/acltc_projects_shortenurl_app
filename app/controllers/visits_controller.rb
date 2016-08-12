class VisitsController < ApplicationController
  def create
    @link = Link.find_by(slug: params[:slug])
    visit = Visit.new(
      link_id: @link.id,
      ip_address: request.remote_ip
    )
    visit.save
    redirect_to "http://#{@link.target_url}"

  end
end
