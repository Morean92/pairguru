class GenreDecorator < Draper::Decorator
  delegate_all
  decorates_association :movies

  def number_of_movies
    object.movies.count
  end

  def created_at
    object.created_at.strftime("%e %B %Y")
  end
end
