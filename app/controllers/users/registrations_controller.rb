
class Users::RegistrationsController < Devise::RegistrationsController
  after_action :welcome, only: :create

  private
  
  def welcome
    if @user.save
     UserMailer.with(user: @user).welcome_email.deliver_later 
    end
  end

end
