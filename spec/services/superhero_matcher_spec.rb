require 'rails_helper'

RSpec.describe SuperheroMatcher do 
  describe "#match" do 

    it "can match a user with a Superhero with a similar score" do
      user = User.new(sentiment_score: 22)
      superheros = [  Superhero.create!(name: "Cindy", sentiment_score: 50, comic_vine_id: 1), 
                      Superhero.create!(name: "Fly Girl",sentiment_score: 20, comic_vine_id: 2),
                      Superhero.create!(name: "Sam", sentiment_score: -8, comic_vine_id: 3)
                    ]

      hero_matcher = SuperheroMatcher.new(user)

      expect(hero_matcher.match).to eq(superheros.second)
    end

    context "When multiple Superheroes have same score" do
      it "matches the user to the first Superhero" do
        user = User.new(sentiment_score: 22)
        superheros = [  Superhero.create!(name: "Paul", sentiment_score: 50, comic_vine_id: 4), 
                        Superhero.create!(name: "Happy", sentiment_score: 20, comic_vine_id: 5),
                        Superhero.create!(name: "Wendy", sentiment_score: 20, comic_vine_id: 6),
                        Superhero.create!(name: "Peter",sentiment_score: -8, comic_vine_id: 7)
                      ]
        hero_matcher = SuperheroMatcher.new(user)

        expect(hero_matcher.match).to eq(superheros.second)
      end
    end
  end
end