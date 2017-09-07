class UserController < ApplicationController
  def index
    puts "ACTION INDEX"
    render json: {status: 'OK', users: User.all }
  end

  def show
    puts "ACTION SHOW"
  end

  def create
    puts "ACTION CREATE"
  end
end
