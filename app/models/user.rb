class User < ApplicationRecord	
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
    	   :recoverable, :rememberable, :validatable

	enum user_type: %i[reader author]
	has_many :books
	has_many :comments

	#------лист на пошту не створюючи devise:user/registration controller---------
	#after_create :welcome
	#private
	#def welcome
	#	puts "You sign up to our site"
	#	UserMailer.with(user: self).welcome_email.deliver_later
	#end
	#----------------------------------------------------------------------
end
