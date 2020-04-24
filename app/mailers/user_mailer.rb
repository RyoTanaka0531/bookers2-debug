class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_welcome_mail.subject
  #
  def user_welcome_mail(user)
    @user = user

    mail to: @user.email, subject: "新規登録完了のご連絡"
  end
end
