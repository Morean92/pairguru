class MovieDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def cover
    'http://lorempixel.com/100/150/' + %W(abstract nightlife transport).sample + '?a=' + SecureRandom.uuid
  end

  def poster_image
    config = Tmdb::Configuration.get
    base_url = config.images.secure_base_url
    size = config.images.poster_sizes[4]
    image_path = Tmdb::Search.movie(movie.title).results.first.poster_path

    base_url + size + image_path
  end

  def overview
    Tmdb::Search.movie(movie.title).results.first.overview
  end

  def rating
    Tmdb::Search.movie(movie.title).results.first.vote_average
  end
end
 
