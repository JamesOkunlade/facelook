class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: 'james.okunlade@gmail.com', subject: 'You are welcome to facelook')
    # mail(to: @user.mail, subject: 'You are welcome to facelook')
  end
end
