class UserMailer < ApplicationMailer
  default from: 'finance_app_notification@example.com'
 
  def notification_email(user)
    @user = user
    #@url  = 'http://example.com/login'
    mail(to: @user.name, subject: 'Critical value')
  end
end
