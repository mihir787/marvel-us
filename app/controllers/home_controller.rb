class HomeController < ApplicationController

  def index
    @superheros = Superhero.hero_view(6)
  end
end
