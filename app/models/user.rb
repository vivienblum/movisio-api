class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true

  has_many :users_movies
  has_many :movies, :through => :users_movies

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
