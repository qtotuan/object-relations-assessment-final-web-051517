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


class Rating
  attr_accessor :score
  attr_reader :movie, :viewer

  @@all = []

  def initialize(score, movie, viewer)
    @score = score
    @viewer = viewer
    @movie = movie
    self.class.all << self
  end

  def self.all
    @@all
  end


end


class Viewer
  attr_accessor :first_name, :last_name

  @@all = []

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    self.class.all << self
  end

  def self.all
    @@all
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_by_name(name)
    self.all.find { |viewer| viewer.full_name == name}
  end

  def create_rating(score, movie)
    Rating.new(score, movie, self)
  end


end
