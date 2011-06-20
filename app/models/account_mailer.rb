class AccountMailer < ActionMailer::Base
  
  default :from => Masquerade::Application::Config['mailer']['from']

  def signup_notification(account)
    raise "send_activation_mail deactivated" unless Masquerade::Application::Config['send_activation_mail']
    @account = account
    mail :to => account.email, :subject => I18n.translate(:please_activate_your_account)
  end

  def forgot_password(account)
    @account = account
    mail :to => account.email, :subject => I18n.translate(:your_request_for_a_new_password)
  end
end
