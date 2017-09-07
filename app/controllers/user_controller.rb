class UserController < ApplicationController
  def index
    puts "ACTION INDEX"
    # TODO don't send password
    render json: {status: 'OK', users: User.all }
  end

  def show
    puts "ACTION SHOW"
    render json: {status: 'OK', user: User.find(params[:id]) }
  end

  def create
    puts "ACTION CREATE"
  end

  private

  def users_params
    params.require(:user).permit!
  end
end
