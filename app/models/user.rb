class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_length_of :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false

  has_many :users_movies
  has_many :movies, :through => :users_movies

  has_secure_password

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
