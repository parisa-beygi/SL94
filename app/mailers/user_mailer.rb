class UserMailer < ActionMailer::Base
  default from: 'mahsa.abadian@gmail.com'
         
  def welcome_email(user)
    @user = user
    @url  = 'http://esm-famil.com/login'
    mail(to: @user.email, subject: 'به سایت اسم فامیل خوش آمدید.')
  end
end
