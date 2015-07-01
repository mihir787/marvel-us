class CreateSuperheros < ActiveRecord::Migration
  def change
    create_table :superheros do |t|
      t.string :deck
      t.string :descripton
      t.string :gender
      t.string :name
      t.string :real_name
      t.string :image
      t.string :birthday
      t.string :last_name
      t.string :publisher
      t.string :comic_vine_id
    end
  end
end
