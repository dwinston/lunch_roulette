class User < ActiveRecord::Base
  attr_accessible :username, :num_lunches, :wants_lunch

  scope :all_wanting_lunch, where(wants_lunch: true)

  def self.domain
    ENV["USER_DOMAIN"]
  end

  def username
    email && email.split('@')[0]
  end

  def username=(first_dot_last)
    self.email = first_dot_last + '@' + User.domain
  end

  def first_name
    email.split('.')[0].capitalize
  end

  def add_lunch
    self.num_lunches = num_lunches + 1
    save!
  end
end
