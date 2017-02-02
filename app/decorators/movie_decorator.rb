class MovieDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def cover
    'http://lorempixel.com/100/150/' + %W(abstract nightlife transport).sample + '?a=' + SecureRandom.uuid
  end
end
 
