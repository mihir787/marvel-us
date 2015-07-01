require 'rails_helper'

RSpec.describe type: :feature do 
  it "can visit superheroes page" do 
    visit '/'
    click_link 'Superheroes'
    expect(current_path).to eq(superheroes_path)
  end    

  it "can view superheroes on superheroes page", vcr: true do 
    visit '/superheroes'

    within(".superheros") do
      expect(page).to have_content("SHEROES")
    end
  end
end    

