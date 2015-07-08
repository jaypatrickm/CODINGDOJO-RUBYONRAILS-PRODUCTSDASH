class Product < ActiveRecord::Base
	belongs_to :category
	validates :name, presence: true, length: { minimum: 3 }
	validates :description, presence: true, length: { minimum: 30 }
	validates :pricing, presence: true, numericality: { greater_than: 0 }
	validates :category_id, numericality: { only_integer: true, :message => "must be selected from the drop down."}
end
