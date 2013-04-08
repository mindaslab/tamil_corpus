class Word < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :tags
  
  ##
  # Tags that are not associated with this word
  def untags
    Tag.all.order(:name) - tags
  end
end
