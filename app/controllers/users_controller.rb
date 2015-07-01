class UsersController < ApplicationController

  def show
    if current_user
      superhero_matcher = SuperheroMatcher.new(current_user)
      @superhero = superhero_matcher.match
      @scores = Superhero.categorized_scores
      @closest_matches = superhero_matcher.closest_matches
    else
      redirect_to "/auth/twitter"
    end
  end

  def tweet
    superhero_matcher = SuperheroMatcher.new(current_user)
    superhero_match = superhero_matcher.match
    TwitterService.tweet(current_user, superhero_match)
    redirect_to superhero_path(superhero_match)
  end

end
