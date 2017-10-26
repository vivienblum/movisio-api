class MovieController < ApplicationController

  def index
    render json: { movies: Movie.all }
  end

  def show
    render json: { movie: Movie.find(params[:id]) }
  end

  def create
    render json: { movie: Movie.create(movies_params) }
  end

  private

  def movies_params
    params.require(:movie).permit!
  end
end
