class Employee < ActiveRecord::Base
	has_many :parties

	attr_reader :password

  validates :name, presence: true
  # validates :password, presence: true

	# Find employee based on name and password
  def self.find_by_credentials(args = {})
    employee = Employee.find_by(name: args[:name])

    if employee.is_password?(args[:password])
      return employee
    else
      return nil
    end
  end

  # Set and accept password for each employee
  def set_password=(pwd)

    self.password = BCrypt::Password.create(pwd)
    self.save
  end

  def is_password?(pwd)
   bcrypt_pwd = BCrypt::Password.new(self.password)

   return bcrypt_pwd.is_password?(pwd)
  end

end