class Link < ApplicationRecord
  belongs_to :user
  validates_presence_of :title
  validates :url_string, :url => true
  before_save :nil_false

  def nil_false
    if read == nil
      self.read = false
    end
  end
end
