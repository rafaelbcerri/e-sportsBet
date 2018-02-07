class UserMailer < ApplicationMailer

  def new_user_message(user)
    @user = user
    @url  = 'http://localhost:3000/bets'
    mail(to: @user.email, subject: 'Welcome to e-sportsbet')
  end
end
