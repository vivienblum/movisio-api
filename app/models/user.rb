class User < ActiveRecord::Base
  has_many :users_movies
  has_many :movies, :through => :users_movies
end
