class Link < ActiveRecord::Base
  belongs_to :user
  validates :slug, :target_url, presence: true
  has_many :visits

  def standardize_target_url!
    target_url.gsub!("http://", "")
    target_url.gsub!("https://", "")
  end

  def visit_count
    visits.count
  end
end
