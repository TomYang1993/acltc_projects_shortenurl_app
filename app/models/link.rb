class Link < ActiveRecord::Base
  belongs_to :user
  validates :slug, :target_url, presence: true
end
