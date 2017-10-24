class Movie < ActiveRecord::Base
  has_many :users_movies, dependent: :destroy
  has_many :users, :through => :users_movies

  scope :all_except, ->(movie) { where.not(id: movie) }
end
