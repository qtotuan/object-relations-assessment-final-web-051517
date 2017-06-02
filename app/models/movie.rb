class Movie
  attr_accessor :title

  @@all = []

  def initialize(title)
    self.title = title
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.find_by_title(title)
    self.all.find { |movie| movie.title == title }
  end

  def ratings
    Rating.all.select { |rating| rating.movie == self }
  end

  def viewers
    ratings.map do |rating|
      rating.viewer
    end.uniq
  end

  def average_rating
    # binding.pry
    ratings.map { |rating| rating.score }.inject(:+).to_f / ratings.size
  end

end
