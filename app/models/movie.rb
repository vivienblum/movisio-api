class Movie < ActiveRecord::Base
  has_many :users_movies, dependent: :destroy
  has_many :users, :through => :users_movies

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => [ :runtime, :year], :message => "This movie already exist"

  scope :all_except, ->(movie) { where.not(id: movie) }
end
