class Product < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3 }
	validates :description, presence: true, length: { minimum: 30 }
	validates :pricing, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
