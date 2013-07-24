class UserMailer < ActionMailer::Base
  default from: "no-reply@motivator.com"

  def registration_confirmation(user)
    @name = user.name
    @email = user.email
    mail(to: @email, subject: "Thank you for signing up for Ogyam!")
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Password Reset") 
  end
end
