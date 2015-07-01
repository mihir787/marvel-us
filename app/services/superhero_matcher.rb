class SuperheroMatcher
  attr_reader :score

  def initialize(user)
    @score = user.sentiment_score
  end

  def match
    all_best_matches.first
  end

  def closest_matches
    all_best_matches[-3..-1]
  end

  def all_best_matches
    Superhero.order("abs(superheros.sentiment_score - #{score})").limit(4)
  end

end

