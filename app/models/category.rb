class Category < ActiveRecord::Base
	has_many :products
	alias_attribute :catname, :name
end
