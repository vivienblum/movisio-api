class UsersMovie < ActiveRecord::Base
  has_many :users
  has_many :movies

  validates_presence_of :user_id
  validates_presence_of :movie_id

  validates_uniqueness_of :user_id, :scope => [ :movie_id], :message => "You already have this movie"
end
