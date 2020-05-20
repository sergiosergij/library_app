class User < ApplicationRecord
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
    	   :recoverable, :rememberable, :validatable

	enum user_type: %i[reader author]
	has_many :books
end
