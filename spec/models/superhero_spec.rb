require 'rails_helper'

RSpec.describe type: :model do
  superhero = Superhero.create(name: "Lori Wonderous", deck: "She's a Texas Girl in Denver", comic_vine_id: 11, birthday: "Nov 9, 1989")

  it "is valid when it has a name and comic_vine_id" do
    expect(superhero).to be_valid
  end  

  it "is not valid when name is nil" do
    superhero = Superhero.create(name: nil, deck: "She's a Texas Girl in Denver", comic_vine_id: 10, birthday: "Nov 9, 1989")

    expect(superhero).not_to be_valid
  end

  it "is not valid when comic_vine_id is nil" do
    superhero = Superhero.create(name: "Fabulous", deck: "She's a Texas Girl in Denver", comic_vine_id: nil, birthday: "Nov 9, 1989")

    expect(superhero).not_to be_valid
  end

  it "is not valid when duplicate name is trying to be created" do
    superhero = Superhero.create(name: "Fabulous", deck: "She's a Texas Girl in Denver", comic_vine_id: 7, birthday: "Nov 9, 1989")
    superhero2 = Superhero.create(name: "Fabulous", deck: "She's a Texas Girl in Denver", comic_vine_id: 8, birthday: "Nov 9, 1989")

    expect(superhero2).not_to be_valid
  end

  it "is not valid when duplicate comic_vine_id is trying to be created" do
    superhero = Superhero.create(name: "Sammi", deck: "She's a Texas Girl in Denver", comic_vine_id: 7, birthday: "Nov 9, 1989")
    superhero2 = Superhero.create(name: "Fabulous", deck: "She's a Texas Girl in Denver", comic_vine_id: 7, birthday: "Nov 9, 1989")

    expect(superhero2).not_to be_valid
  end
end