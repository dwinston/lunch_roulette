class UserMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"]

  def lunch_mailing(users)
    @first_names = users.map(&:first_name)
    mail to: users.map(&:email), subject: '[Lunch roulette] Your lunch group today'
  end

  def sorry_mailing(user)
    @first_name = user.first_name
    mail to: user.email, subject: '[Lunch roulette] Your lunch group today'
  end
end
