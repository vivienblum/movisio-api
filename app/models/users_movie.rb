class UsersMovie < ActiveRecord::Base
  has_many :users
  has_many :movies
  validates_presence_of :user_id
  validates_presence_of :movie_id
end
