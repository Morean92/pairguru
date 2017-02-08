class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  expose_decorated(:movies) { Movie.includes(:genre).paginate(:page => params[:page], :per_page => 20) }
  expose(:movie)

  def show
    if mov = Tmdb::Search.movie(movie.title)
      poster_path = mov.results.first.poster_path
      @poster_image = "https://image.tmdb.org/t/p/w640/#{poster_path}"
      @overview = mov.results.first.overview
      @rating = mov.results.first.vote_average
    else
      @rating = 'no data'
      @poster_image = ''
      @overview = 'no data'
    end
  end

  def send_info
    MovieInfoMailer.send_info(current_user, movie).deliver_now
    redirect_to :back, notice: 'Email sent with movie info'
  end

  def export
    file_path = 'tmp/movies.csv'
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: 'Movies exported'
  end
end
