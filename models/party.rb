class Party < ActiveRecord::Base
	has_many :orders
	has_many :foods, through: :orders
	belongs_to :employee

	validates :table_id,
		uniqueness: {
			message: "Table %{value} is already occupied."
	 	}

end