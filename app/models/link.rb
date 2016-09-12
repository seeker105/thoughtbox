class Link < ApplicationRecord
  belongs_to :user
  validates_presence_of :title
  validates :url_string, :url => true
end
