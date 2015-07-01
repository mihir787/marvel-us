class CreateSuperheroes < ActiveRecord::Migration
  def change
    create_table :superheroes do |t|
      t.date :birthday
      t.string :deck
      t.string :descripton
      t.integer :gender
      t.string :name
      t.string :real_name
      t.string :image_url
    end
  end
end
