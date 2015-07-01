require 'rails_helper'

RSpec.describe "logged in user can" do
  before(:each) do
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  def create_superheros
    s = Superhero.create(deck: "Bruce Wayne, who witnessed the murder of his billi...", descripton: "good", gender: "1", name: "Batman", real_name: "Bruce Wayne", image: "http://static.comicvine.com/uploads/scale_medium/6/66303/2961034-screen+shot+2013-04-03+at+5.56.06+am.png", birthday: "Feb 19, 1972", last_name: nil, publisher: "DC Comics", comic_vine_id: "1", sentiment_score: -6)
    s.save
    t = Superhero.create(deck: "Marcus Wayne, who witnessed the murder of his billi...", descripton: "good", gender: "1", name: "fish", real_name: "Bruce Wayne", image: "http://static.comicvine.com/uploads/scale_medium/6/66303/2961034-screen+shot+2013-04-03+at+5.56.06+am.png", birthday: "Feb 19, 1972", last_name: nil, publisher: "DC Comics", comic_vine_id: "2", sentiment_score: -1)
    t.save
    u = Superhero.create(deck: "Phil Wayne, who witnessed the murder of his billi...", descripton: "good", gender: "1", name: "burger", real_name: "Bruce Wayne", image: "http://static.comicvine.com/uploads/scale_medium/6/66303/2961034-screen+shot+2013-04-03+at+5.56.06+am.png", birthday: "Feb 19, 1972", last_name: nil, publisher: "DC Comics", comic_vine_id: "3", sentiment_score: -10)
    u.save
    v = Superhero.create(deck: "Cindy Wayne, who witnessed the murder of his billi...", descripton: "good", gender: "1", name: "marcus", real_name: "Bruce Wayne", image: "http://static.comicvine.com/uploads/scale_medium/6/66303/2961034-screen+shot+2013-04-03+at+5.56.06+am.png", birthday: "Feb 19, 1972", last_name: nil, publisher: "DC Comics", comic_vine_id: "4", sentiment_score: -5)
    v.save
  end


  it "cannot post to Twitter without users secret ouath", vcr: true do
    create_superheros
    visit '/'
    mock_omniauth_user
    click_link "Login with Twitter"
    expect(page).to have_content("Hey hearmemihir, Our spidey senses tell us that you are most like fish!")
    find('img.tweet_icon').click
    expect(page).to have_content("Hey hearmemihir, Our spidey senses tell us that you are most like fish!")
  end
end
