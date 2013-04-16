class MailingsController < ApplicationController
  http_basic_authenticate_with name: ENV["MAILING_NAME"], password: ENV["MAILING_PASSWORD"]

  def new
  end

  def create
    hour_of_day = Time.zone.now.hour  
    #if hour_of_day != 11
    #  redirect_to(new_mailing_path, notice: "Perform lunch roulette no earlier than 11am and no later than noon.") and return 
    #end unless !Rails.env.production?
    wanting_lunch = User.all_wanting_lunch.shuffle
    wanting_lunch.each_slice(4) do |lunch_group|
      if lunch_group.count > 1
        UserMailer.lunch_mailing(lunch_group).deliver
        lunch_group.each(&:add_lunch)
      else
        lunch_group.each { |user| UserMailer.sorry_mailing(user).deliver }
      end
    end
    wanting_lunch.each { |user| user.toggle!(:wants_lunch) } 
    flash[:success] = "Mailings sent."
    redirect_to root_path
  end
end
