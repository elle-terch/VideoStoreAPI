class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json( only: [:id, :title, :release_date ])

  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: { id: movie.id, title: movie.title }
    else
      # render_error(:bad_request, movie.errors.messages )
      render json: {}, status: :bad_request
    end
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if movie
      render json: jsonify(movie)
    else
      render json: { errors: { movie_id: ["No such movie"] } }, status: :not_found
    end
  end


  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end

  def jsonify(movie_data)
    return movie_data.as_json( only: [:title, :overview, :release_date, :inventory] )
  end

end
