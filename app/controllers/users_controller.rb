class UsersController < ApplicationController
  http_basic_authenticate_with name: ENV["USER_NAME"], password: ENV["USER_PASSWORD"]

  def new
    @user = User.find_by_email(cookies[:lunch_roulette_email]) || User.new
  end

  def create
    @user = User.find_or_create_by_email(params[:user][:username] + '@' + User.domain)
    if @user.valid?
      cookies.permanent[:lunch_roulette_email] = @user.email
      @user.update_attribute(:wants_lunch, params[:user][:wants_lunch])
      if @user.wants_lunch
        flash[:success] = "Thanks, #{@user.first_name}! You'll get an email by noon with your lunch group." 
      else
        flash[:alert] = "That's unfortunate, #{@user.first_name}. Come back and check the box by 11am if you change your mind."
      end
      redirect_to root_path
    else
      render 'new'
    end
  end
end
