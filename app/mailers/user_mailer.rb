class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: (t "m_um.acc_active")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: (t "m_um.pass_reset")
  end
end
