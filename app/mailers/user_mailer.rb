class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: (t "m_um.acc_active")
  end
end
