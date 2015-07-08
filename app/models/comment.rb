class Comment < ActiveRecord::Base
  belongs_to :product
  validates :content, presence: true, length: { minimum: 10 }
end
