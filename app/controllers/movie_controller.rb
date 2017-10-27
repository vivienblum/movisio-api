class MovieController < ApplicationController

  def index
    render json: { movies: Movie.all }
  end

  def show
    render json: { movie: Movie.find(params[:id]) }
  end

  def create
    movie = Movie.create(movies_params)
    if movie.valid?
      render json: { movie: movie }
    else
      render json: { error: movie.errors }, status: 403
    end
  end

  private

  def movies_params
    params.require(:movie).permit!
  end
end
