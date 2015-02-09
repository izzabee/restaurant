class Food < ActiveRecord::Base
	has_many :orders
	has_many :parties, through: :orders
	
	validates :name, 
		uniqueness: {
			message: "%{value} is already on the menu!"
	 }


end